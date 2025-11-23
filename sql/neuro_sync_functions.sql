--------------------------------------------------------------------
-- NEURO-SYNC - FUNCTIONS DE REGRA DE NEGÓCIO
-- FNC_CALC_INDICE_CONFORTO
-- FNC_RESERVA_COMPATIVEL
-- FNC_TAXA_OCUPACAO_ESTACAO
--------------------------------------------------------------------

--------------------------------------------------------------------
-- 1) FNC_CALC_INDICE_CONFORTO
--  Calcula um índice de conforto (0-100) para uma estação em um período,
--  utilizando média de RUÍDO (dB) e LUMINOSIDADE (lux) das leituras.
--
--  Regras simplificadas:
--   - Ruído: <=40 dB -> 100 pontos; >=70 dB -> 0; entre 40 e 70 interpolação linear.
--   - Luz: ideal entre 300 e 500 lux -> 100 pontos;
--          <=100 ou >=800 -> 0; entre faixas, interpolação.
--   - Índice final = média dos scores disponíveis (ruído/luz).
--
--  Parâmetros:
--    p_id_estacao  -> estação de trabalho
--    p_data_inicio -> início do período
--    p_data_fim    -> fim do período
--
--  Retorno:
--    NUMBER com valor entre 0 e 100 (duas casas), ou NULL se não houver dados.
--------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FNC_CALC_INDICE_CONFORTO (
    p_id_estacao  IN ESTACAO_TRABALHO.ID_ESTACAO%TYPE,
    p_data_inicio IN DATE,
    p_data_fim    IN DATE
) RETURN NUMBER IS
    v_avg_ruido   NUMBER;
    v_avg_lux     NUMBER;
    v_score_ruido NUMBER;
    v_score_lux   NUMBER;
    v_indice      NUMBER;
BEGIN
    -- Validação básica de período
    IF p_id_estacao IS NULL THEN
        RAISE_APPLICATION_ERROR(-22000, 'FNC_CALC_INDICE_CONFORTO: ID_ESTACAO não informado.');
    END IF;

    IF p_data_inicio IS NULL OR p_data_fim IS NULL OR p_data_inicio >= p_data_fim THEN
        RAISE_APPLICATION_ERROR(-22001, 'FNC_CALC_INDICE_CONFORTO: Período inválido para cálculo de conforto.');
    END IF;

    -- Médias de RUÍDO e LUMINOSIDADE no período
    SELECT
        AVG(CASE WHEN ts.NOME_TIPO_SENSOR = 'RUIDO'        THEN ls.VALOR_MEDIDO END),
        AVG(CASE WHEN ts.NOME_TIPO_SENSOR = 'LUMINOSIDADE' THEN ls.VALOR_MEDIDO END)
    INTO
        v_avg_ruido,
        v_avg_lux
    FROM LEITURA_SENSOR ls
    JOIN SENSOR s
      ON s.ID_SENSOR = ls.ID_SENSOR
    JOIN TIPO_SENSOR ts
      ON ts.ID_TIPO_SENSOR = s.ID_TIPO_SENSOR
   WHERE s.ID_ESTACAO = p_id_estacao
     AND ls.DATA_HORA_LEITURA BETWEEN p_data_inicio AND p_data_fim;

    -- Se não houver dados de nenhum tipo, retorna NULL
    IF v_avg_ruido IS NULL AND v_avg_lux IS NULL THEN
        RETURN NULL;
    END IF;

    ----------------------------------------------------------------
    -- Score de RUÍDO (0-100)
    ----------------------------------------------------------------
    IF v_avg_ruido IS NOT NULL THEN
        IF v_avg_ruido <= 40 THEN
            v_score_ruido := 100;
        ELSIF v_avg_ruido >= 70 THEN
            v_score_ruido := 0;
        ELSE
            -- Interpolação linear entre 40 e 70 dB
            v_score_ruido := 100 - ((v_avg_ruido - 40) / 30) * 100;
        END IF;
    ELSE
        v_score_ruido := NULL;
    END IF;

    ----------------------------------------------------------------
    -- Score de LUMINOSIDADE (0-100)
    ----------------------------------------------------------------
    IF v_avg_lux IS NOT NULL THEN
        IF v_avg_lux BETWEEN 300 AND 500 THEN
            v_score_lux := 100;
        ELSIF v_avg_lux <= 100 OR v_avg_lux >= 800 THEN
            v_score_lux := 0;
        ELSIF v_avg_lux < 300 THEN
            -- Sobe de 0 para 100 entre 100 e 300 lux
            v_score_lux := ((v_avg_lux - 100) / 200) * 100;
        ELSE
            -- Cai de 100 para 0 entre 500 e 800 lux
            v_score_lux := ((800 - v_avg_lux) / 300) * 100;
        END IF;
    ELSE
        v_score_lux := NULL;
    END IF;

    ----------------------------------------------------------------
    -- Índice final (média dos scores disponíveis)
    ----------------------------------------------------------------
    IF v_score_ruido IS NOT NULL AND v_score_lux IS NOT NULL THEN
        v_indice := (v_score_ruido + v_score_lux) / 2;
    ELSIF v_score_ruido IS NOT NULL THEN
        v_indice := v_score_ruido;
    ELSE
        v_indice := v_score_lux;
    END IF;

    RETURN ROUND(v_indice, 2);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-22002, 'FNC_CALC_INDICE_CONFORTO - Erro: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- 2) FNC_RESERVA_COMPATIVEL
--  Verifica se uma reserva é compatível com as preferências sensoriais
--  ativas do usuário (ruído máximo, faixa de luz).
--
--  Regras simplificadas:
--   - Busca reserva (usuário, estação, período).
--   - Busca preferência ativa do usuário na data de início da reserva.
--   - Calcula ruído/luz médios da estação no período da reserva.
--   - Compatível se:
--        ruído_médio <= ruido_max_db (quando informado) E
--        luz_média entre luz_min_lux e luz_max_lux (quando ambos informados).
--   - Se não houver preferência registrada -> retorna 'S' (compatível por padrão).
--   - Se não houver leituras de sensor -> retorna NULL (indeterminado).
--
--  Parâmetros:
--    p_id_reserva -> reserva a ser avaliada
--
--  Retorno:
--    'S' = compatível
--    'N' = não compatível
--    NULL = indeterminado (sem dados de sensor)
--------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FNC_RESERVA_COMPATIVEL (
    p_id_reserva IN RESERVA_ESTACAO.ID_RESERVA%TYPE
) RETURN CHAR IS
    ----------------------------------------------------------------
    -- Dados da reserva
    ----------------------------------------------------------------
    v_id_usuario RESERVA_ESTACAO.ID_USUARIO%TYPE;
    v_id_estacao RESERVA_ESTACAO.ID_ESTACAO%TYPE;
    v_dt_ini     RESERVA_ESTACAO.DATA_HORA_INICIO_PREVISTA%TYPE;
    v_dt_fim     RESERVA_ESTACAO.DATA_HORA_FIM_PREVISTA%TYPE;

    ----------------------------------------------------------------
    -- Preferências do usuário
    ----------------------------------------------------------------
    v_ruido_max  PREFERENCIA_SENSORIAL.RUIDO_MAX_DB%TYPE;
    v_luz_min    PREFERENCIA_SENSORIAL.LUZ_MIN_LUX%TYPE;
    v_luz_max    PREFERENCIA_SENSORIAL.LUZ_MAX_LUX%TYPE;

    ----------------------------------------------------------------
    -- Médias medidas pelos sensores
    ----------------------------------------------------------------
    v_avg_ruido  NUMBER;
    v_avg_lux    NUMBER;
BEGIN
    IF p_id_reserva IS NULL THEN
        RAISE_APPLICATION_ERROR(-22010, 'FNC_RESERVA_COMPATIVEL: ID_RESERVA não informado.');
    END IF;

    ----------------------------------------------------------------
    -- Buscar dados da reserva
    ----------------------------------------------------------------
    SELECT ID_USUARIO,
           ID_ESTACAO,
           DATA_HORA_INICIO_PREVISTA,
           DATA_HORA_FIM_PREVISTA
      INTO v_id_usuario,
           v_id_estacao,
           v_dt_ini,
           v_dt_fim
      FROM RESERVA_ESTACAO
     WHERE ID_RESERVA = p_id_reserva;

    IF v_dt_ini IS NULL OR v_dt_fim IS NULL OR v_dt_ini >= v_dt_fim THEN
        RAISE_APPLICATION_ERROR(-22011, 'FNC_RESERVA_COMPATIVEL: Período da reserva inválido.');
    END IF;

    ----------------------------------------------------------------
    -- Buscar preferência sensorial ativa do usuário
    ----------------------------------------------------------------
    BEGIN
        SELECT RUIDO_MAX_DB,
               LUZ_MIN_LUX,
               LUZ_MAX_LUX
          INTO v_ruido_max,
               v_luz_min,
               v_luz_max
          FROM PREFERENCIA_SENSORIAL
         WHERE ID_USUARIO = v_id_usuario
           AND ATIVO = 'S'
           AND DATA_INICIO_VIGENCIA <= v_dt_ini
           AND (DATA_FIM_VIGENCIA IS NULL OR DATA_FIM_VIGENCIA >= v_dt_ini)
           AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Sem preferência registrada -> considera compatível por padrão
            RETURN 'S';
    END;

    ----------------------------------------------------------------
    -- Média de RUÍDO na estação durante o período da reserva
    ----------------------------------------------------------------
    SELECT AVG(ls.VALOR_MEDIDO)
      INTO v_avg_ruido
      FROM LEITURA_SENSOR ls
      JOIN SENSOR s
        ON s.ID_SENSOR = ls.ID_SENSOR
      JOIN TIPO_SENSOR ts
        ON ts.ID_TIPO_SENSOR = s.ID_TIPO_SENSOR
     WHERE s.ID_ESTACAO = v_id_estacao
       AND ls.DATA_HORA_LEITURA BETWEEN v_dt_ini AND v_dt_fim
       AND ts.NOME_TIPO_SENSOR = 'RUIDO';

    ----------------------------------------------------------------
    -- Média de LUMINOSIDADE na estação durante o período da reserva
    ----------------------------------------------------------------
    SELECT AVG(ls.VALOR_MEDIDO)
      INTO v_avg_lux
      FROM LEITURA_SENSOR ls
      JOIN SENSOR s
        ON s.ID_SENSOR = ls.ID_SENSOR
      JOIN TIPO_SENSOR ts
        ON ts.ID_TIPO_SENSOR = s.ID_TIPO_SENSOR
     WHERE s.ID_ESTACAO = v_id_estacao
       AND ls.DATA_HORA_LEITURA BETWEEN v_dt_ini AND v_dt_fim
       AND ts.NOME_TIPO_SENSOR = 'LUMINOSIDADE';

    -- Se não houver dados de nenhum tipo, resultado indeterminado
    IF v_avg_ruido IS NULL AND v_avg_lux IS NULL THEN
        RETURN NULL;
    END IF;

    ----------------------------------------------------------------
    -- Verificações de compatibilidade
    ----------------------------------------------------------------
    -- RUÍDO: média não pode exceder o limite do usuário
    IF v_ruido_max IS NOT NULL AND v_avg_ruido IS NOT NULL THEN
        IF v_avg_ruido > v_ruido_max THEN
            RETURN 'N';
        END IF;
    END IF;

    -- LUZ: média deve estar entre os limites do usuário
    IF v_luz_min IS NOT NULL AND v_luz_max IS NOT NULL AND v_avg_lux IS NOT NULL THEN
        IF v_avg_lux < v_luz_min OR v_avg_lux > v_luz_max THEN
            RETURN 'N';
        END IF;
    END IF;

    RETURN 'S';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-22012, 'FNC_RESERVA_COMPATIVEL: Reserva não encontrada.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-22013, 'FNC_RESERVA_COMPATIVEL - Erro: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- 3) FNC_TAXA_OCUPACAO_ESTACAO
--  Calcula a taxa de ocupação (%) de uma estação em um período,
--  considerando as reservas com status relevantes.
--
--  Regras simplificadas:
--   - Considera reservas da estação que tenham interseção com o período.
--   - Usa intervalo previsto (DATA_HORA_INICIO_PREVISTA / FIM_PREVISTA);
--     (poderia ser adaptado para usar check-in/out).
--   - Filtra status de reserva "ativos" (ex: CONFIRMADA, EM_USO, CONCLUIDA).
--   - Taxa = (tempo_reservado / tempo_total_periodo) * 100.
--
--  IMPORTANTE:
--   - Espera-se que existam registros em STATUS_RESERVA com
--     CODIGO_STATUS = 'CONFIRMADA', 'EM_USO', 'CONCLUIDA'.
--
--  Parâmetros:
--    p_id_estacao  -> estação alvo
--    p_data_inicio -> início do período
--    p_data_fim    -> fim do período
--
--  Retorno:
--    NUMBER com valor entre 0 e 100 (duas casas).
--------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FNC_TAXA_OCUPACAO_ESTACAO (
    p_id_estacao  IN ESTACAO_TRABALHO.ID_ESTACAO%TYPE,
    p_data_inicio IN DATE,
    p_data_fim    IN DATE
) RETURN NUMBER IS
    v_total_segundos    NUMBER;
    v_segundos_ocupados NUMBER;
BEGIN
    IF p_id_estacao IS NULL THEN
        RAISE_APPLICATION_ERROR(-22020, 'FNC_TAXA_OCUPACAO_ESTACAO: ID_ESTACAO não informado.');
    END IF;

    IF p_data_inicio IS NULL OR p_data_fim IS NULL OR p_data_inicio >= p_data_fim THEN
        RAISE_APPLICATION_ERROR(-22021, 'FNC_TAXA_OCUPACAO_ESTACAO: Período inválido.');
    END IF;

    -- Total de segundos do período analisado
    v_total_segundos := (p_data_fim - p_data_inicio) * 24 * 60 * 60;

    ----------------------------------------------------------------
    -- Soma do tempo reservado (em segundos) no período
    -- Considera apenas reservas cujo status está em CONFIRMADA, EM_USO, CONCLUIDA
    ----------------------------------------------------------------
    SELECT NVL(SUM(
               (LEAST(r.DATA_HORA_FIM_PREVISTA,  p_data_fim)
              - GREATEST(r.DATA_HORA_INICIO_PREVISTA, p_data_inicio))
               * 24 * 60 * 60
           ), 0)
      INTO v_segundos_ocupados
      FROM RESERVA_ESTACAO r
      JOIN STATUS_RESERVA sr
        ON sr.ID_STATUS_RESERVA = r.ID_STATUS_RESERVA
     WHERE r.ID_ESTACAO = p_id_estacao
       AND r.DATA_HORA_INICIO_PREVISTA < p_data_fim
       AND r.DATA_HORA_FIM_PREVISTA    > p_data_inicio
       AND sr.CODIGO_STATUS IN ('CONFIRMADA', 'EM_USO', 'CONCLUIDA');

    IF v_total_segundos <= 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND( (v_segundos_ocupados / v_total_segundos) * 100, 2 );

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-22022, 'FNC_TAXA_OCUPACAO_ESTACAO - Erro: ' || SQLERRM);
END;
/
