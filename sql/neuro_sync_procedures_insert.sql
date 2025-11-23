--------------------------------------------------------------------
-- NEURO-SYNC - PROCEDURES DE INSERT
--------------------------------------------------------------------

--------------------------------------------------------------------
-- EMPRESA
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_EMPRESA (
    p_razao_social         IN EMPRESA.RAZAO_SOCIAL%TYPE,
    p_nome_fantasia        IN EMPRESA.NOME_FANTASIA%TYPE DEFAULT NULL,
    p_cnpj                 IN EMPRESA.CNPJ%TYPE,
    p_email_corporativo    IN EMPRESA.EMAIL_CORPORATIVO%TYPE DEFAULT NULL,
    p_telefone_corporativo IN EMPRESA.TELEFONE_CORPORATIVO%TYPE DEFAULT NULL,
    p_status_ativo         IN EMPRESA.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_empresa_out       OUT EMPRESA.ID_EMPRESA%TYPE
) IS
BEGIN
    INSERT INTO EMPRESA (
        ID_EMPRESA,
        RAZAO_SOCIAL,
        NOME_FANTASIA,
        CNPJ,
        EMAIL_CORPORATIVO,
        TELEFONE_CORPORATIVO,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_razao_social,
        p_nome_fantasia,
        p_cnpj,
        p_email_corporativo,
        p_telefone_corporativo,
        p_status_ativo
    )
    RETURNING ID_EMPRESA INTO p_id_empresa_out;

    DBMS_OUTPUT.PUT_LINE('EMPRESA inserida com ID ' || p_id_empresa_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21000, 'Erro ao inserir EMPRESA: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- FILIAL
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_FILIAL (
    p_id_empresa    IN FILIAL.ID_EMPRESA%TYPE,
    p_nome_filial   IN FILIAL.NOME_FILIAL%TYPE,
    p_codigo_filial IN FILIAL.CODIGO_FILIAL%TYPE DEFAULT NULL,
    p_cidade        IN FILIAL.CIDADE%TYPE DEFAULT NULL,
    p_uf            IN FILIAL.UF%TYPE DEFAULT NULL,
    p_pais          IN FILIAL.PAIS%TYPE DEFAULT NULL,
    p_endereco      IN FILIAL.ENDERECO%TYPE DEFAULT NULL,
    p_status_ativo  IN FILIAL.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_filial_out OUT FILIAL.ID_FILIAL%TYPE
) IS
BEGIN
    INSERT INTO FILIAL (
        ID_FILIAL,
        ID_EMPRESA,
        NOME_FILIAL,
        CODIGO_FILIAL,
        CIDADE,
        UF,
        PAIS,
        ENDERECO,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_id_empresa,
        p_nome_filial,
        p_codigo_filial,
        p_cidade,
        p_uf,
        p_pais,
        p_endereco,
        p_status_ativo
    )
    RETURNING ID_FILIAL INTO p_id_filial_out;

    DBMS_OUTPUT.PUT_LINE('FILIAL inserida com ID ' || p_id_filial_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21001, 'Erro ao inserir FILIAL: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- SETOR
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_SETOR (
    p_id_filial     IN SETOR.ID_FILIAL%TYPE,
    p_nome_setor    IN SETOR.NOME_SETOR%TYPE,
    p_codigo_setor  IN SETOR.CODIGO_SETOR%TYPE DEFAULT NULL,
    p_andar         IN SETOR.ANDAR%TYPE DEFAULT NULL,
    p_descricao     IN SETOR.DESCRICAO%TYPE DEFAULT NULL,
    p_status_ativo  IN SETOR.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_setor_out  OUT SETOR.ID_SETOR%TYPE
) IS
BEGIN
    INSERT INTO SETOR (
        ID_SETOR,
        ID_FILIAL,
        NOME_SETOR,
        CODIGO_SETOR,
        ANDAR,
        DESCRICAO,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_id_filial,
        p_nome_setor,
        p_codigo_setor,
        p_andar,
        p_descricao,
        p_status_ativo
    )
    RETURNING ID_SETOR INTO p_id_setor_out;

    DBMS_OUTPUT.PUT_LINE('SETOR inserido com ID ' || p_id_setor_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21002, 'Erro ao inserir SETOR: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- PERFIL
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_PERFIL (
    p_nome_perfil   IN PERFIL.NOME_PERFIL%TYPE,
    p_descricao     IN PERFIL.DESCRICAO%TYPE DEFAULT NULL,
    p_nivel_acesso  IN PERFIL.NIVEL_ACESSO%TYPE DEFAULT NULL,
    p_status_ativo  IN PERFIL.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_perfil_out OUT PERFIL.ID_PERFIL%TYPE
) IS
BEGIN
    INSERT INTO PERFIL (
        ID_PERFIL,
        NOME_PERFIL,
        DESCRICAO,
        NIVEL_ACESSO,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_nome_perfil,
        p_descricao,
        p_nivel_acesso,
        p_status_ativo
    )
    RETURNING ID_PERFIL INTO p_id_perfil_out;

    DBMS_OUTPUT.PUT_LINE('PERFIL inserido com ID ' || p_id_perfil_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21003, 'Erro ao inserir PERFIL: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- USUARIO
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_USUARIO (
    p_id_setor             IN USUARIO.ID_SETOR%TYPE,
    p_nome_completo        IN USUARIO.NOME_COMPLETO%TYPE,
    p_email_corporativo    IN USUARIO.EMAIL_CORPORATIVO%TYPE,
    p_matricula_interna    IN USUARIO.MATRICULA_INTERNA%TYPE DEFAULT NULL,
    p_telefone             IN USUARIO.TELEFONE%TYPE DEFAULT NULL,
    p_data_admissao        IN USUARIO.DATA_ADMISSAO%TYPE DEFAULT NULL,
    p_status_ativo         IN USUARIO.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_flag_neurodivergente IN USUARIO.FLAG_NEURODIVERGENTE%TYPE DEFAULT 'N',
    p_observacoes_suporte  IN USUARIO.OBSERVACOES_SUPORTE%TYPE DEFAULT NULL,
    p_senha_hash           IN USUARIO.SENHA_HASH%TYPE,
    p_id_usuario_out       OUT USUARIO.ID_USUARIO%TYPE
) IS
BEGIN
    INSERT INTO USUARIO (
        ID_USUARIO,
        ID_SETOR,
        NOME_COMPLETO,
        EMAIL_CORPORATIVO,
        MATRICULA_INTERNA,
        TELEFONE,
        DATA_ADMISSAO,
        STATUS_ATIVO,
        FLAG_NEURODIVERGENTE,
        OBSERVACOES_SUPORTE,
        SENHA_HASH
    ) VALUES (
        NULL,
        p_id_setor,
        p_nome_completo,
        p_email_corporativo,
        p_matricula_interna,
        p_telefone,
        p_data_admissao,
        p_status_ativo,
        p_flag_neurodivergente,
        p_observacoes_suporte,
        p_senha_hash
    )
    RETURNING ID_USUARIO INTO p_id_usuario_out;

    DBMS_OUTPUT.PUT_LINE('USUARIO inserido com ID ' || p_id_usuario_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21004, 'Erro ao inserir USUARIO: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- USUARIO_PERFIL (N:N)
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_USUARIO_PERFIL (
    p_id_usuario          IN USUARIO_PERFIL.ID_USUARIO%TYPE,
    p_id_perfil           IN USUARIO_PERFIL.ID_PERFIL%TYPE,
    p_usuario_responsavel IN USUARIO_PERFIL.USUARIO_RESPONSAVEL%TYPE DEFAULT NULL,
    p_status_ativo        IN USUARIO_PERFIL.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_usuario_perfil_out OUT USUARIO_PERFIL.ID_USUARIO_PERFIL%TYPE
) IS
BEGIN
    INSERT INTO USUARIO_PERFIL (
        ID_USUARIO_PERFIL,
        ID_USUARIO,
        ID_PERFIL,
        DATA_ATRIBUICAO,
        USUARIO_RESPONSAVEL,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_id_usuario,
        p_id_perfil,
        SYSDATE,
        p_usuario_responsavel,
        p_status_ativo
    )
    RETURNING ID_USUARIO_PERFIL INTO p_id_usuario_perfil_out;

    DBMS_OUTPUT.PUT_LINE('USUARIO_PERFIL inserido com ID ' || p_id_usuario_perfil_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21005, 'Erro ao inserir USUARIO_PERFIL: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- PREFERENCIA_SENSORIAL
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_PREFERENCIA_SENSORIAL (
    p_id_usuario              IN PREFERENCIA_SENSORIAL.ID_USUARIO%TYPE,
    p_ruido_max_db            IN PREFERENCIA_SENSORIAL.RUIDO_MAX_DB%TYPE DEFAULT NULL,
    p_luz_min_lux             IN PREFERENCIA_SENSORIAL.LUZ_MIN_LUX%TYPE DEFAULT NULL,
    p_luz_max_lux             IN PREFERENCIA_SENSORIAL.LUZ_MAX_LUX%TYPE DEFAULT NULL,
    p_tolerancia_visual       IN PREFERENCIA_SENSORIAL.TOLERANCIA_VISUAL%TYPE DEFAULT NULL,
    p_prefere_zona            IN PREFERENCIA_SENSORIAL.PREFERE_ZONA%TYPE DEFAULT NULL,
    p_observacoes_preferencia IN PREFERENCIA_SENSORIAL.OBSERVACOES_PREFERENCIA%TYPE DEFAULT NULL,
    p_data_inicio_vigencia    IN PREFERENCIA_SENSORIAL.DATA_INICIO_VIGENCIA%TYPE,
    p_data_fim_vigencia       IN PREFERENCIA_SENSORIAL.DATA_FIM_VIGENCIA%TYPE DEFAULT NULL,
    p_ativo                   IN PREFERENCIA_SENSORIAL.ATIVO%TYPE DEFAULT 'S',
    p_id_preferencia_out      OUT PREFERENCIA_SENSORIAL.ID_PREFERENCIA%TYPE
) IS
BEGIN
    INSERT INTO PREFERENCIA_SENSORIAL (
        ID_PREFERENCIA,
        ID_USUARIO,
        RUIDO_MAX_DB,
        LUZ_MIN_LUX,
        LUZ_MAX_LUX,
        TOLERANCIA_VISUAL,
        PREFERE_ZONA,
        OBSERVACOES_PREFERENCIA,
        DATA_INICIO_VIGENCIA,
        DATA_FIM_VIGENCIA,
        ATIVO
    ) VALUES (
        NULL,
        p_id_usuario,
        p_ruido_max_db,
        p_luz_min_lux,
        p_luz_max_lux,
        p_tolerancia_visual,
        p_prefere_zona,
        p_observacoes_preferencia,
        p_data_inicio_vigencia,
        p_data_fim_vigencia,
        p_ativo
    )
    RETURNING ID_PREFERENCIA INTO p_id_preferencia_out;

    DBMS_OUTPUT.PUT_LINE('PREFERENCIA_SENSORIAL inserida com ID ' || p_id_preferencia_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21006, 'Erro ao inserir PREFERENCIA_SENSORIAL: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- ZONA_SENSORIAL
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_ZONA_SENSORIAL (
    p_id_filial               IN ZONA_SENSORIAL.ID_FILIAL%TYPE,
    p_nome_zona               IN ZONA_SENSORIAL.NOME_ZONA%TYPE,
    p_tipo_zona               IN ZONA_SENSORIAL.TIPO_ZONA%TYPE DEFAULT NULL,
    p_descricao               IN ZONA_SENSORIAL.DESCRICAO%TYPE DEFAULT NULL,
    p_ruido_medio_estimado_db IN ZONA_SENSORIAL.RUIDO_MEDIO_ESTIMADO_DB%TYPE DEFAULT NULL,
    p_luz_media_estimado_lux  IN ZONA_SENSORIAL.LUZ_MEDIA_ESTIMADO_LUX%TYPE DEFAULT NULL,
    p_caracteristica_visual   IN ZONA_SENSORIAL.CARACTERISTICA_VISUAL%TYPE DEFAULT NULL,
    p_capacidade_estimada     IN ZONA_SENSORIAL.CAPACIDADE_ESTIMADA%TYPE DEFAULT NULL,
    p_status_ativo            IN ZONA_SENSORIAL.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_zona_out             OUT ZONA_SENSORIAL.ID_ZONA%TYPE
) IS
BEGIN
    INSERT INTO ZONA_SENSORIAL (
        ID_ZONA,
        ID_FILIAL,
        NOME_ZONA,
        TIPO_ZONA,
        DESCRICAO,
        RUIDO_MEDIO_ESTIMADO_DB,
        LUZ_MEDIA_ESTIMADO_LUX,
        CARACTERISTICA_VISUAL,
        CAPACIDADE_ESTIMADA,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_id_filial,
        p_nome_zona,
        p_tipo_zona,
        p_descricao,
        p_ruido_medio_estimado_db,
        p_luz_media_estimado_lux,
        p_caracteristica_visual,
        p_capacidade_estimada,
        p_status_ativo
    )
    RETURNING ID_ZONA INTO p_id_zona_out;

    DBMS_OUTPUT.PUT_LINE('ZONA_SENSORIAL inserida com ID ' || p_id_zona_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21007, 'Erro ao inserir ZONA_SENSORIAL: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- ESTACAO_TRABALHO
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_ESTACAO_TRABALHO (
    p_id_zona                IN ESTACAO_TRABALHO.ID_ZONA%TYPE,
    p_codigo_estacao         IN ESTACAO_TRABALHO.CODIGO_ESTACAO%TYPE,
    p_descricao              IN ESTACAO_TRABALHO.DESCRICAO%TYPE DEFAULT NULL,
    p_permite_reserva        IN ESTACAO_TRABALHO.PERMITE_RESERVA%TYPE DEFAULT 'S',
    p_permite_uso_espontaneo IN ESTACAO_TRABALHO.PERMITE_USO_ESPONTANEO%TYPE DEFAULT 'S',
    p_status_estacao         IN ESTACAO_TRABALHO.STATUS_ESTACAO%TYPE DEFAULT 'ATIVA',
    p_observacoes            IN ESTACAO_TRABALHO.OBSERVACOES%TYPE DEFAULT NULL,
    p_id_estacao_out         OUT ESTACAO_TRABALHO.ID_ESTACAO%TYPE
) IS
BEGIN
    INSERT INTO ESTACAO_TRABALHO (
        ID_ESTACAO,
        ID_ZONA,
        CODIGO_ESTACAO,
        DESCRICAO,
        PERMITE_RESERVA,
        PERMITE_USO_ESPONTANEO,
        STATUS_ESTACAO,
        OBSERVACOES
    ) VALUES (
        NULL,
        p_id_zona,
        p_codigo_estacao,
        p_descricao,
        p_permite_reserva,
        p_permite_uso_espontaneo,
        p_status_estacao,
        p_observacoes
    )
    RETURNING ID_ESTACAO INTO p_id_estacao_out;

    DBMS_OUTPUT.PUT_LINE('ESTACAO_TRABALHO inserida com ID ' || p_id_estacao_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21008, 'Erro ao inserir ESTACAO_TRABALHO: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- TIPO_SENSOR
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_TIPO_SENSOR (
    p_nome_tipo_sensor IN TIPO_SENSOR.NOME_TIPO_SENSOR%TYPE,
    p_unidade_medida   IN TIPO_SENSOR.UNIDADE_MEDIDA%TYPE DEFAULT NULL,
    p_descricao        IN TIPO_SENSOR.DESCRICAO%TYPE DEFAULT NULL,
    p_status_ativo     IN TIPO_SENSOR.STATUS_ATIVO%TYPE DEFAULT 'S',
    p_id_tipo_sensor_out OUT TIPO_SENSOR.ID_TIPO_SENSOR%TYPE
) IS
BEGIN
    INSERT INTO TIPO_SENSOR (
        ID_TIPO_SENSOR,
        NOME_TIPO_SENSOR,
        UNIDADE_MEDIDA,
        DESCRICAO,
        STATUS_ATIVO
    ) VALUES (
        NULL,
        p_nome_tipo_sensor,
        p_unidade_medida,
        p_descricao,
        p_status_ativo
    )
    RETURNING ID_TIPO_SENSOR INTO p_id_tipo_sensor_out;

    DBMS_OUTPUT.PUT_LINE('TIPO_SENSOR inserido com ID ' || p_id_tipo_sensor_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21009, 'Erro ao inserir TIPO_SENSOR: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- SENSOR
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_SENSOR (
    p_id_estacao           IN SENSOR.ID_ESTACAO%TYPE,
    p_id_tipo_sensor       IN SENSOR.ID_TIPO_SENSOR%TYPE,
    p_identificador_hw     IN SENSOR.IDENTIFICADOR_HARDWARE%TYPE,
    p_data_instalacao      IN SENSOR.DATA_INSTALACAO%TYPE DEFAULT NULL,
    p_data_ultima_manutencao IN SENSOR.DATA_ULTIMA_MANUTENCAO%TYPE DEFAULT NULL,
    p_status_sensor        IN SENSOR.STATUS_SENSOR%TYPE DEFAULT 'ATIVO',
    p_observacoes          IN SENSOR.OBSERVACOES%TYPE DEFAULT NULL,
    p_id_sensor_out        OUT SENSOR.ID_SENSOR%TYPE
) IS
BEGIN
    INSERT INTO SENSOR (
        ID_SENSOR,
        ID_ESTACAO,
        ID_TIPO_SENSOR,
        IDENTIFICADOR_HARDWARE,
        DATA_INSTALACAO,
        DATA_ULTIMA_MANUTENCAO,
        STATUS_SENSOR,
        OBSERVACOES
    ) VALUES (
        NULL,
        p_id_estacao,
        p_id_tipo_sensor,
        p_identificador_hw,
        p_data_instalacao,
        p_data_ultima_manutencao,
        p_status_sensor,
        p_observacoes
    )
    RETURNING ID_SENSOR INTO p_id_sensor_out;

    DBMS_OUTPUT.PUT_LINE('SENSOR inserido com ID ' || p_id_sensor_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21010, 'Erro ao inserir SENSOR: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- LEITURA_SENSOR
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_LEITURA_SENSOR (
    p_id_sensor         IN LEITURA_SENSOR.ID_SENSOR%TYPE,
    p_data_hora_leitura IN LEITURA_SENSOR.DATA_HORA_LEITURA%TYPE,
    p_valor_medido      IN LEITURA_SENSOR.VALOR_MEDIDO%TYPE,
    p_qualidade_sinal   IN LEITURA_SENSOR.QUALIDADE_SINAL%TYPE DEFAULT NULL,
    p_origem_registro   IN LEITURA_SENSOR.ORIGEM_REGISTRO%TYPE DEFAULT NULL,
    p_id_leitura_out    OUT LEITURA_SENSOR.ID_LEITURA%TYPE
) IS
BEGIN
    INSERT INTO LEITURA_SENSOR (
        ID_LEITURA,
        ID_SENSOR,
        DATA_HORA_LEITURA,
        VALOR_MEDIDO,
        QUALIDADE_SINAL,
        ORIGEM_REGISTRO
    ) VALUES (
        NULL,
        p_id_sensor,
        p_data_hora_leitura,
        p_valor_medido,
        p_qualidade_sinal,
        p_origem_registro
    )
    RETURNING ID_LEITURA INTO p_id_leitura_out;

    DBMS_OUTPUT.PUT_LINE('LEITURA_SENSOR inserida com ID ' || p_id_leitura_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21011, 'Erro ao inserir LEITURA_SENSOR: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- STATUS_RESERVA
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_STATUS_RESERVA (
    p_codigo_status   IN STATUS_RESERVA.CODIGO_STATUS%TYPE,
    p_descricao       IN STATUS_RESERVA.DESCRICAO%TYPE DEFAULT NULL,
    p_e_finalizador   IN STATUS_RESERVA.E_FINALIZADOR%TYPE DEFAULT 'N',
    p_id_status_out   OUT STATUS_RESERVA.ID_STATUS_RESERVA%TYPE
) IS
BEGIN
    INSERT INTO STATUS_RESERVA (
        ID_STATUS_RESERVA,
        CODIGO_STATUS,
        DESCRICAO,
        E_FINALIZADOR
    ) VALUES (
        NULL,
        p_codigo_status,
        p_descricao,
        p_e_finalizador
    )
    RETURNING ID_STATUS_RESERVA INTO p_id_status_out;

    DBMS_OUTPUT.PUT_LINE('STATUS_RESERVA inserido com ID ' || p_id_status_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21012, 'Erro ao inserir STATUS_RESERVA: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- RESERVA_ESTACAO
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_RESERVA_ESTACAO (
    p_id_usuario                IN RESERVA_ESTACAO.ID_USUARIO%TYPE,
    p_id_estacao                IN RESERVA_ESTACAO.ID_ESTACAO%TYPE,
    p_id_status_reserva         IN RESERVA_ESTACAO.ID_STATUS_RESERVA%TYPE,
    p_data_hora_inicio_prevista IN RESERVA_ESTACAO.DATA_HORA_INICIO_PREVISTA%TYPE,
    p_data_hora_fim_prevista    IN RESERVA_ESTACAO.DATA_HORA_FIM_PREVISTA%TYPE,
    p_origem_reserva            IN RESERVA_ESTACAO.ORIGEM_RESERVA%TYPE DEFAULT NULL,
    p_motivo_cancelamento       IN RESERVA_ESTACAO.MOTIVO_CANCELAMENTO%TYPE DEFAULT NULL,
    p_indice_conforto_calculado IN RESERVA_ESTACAO.INDICE_CONFORTO_CALCULADO%TYPE DEFAULT NULL,
    p_observacoes               IN RESERVA_ESTACAO.OBSERVACOES%TYPE DEFAULT NULL,
    p_id_reserva_out            OUT RESERVA_ESTACAO.ID_RESERVA%TYPE
) IS
BEGIN
    INSERT INTO RESERVA_ESTACAO (
        ID_RESERVA,
        ID_USUARIO,
        ID_ESTACAO,
        ID_STATUS_RESERVA,
        DATA_HORA_SOLICITACAO,
        DATA_HORA_INICIO_PREVISTA,
        DATA_HORA_FIM_PREVISTA,
        ORIGEM_RESERVA,
        MOTIVO_CANCELAMENTO,
        INDICE_CONFORTO_CALCULADO,
        OBSERVACOES
    ) VALUES (
        NULL,
        p_id_usuario,
        p_id_estacao,
        p_id_status_reserva,
        SYSDATE,
        p_data_hora_inicio_prevista,
        p_data_hora_fim_prevista,
        p_origem_reserva,
        p_motivo_cancelamento,
        p_indice_conforto_calculado,
        p_observacoes
    )
    RETURNING ID_RESERVA INTO p_id_reserva_out;

    DBMS_OUTPUT.PUT_LINE('RESERVA_ESTACAO inserida com ID ' || p_id_reserva_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21013, 'Erro ao inserir RESERVA_ESTACAO: ' || SQLERRM);
END;
/
--------------------------------------------------------------------
-- AVALIACAO_ESTACAO
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_INS_AVALIACAO_ESTACAO (
    p_id_reserva           IN AVALIACAO_ESTACAO.ID_RESERVA%TYPE,
    p_nota_conforto_geral  IN AVALIACAO_ESTACAO.NOTA_CONFORTO_GERAL%TYPE,
    p_nota_ruido           IN AVALIACAO_ESTACAO.NOTA_RUIDO%TYPE DEFAULT NULL,
    p_nota_luz             IN AVALIACAO_ESTACAO.NOTA_LUZ%TYPE DEFAULT NULL,
    p_nota_estimulo_visual IN AVALIACAO_ESTACAO.NOTA_ESTIMULO_VISUAL%TYPE DEFAULT NULL,
    p_comentario           IN AVALIACAO_ESTACAO.COMENTARIO%TYPE DEFAULT NULL,
    p_id_avaliacao_out     OUT AVALIACAO_ESTACAO.ID_AVALIACAO%TYPE
) IS
BEGIN
    INSERT INTO AVALIACAO_ESTACAO (
        ID_AVALIACAO,
        ID_RESERVA,
        NOTA_CONFORTO_GERAL,
        NOTA_RUIDO,
        NOTA_LUZ,
        NOTA_ESTIMULO_VISUAL,
        COMENTARIO,
        DATA_AVALIACAO
    ) VALUES (
        NULL,
        p_id_reserva,
        p_nota_conforto_geral,
        p_nota_ruido,
        p_nota_luz,
        p_nota_estimulo_visual,
        p_comentario,
        SYSDATE
    )
    RETURNING ID_AVALIACAO INTO p_id_avaliacao_out;

    DBMS_OUTPUT.PUT_LINE('AVALIACAO_ESTACAO inserida com ID ' || p_id_avaliacao_out);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-21014, 'Erro ao inserir AVALIACAO_ESTACAO: ' || SQLERRM);
END;
/

