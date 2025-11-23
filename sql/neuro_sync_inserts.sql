SET SERVEROUTPUT ON;

------------------------------------------------------------------------
-- BLOCO 1: EMPRESA / FILIAL / SETOR / PERFIL / TIPO_SENSOR / STATUS_RESERVA
------------------------------------------------------------------------
DECLARE
  v_id_empresa_main EMPRESA.ID_EMPRESA%TYPE;
  v_id_empresa_aux  EMPRESA.ID_EMPRESA%TYPE;

  v_id_filial_sp    FILIAL.ID_FILIAL%TYPE;
  v_id_filial_rj    FILIAL.ID_FILIAL%TYPE;
  v_id_filial_dummy FILIAL.ID_FILIAL%TYPE;

  v_id_setor_ti     SETOR.ID_SETOR%TYPE;
  v_id_setor_rh     SETOR.ID_SETOR%TYPE;
  v_id_setor_ops    SETOR.ID_SETOR%TYPE;
  v_id_setor_fac    SETOR.ID_SETOR%TYPE;
  v_id_setor_dummy  SETOR.ID_SETOR%TYPE;

  v_id_perfil_colab  PERFIL.ID_PERFIL%TYPE;
  v_id_perfil_nd     PERFIL.ID_PERFIL%TYPE;
  v_id_perfil_gestor PERFIL.ID_PERFIL%TYPE;
  v_id_perfil_rh     PERFIL.ID_PERFIL%TYPE;
  v_id_perfil_admin  PERFIL.ID_PERFIL%TYPE;
  v_id_perfil_dummy  PERFIL.ID_PERFIL%TYPE;

  v_id_tipo_ruido   TIPO_SENSOR.ID_TIPO_SENSOR%TYPE;
  v_id_tipo_lux     TIPO_SENSOR.ID_TIPO_SENSOR%TYPE;
  v_id_tipo_dummy   TIPO_SENSOR.ID_TIPO_SENSOR%TYPE;

  v_id_status_pre     STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_conf    STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_uso     STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_conc    STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_cancel  STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_noshow  STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_id_status_dummy   STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
BEGIN
  --------------------------------------------------------------------
  -- EMPRESAS (10)
  --------------------------------------------------------------------
  PRC_INS_EMPRESA('NeuroSync Tech Solutions Ltda', 'NeuroSync','00.000.000/0001-00', 'contato@neurosync.com','11999990000', 'S', v_id_empresa_main);
  PRC_INS_EMPRESA('Empresa Parceira A', 'Parceira A','11.111.111/0001-11', 'contato@parceiraa.com','11333330001', 'S', v_id_empresa_aux);
  
  PRC_INS_EMPRESA('Empresa Parceira B', 'Parceira B','22.222.222/0001-22', 'contato@parceirab.com','11444440002', 'S', v_id_empresa_aux);
  PRC_INS_EMPRESA('Empresa Cliente 4', 'Cliente 4','33.333.333/0001-33', NULL, NULL, 'S', v_id_empresa_aux);
  
  PRC_INS_EMPRESA('Empresa Cliente 5', 'Cliente 5','44.444.444/0001-44', NULL, NULL, 'S', v_id_empresa_aux);
  PRC_INS_EMPRESA('Empresa Cliente 6', 'Cliente 6','55.555.555/0001-55', NULL, NULL, 'S', v_id_empresa_aux);
  
  PRC_INS_EMPRESA('Empresa Cliente 7', 'Cliente 7','66.666.666/0001-66', NULL, NULL, 'S', v_id_empresa_aux);
  PRC_INS_EMPRESA('Empresa Cliente 8', 'Cliente 8','77.777.777/0001-77', NULL, NULL, 'S', v_id_empresa_aux);
  
  PRC_INS_EMPRESA('Empresa Cliente 9', 'Cliente 9','88.888.888/0001-88', NULL, NULL, 'S', v_id_empresa_aux);
  PRC_INS_EMPRESA('Empresa Cliente 10', 'Cliente 10','99.999.999/0001-99', NULL, NULL, 'S', v_id_empresa_aux);

  --------------------------------------------------------------------
  -- FILIAIS (10)
  --------------------------------------------------------------------
  PRC_INS_FILIAL(v_id_empresa_main, 'São Paulo - Sede', 'NSP-HQ','São Paulo', 'SP', 'Brasil','Av. Paulista, 1000', 'S', v_id_filial_sp);
  PRC_INS_FILIAL(v_id_empresa_main, 'São Paulo - Anexo Sensorial', 'NSP-ANX','São Paulo', 'SP', 'Brasil','Rua do Silêncio, 50', 'S', v_id_filial_dummy);
  
  PRC_INS_FILIAL(v_id_empresa_main, 'Rio de Janeiro - Escritório', 'NRJ-HQ','Rio de Janeiro', 'RJ', 'Brasil','Av. Atlântica, 500', 'S', v_id_filial_rj);
  PRC_INS_FILIAL(v_id_empresa_main, 'Campinas Tech Hub', 'NCPS-TH','Campinas', 'SP', 'Brasil','Rua Inovação, 10', 'S', v_id_filial_dummy);
  
  PRC_INS_FILIAL(v_id_empresa_aux, 'Belo Horizonte - Unidade', 'EBH-01','Belo Horizonte', 'MG', 'Brasil','Rua Minas, 80', 'S', v_id_filial_dummy);
  PRC_INS_FILIAL(v_id_empresa_aux, 'Curitiba - Escritório', 'ECTB-01','Curitiba', 'PR', 'Brasil','Rua Paraná, 60', 'S', v_id_filial_dummy);
  
  PRC_INS_FILIAL(v_id_empresa_aux, 'Porto Alegre - Escritório', 'EPAL-01','Porto Alegre', 'RS', 'Brasil','Av. Guaíba, 200', 'S', v_id_filial_dummy);
  PRC_INS_FILIAL(v_id_empresa_aux, 'Recife - Escritório', 'EREC-01','Recife', 'PE', 'Brasil','Rua Praia, 30', 'S', v_id_filial_dummy);
  
  PRC_INS_FILIAL(v_id_empresa_aux, 'Salvador - Escritório', 'ESAL-01','Salvador', 'BA', 'Brasil','Av. Bahia, 40', 'S', v_id_filial_dummy);
  PRC_INS_FILIAL(v_id_empresa_aux, 'Florianópolis - Escritório', 'EFLN-01','Florianópolis', 'SC', 'Brasil','Rua Ilha, 70', 'S', v_id_filial_dummy);

  --------------------------------------------------------------------
  -- SETORES (10)
  --------------------------------------------------------------------
  PRC_INS_SETOR(v_id_filial_sp, 'Tecnologia da Informação', 'TI','15º', 'Equipe de desenvolvimento', 'S', v_id_setor_ti);
  PRC_INS_SETOR(v_id_filial_sp, 'Recursos Humanos', 'RH','10º', 'Equipe de pessoas e cultura', 'S', v_id_setor_rh);
  
  PRC_INS_SETOR(v_id_filial_sp, 'Operações', 'OPS','8º', 'Operações do negócio', 'S', v_id_setor_ops);
  PRC_INS_SETOR(v_id_filial_sp, 'Facilities', 'FAC','3º', 'Gestão de espaços físicos', 'S', v_id_setor_fac);
  
  PRC_INS_SETOR(v_id_filial_sp, 'Inovação & Neurodiversidade', 'INOV-ND','16º', 'Time focado em inclusão de pessoas neurodivergentes', 'S', v_id_setor_dummy);
  PRC_INS_SETOR(v_id_filial_rj, 'Atendimento ao Cliente', 'ATD','5º', 'Suporte ao cliente', 'S', v_id_setor_dummy);
  
  PRC_INS_SETOR(v_id_filial_rj, 'Operações RJ', 'OPS-RJ','6º', 'Operações na unidade RJ', 'S', v_id_setor_dummy);
  PRC_INS_SETOR(v_id_filial_rj, 'Comercial', 'COM','11º', 'Equipe comercial', 'S', v_id_setor_dummy);
  
  PRC_INS_SETOR(v_id_filial_sp, 'Jurídico', 'JUR','7º', 'Assessoria jurídica', 'S', v_id_setor_dummy);
  PRC_INS_SETOR(v_id_filial_sp, 'Financeiro', 'FIN','9º', 'Finanças corporativas', 'S', v_id_setor_dummy);

  --------------------------------------------------------------------
  -- PERFIS (10)
  --------------------------------------------------------------------
  PRC_INS_PERFIL('COLABORADOR', 'Colaborador padrão', 1, 'S', v_id_perfil_colab);
  PRC_INS_PERFIL('COLABORADOR_NEURODIVERGENTE', 'Colaborador que utiliza recursos de acessibilidade sensorial', 1, 'S', v_id_perfil_nd);
  
  PRC_INS_PERFIL('GESTOR', 'Gestor de equipe', 2, 'S', v_id_perfil_gestor);
  PRC_INS_PERFIL('RH_INCLUSAO', 'RH focado em diversidade e inclusão', 2, 'S', v_id_perfil_rh);
  
  PRC_INS_PERFIL('ADMIN_SISTEMA', 'Administrador do Neuro-Sync', 3, 'S', v_id_perfil_admin);
  PRC_INS_PERFIL('FACILITIES', 'Equipe responsável pela infraestrutura física', 2, 'S', v_id_perfil_dummy);
  
  PRC_INS_PERFIL('ANALISTA_DADOS', 'Analista de dados e BI', 2, 'S', v_id_perfil_dummy);
  PRC_INS_PERFIL('GESTOR_TI', 'Gestor da área de TI', 3, 'S', v_id_perfil_dummy);
  
  PRC_INS_PERFIL('GESTOR_RH', 'Gestor da área de RH', 3, 'S', v_id_perfil_dummy);
  PRC_INS_PERFIL('VISITANTE', 'Acesso de visualização para auditoria/parceiros', 1, 'S', v_id_perfil_dummy);

  --------------------------------------------------------------------
  -- TIPO_SENSOR (10)
  --------------------------------------------------------------------
  PRC_INS_TIPO_SENSOR('RUIDO', 'dB', 'Sensor de nível de ruído (decibéis)', 'S', v_id_tipo_ruido);
  PRC_INS_TIPO_SENSOR('LUMINOSIDADE', 'lux', 'Sensor de intensidade luminosa', 'S', v_id_tipo_lux);
  PRC_INS_TIPO_SENSOR('TEMPERATURA', '°C', 'Sensor de temperatura ambiente', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('CO2', 'ppm', 'Sensor de CO2 para qualidade do ar', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('UMIDADE', '%', 'Sensor de umidade relativa do ar', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('MOVIMENTO', NULL, 'Sensor de movimento em sala', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('PRESENCA', NULL, 'Sensor de presença em estação', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('VIBRACAO', NULL, 'Sensor de vibração', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('QUALIDADE_AR', 'índice', 'Sensor composto de qualidade do ar', 'S', v_id_tipo_dummy);
  PRC_INS_TIPO_SENSOR('OUTRO', NULL, 'Outro tipo de sensor genérico', 'S', v_id_tipo_dummy);

  --------------------------------------------------------------------
  -- STATUS_RESERVA (10)
  --------------------------------------------------------------------
  PRC_INS_STATUS_RESERVA('PRE_RESERVA', 'Reserva pré-confirmada aguardando ação do usuário', 'N', v_id_status_pre);
  PRC_INS_STATUS_RESERVA('CONFIRMADA', 'Reserva confirmada', 'N', v_id_status_conf);
  PRC_INS_STATUS_RESERVA('EM_USO', 'Estação em uso pelo colaborador', 'N', v_id_status_uso);
  PRC_INS_STATUS_RESERVA('CONCLUIDA', 'Reserva concluída com sucesso', 'S', v_id_status_conc);
  PRC_INS_STATUS_RESERVA('CANCELADA', 'Reserva cancelada pelo usuário ou sistema', 'S', v_id_status_cancel);
  PRC_INS_STATUS_RESERVA('NO_SHOW', 'Usuário não compareceu à estação reservada', 'S', v_id_status_noshow);
  PRC_INS_STATUS_RESERVA('EXPIRADA', 'Reserva expirada sem check-in', 'S', v_id_status_dummy);
  PRC_INS_STATUS_RESERVA('REJEITADA', 'Reserva rejeitada por política interna', 'S', v_id_status_dummy);
  PRC_INS_STATUS_RESERVA('EM_ANALISE', 'Reserva aguardando avaliação de RH/gestor', 'N', v_id_status_dummy);
  PRC_INS_STATUS_RESERVA('AGUARDANDO_CHECKIN', 'Reserva confirmada aguardando check-in', 'N', v_id_status_dummy);
END;
/
------------------------------------------------------------------------
-- BLOCO 2: ZONAS SENSORIAIS / ESTAÇÕES / SENSORES
------------------------------------------------------------------------
DECLARE
  v_filial_sp   FILIAL.ID_FILIAL%TYPE;
  v_filial_rj   FILIAL.ID_FILIAL%TYPE;

  v_zona_silencio_sp ZONA_SENSORIAL.ID_ZONA%TYPE;
  v_zona_focus_sp    ZONA_SENSORIAL.ID_ZONA%TYPE;
  v_zona_colab_sp    ZONA_SENSORIAL.ID_ZONA%TYPE;
  v_zona_silencio_rj ZONA_SENSORIAL.ID_ZONA%TYPE;
  v_zona_dummy       ZONA_SENSORIAL.ID_ZONA%TYPE;

  v_estacao_1   ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao_2   ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao_3   ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao_4   ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao_5   ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao_dummy ESTACAO_TRABALHO.ID_ESTACAO%TYPE;

  v_tipo_ruido  TIPO_SENSOR.ID_TIPO_SENSOR%TYPE;
  v_tipo_lux    TIPO_SENSOR.ID_TIPO_SENSOR%TYPE;

  v_sensor_r1   SENSOR.ID_SENSOR%TYPE;
  v_sensor_r2   SENSOR.ID_SENSOR%TYPE;
  v_sensor_r3   SENSOR.ID_SENSOR%TYPE;
  v_sensor_l1   SENSOR.ID_SENSOR%TYPE;
  v_sensor_l2   SENSOR.ID_SENSOR%TYPE;
  v_sensor_l3   SENSOR.ID_SENSOR%TYPE;
  v_sensor_dummy SENSOR.ID_SENSOR%TYPE;
BEGIN
  -- Buscar filiais e tipos de sensor necessários
  SELECT ID_FILIAL INTO v_filial_sp FROM FILIAL WHERE CODIGO_FILIAL = 'NSP-HQ';
  SELECT ID_FILIAL INTO v_filial_rj FROM FILIAL WHERE CODIGO_FILIAL = 'NRJ-HQ';

  SELECT ID_TIPO_SENSOR INTO v_tipo_ruido FROM TIPO_SENSOR WHERE NOME_TIPO_SENSOR = 'RUIDO';
  SELECT ID_TIPO_SENSOR INTO v_tipo_lux   FROM TIPO_SENSOR WHERE NOME_TIPO_SENSOR = 'LUMINOSIDADE';

  --------------------------------------------------------------------
  -- ZONAS SENSORIAIS (10)
  --------------------------------------------------------------------
  
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Zona Silenciosa - 15º andar', 'SILENCIOSA','Espaço com controle de ruído para foco profundo',35, 350, 'BAIXO_ESTIMULO', 20, 'S', v_zona_silencio_sp);
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Zona de Foco Moderado', 'NEUTRA','Ambiente de foco moderado com alguma colaboração',45, 400, 'NORMAL', 30, 'S', v_zona_focus_sp);
  
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Zona Colaborativa', 'COLABORATIVA','Área aberta para reuniões rápidas e colaboração',60, 500, 'ALTO_ESTIMULO', 25, 'S', v_zona_colab_sp);
  PRC_INS_ZONA_SENSORIAL(v_filial_rj, 'Zona Silenciosa RJ', 'SILENCIOSA','Espaço silencioso na unidade RJ',38, 360, 'BAIXO_ESTIMULO', 15, 'S', v_zona_silencio_rj);
  
  PRC_INS_ZONA_SENSORIAL(v_filial_rj, 'Zona Colab RJ', 'COLABORATIVA','Área colaborativa na unidade RJ',58, 520, 'ALTO_ESTIMULO', 20, 'S', v_zona_dummy);
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Cabines Individuais 1', 'FOCUS_ROOM','Cabines fechadas para chamadas e concentração',30, 320, 'BAIXO_ESTIMULO', 10, 'S', v_zona_dummy);
  
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Cabines Individuais 2', 'FOCUS_ROOM','Segunda área de cabines individuais', 32, 340, 'BAIXO_ESTIMULO', 8, 'S', v_zona_dummy);
  PRC_INS_ZONA_SENSORIAL(v_filial_sp, 'Espaço Neuro-Friendly', 'NEURO_FRIENDLY','Zona adaptada para diferentes perfis sensoriais',40, 380, 'NORMAL', 12, 'S', v_zona_dummy);
  
  PRC_INS_ZONA_SENSORIAL(v_filial_rj, 'Terraço Silencioso', 'SILENCIOSA','Ambiente externo com baixo ruído', 42, 300, 'NORMAL', 5, 'S', v_zona_dummy);
  PRC_INS_ZONA_SENSORIAL(v_filial_rj, 'Open Space RJ', 'COLABORATIVA','Espaço aberto principal da unidade RJ', 65, 550, 'ALTO_ESTIMULO', 40, 'S', v_zona_dummy);
  
  --------------------------------------------------------------------
  -- ESTAÇÕES DE TRABALHO (10)
  --------------------------------------------------------------------
  
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_sp, 'Z-SIL-SP-01','Estação silenciosa 01 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_1);
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_sp, 'Z-SIL-SP-02','Estação silenciosa 02 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_2);
  
  PRC_INS_ESTACAO_TRABALHO(v_zona_focus_sp, 'Z-FOC-SP-01','Estação de foco moderado 01 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_3);
  PRC_INS_ESTACAO_TRABALHO(v_zona_colab_sp, 'Z-COL-SP-01','Estação colaborativa 01 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_4);
  
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_rj, 'Z-SIL-RJ-01','Estação silenciosa 01 - RJ', 'S', 'S', 'ATIVA', NULL, v_estacao_5);
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_sp, 'Z-SIL-SP-03','Estação silenciosa 03 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_dummy);
  
  PRC_INS_ESTACAO_TRABALHO(v_zona_focus_sp, 'Z-FOC-SP-02','Estação de foco moderado 02 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_dummy);
  PRC_INS_ESTACAO_TRABALHO(v_zona_colab_sp, 'Z-COL-SP-02','Estação colaborativa 02 - SP', 'S', 'S', 'ATIVA', NULL, v_estacao_dummy);
  
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_rj, 'Z-SIL-RJ-02','Estação silenciosa 02 - RJ', 'S', 'S', 'ATIVA', NULL, v_estacao_dummy);
  PRC_INS_ESTACAO_TRABALHO(v_zona_silencio_rj, 'Z-SIL-RJ-03','Estação silenciosa 03 - RJ', 'S', 'S', 'ATIVA', NULL, v_estacao_dummy);
  
  --------------------------------------------------------------------
  -- SENSORES (10)
  --------------------------------------------------------------------
  
  PRC_INS_SENSOR(v_estacao_1, v_tipo_ruido, 'HW-RUIDO-SP-01',SYSDATE-90, SYSDATE-10, 'ATIVO', NULL, v_sensor_r1);
  PRC_INS_SENSOR(v_estacao_1, v_tipo_lux, 'HW-LUX-SP-01',SYSDATE-90, SYSDATE-10, 'ATIVO', NULL, v_sensor_l1);
  
  PRC_INS_SENSOR(v_estacao_2, v_tipo_ruido, 'HW-RUIDO-SP-02',SYSDATE-60, SYSDATE-5, 'ATIVO', NULL, v_sensor_r2);
  PRC_INS_SENSOR(v_estacao_2, v_tipo_lux, 'HW-LUX-SP-02',SYSDATE-60, SYSDATE-5, 'ATIVO', NULL, v_sensor_l2);
  
  PRC_INS_SENSOR(v_estacao_3, v_tipo_ruido, 'HW-RUIDO-SP-03',SYSDATE-30, SYSDATE-2, 'ATIVO', NULL, v_sensor_r3);
  PRC_INS_SENSOR(v_estacao_3, v_tipo_lux, 'HW-LUX-SP-03',SYSDATE-30, SYSDATE-2, 'ATIVO', NULL, v_sensor_l3);
  
  PRC_INS_SENSOR(v_estacao_4, v_tipo_ruido, 'HW-RUIDO-SP-COL-01',SYSDATE-20, SYSDATE-1, 'ATIVO', NULL, v_sensor_dummy);
  PRC_INS_SENSOR(v_estacao_4, v_tipo_lux, 'HW-LUX-SP-COL-01',SYSDATE-20, SYSDATE-1, 'ATIVO', NULL, v_sensor_dummy);
  
  PRC_INS_SENSOR(v_estacao_5, v_tipo_ruido, 'HW-RUIDO-RJ-01',SYSDATE-15, SYSDATE-1, 'ATIVO', NULL, v_sensor_dummy);
  PRC_INS_SENSOR(v_estacao_5, v_tipo_lux, 'HW-LUX-RJ-01',SYSDATE-15, SYSDATE-1, 'ATIVO', NULL, v_sensor_dummy);
  
END;
/
------------------------------------------------------------------------
-- BLOCO 3: USUÁRIOS / USUARIO_PERFIL / PREFERENCIAS SENSORIAIS
------------------------------------------------------------------------
DECLARE
  v_setor_ti   SETOR.ID_SETOR%TYPE;
  v_setor_rh   SETOR.ID_SETOR%TYPE;
  v_setor_ops  SETOR.ID_SETOR%TYPE;
  v_setor_inov SETOR.ID_SETOR%TYPE;

  v_perfil_colab   PERFIL.ID_PERFIL%TYPE;
  v_perfil_nd      PERFIL.ID_PERFIL%TYPE;
  v_perfil_gestor  PERFIL.ID_PERFIL%TYPE;
  v_perfil_rh      PERFIL.ID_PERFIL%TYPE;
  v_perfil_admin   PERFIL.ID_PERFIL%TYPE;

  v_id_usuario1 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario2 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario3 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario4 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario5 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario6 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario7 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario8 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario9 USUARIO.ID_USUARIO%TYPE;
  v_id_usuario10 USUARIO.ID_USUARIO%TYPE;

  v_id_up_dummy    USUARIO_PERFIL.ID_USUARIO_PERFIL%TYPE;
  v_id_pref_dummy  PREFERENCIA_SENSORIAL.ID_PREFERENCIA%TYPE;
BEGIN
  -- Buscar setores e perfis principais
  SELECT ID_SETOR INTO v_setor_ti   FROM SETOR WHERE CODIGO_SETOR = 'TI';
  SELECT ID_SETOR INTO v_setor_rh   FROM SETOR WHERE CODIGO_SETOR = 'RH';
  SELECT ID_SETOR INTO v_setor_ops  FROM SETOR WHERE CODIGO_SETOR = 'OPS';
  SELECT ID_SETOR INTO v_setor_inov FROM SETOR WHERE CODIGO_SETOR = 'INOV-ND';

  SELECT ID_PERFIL INTO v_perfil_colab  FROM PERFIL WHERE NOME_PERFIL = 'COLABORADOR';
  SELECT ID_PERFIL INTO v_perfil_nd     FROM PERFIL WHERE NOME_PERFIL = 'COLABORADOR_NEURODIVERGENTE';
  SELECT ID_PERFIL INTO v_perfil_gestor FROM PERFIL WHERE NOME_PERFIL = 'GESTOR';
  SELECT ID_PERFIL INTO v_perfil_rh     FROM PERFIL WHERE NOME_PERFIL = 'RH_INCLUSAO';
  SELECT ID_PERFIL INTO v_perfil_admin  FROM PERFIL WHERE NOME_PERFIL = 'ADMIN_SISTEMA';

  --------------------------------------------------------------------
  -- USUÁRIOS (10)
  --------------------------------------------------------------------
  
  PRC_INS_USUARIO(v_setor_ti, 'Ana Souza', 'ana.souza@neurosync.com', 'NS001','11911110001', TO_DATE('2022-03-01','YYYY-MM-DD'),'S', 'S', 'Prefere ambientes bem silenciosos', v_id_usuario1);
  PRC_INS_USUARIO(v_setor_ti, 'Bruno Lima', 'bruno.lima@neurosync.com', 'NS002','11911110002', TO_DATE('2021-08-15','YYYY-MM-DD'),'S', 'S', 'Sensível a luz muito intensa', v_id_usuario2);
  
  PRC_INS_USUARIO(v_setor_rh, 'Carla Mendes', 'carla.mendes@neurosync.com', 'NS003','11911110003', TO_DATE('2020-01-10','YYYY-MM-DD'),'S', 'N', 'RH responsável por inclusão', v_id_usuario3);
  PRC_INS_USUARIO(v_setor_ops, 'Diego Santos', 'diego.santos@neurosync.com', 'NS004','11911110004', TO_DATE('2019-05-20','YYYY-MM-DD'),'S', 'S', 'Se concentra melhor em zonas neutras', v_id_usuario4);
  
  PRC_INS_USUARIO(v_setor_ops, 'Eduarda Silva', 'eduarda.silva@neurosync.com', 'NS005','11911110005', TO_DATE('2023-02-01','YYYY-MM-DD'),'S', 'N', 'Responsável por agendar testes de zonas', v_id_usuario5);
  PRC_INS_USUARIO(v_setor_inov, 'Felipe Araújo', 'felipe.araujo@neurosync.com', 'NS006','11911110006', TO_DATE('2022-11-11','YYYY-MM-DD'),'S', 'S', 'Participa do comitê de neurodiversidade', v_id_usuario6);
  
  PRC_INS_USUARIO(v_setor_inov, 'Gabriela Costa', 'gabriela.costa@neurosync.com', 'NS007','11911110007', TO_DATE('2021-04-02','YYYY-MM-DD'),'S', 'S', 'Ajuda a validar as estações neuro-friendly', v_id_usuario7);
  PRC_INS_USUARIO(v_setor_ti, 'Henrique Souza', 'henrique.souza@neurosync.com', 'NS008','11911110008', TO_DATE('2018-09-30','YYYY-MM-DD'),'S', 'N', 'Tech lead do time de backend', v_id_usuario8);
  
  PRC_INS_USUARIO(v_setor_rh, 'Isabela Rocha', 'isabela.rocha@neurosync.com', 'NS009','11911110009', TO_DATE('2017-07-07','YYYY-MM-DD'),'S', 'N', 'Business partner focada em políticas', v_id_usuario9);
  PRC_INS_USUARIO(v_setor_ops, 'João Ferreira', 'joao.ferreira@neurosync.com', 'NS010','11911110010', TO_DATE('2024-01-05','YYYY-MM-DD'),'S', 'S', 'Recém-contratado, em adaptação sensorial', v_id_usuario10);
  
  --------------------------------------------------------------------
  -- USUARIO_PERFIL (>=10 vínculos)
  --------------------------------------------------------------------
  PRC_INS_USUARIO_PERFIL(v_id_usuario1, v_perfil_colab,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario1, v_perfil_nd,     'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  
  PRC_INS_USUARIO_PERFIL(v_id_usuario2, v_perfil_colab,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario3, v_perfil_rh,     'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario4, v_perfil_colab,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario5, v_perfil_colab,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  
  PRC_INS_USUARIO_PERFIL(v_id_usuario6, v_perfil_colab,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario6, v_perfil_nd,     'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  
  PRC_INS_USUARIO_PERFIL(v_id_usuario7, v_perfil_gestor, 'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario8, v_perfil_admin,  'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario9, v_perfil_rh,     'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  
  PRC_INS_USUARIO_PERFIL(v_id_usuario10, v_perfil_colab, 'carla.mendes@neurosync.com', 'S', v_id_up_dummy);
  PRC_INS_USUARIO_PERFIL(v_id_usuario10, v_perfil_nd,    'carla.mendes@neurosync.com', 'S', v_id_up_dummy);

  --------------------------------------------------------------------
  -- PREFERENCIAS SENSORIAIS (10)
  --------------------------------------------------------------------
  
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario1,40, 300, 450, 3, 'SILENCIOSA','Prefere estações em zonas silenciosas',TO_DATE('2023-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario2,45, 250, 400, 4, 'SILENCIOSA','Evitar reflexos e luz muito forte',TO_DATE('2023-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario3,55, 300, 500, 6, 'NEUTRA','Confortável em ambientes de ruído moderado',TO_DATE('2022-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario4,50, 280, 480, 5, 'NEUTRA','Prefere equilíbrio entre foco e interação',TO_DATE('2023-06-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario5,60, 300, 550, 7, 'COLABORATIVA','Confortável em ambientes colaborativos',TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario6,42, 280, 420, 3, 'SILENCIOSA','Precisa de baixa estimulação visual e sonora',TO_DATE('2023-02-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario7,48, 300, 460, 4, 'NEURO_FRIENDLY','Prefere zonas adaptadas com controle de estímulos',TO_DATE('2022-09-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario8,55, 320, 520, 6, 'NEUTRA','Aceita algum ruído de fundo',TO_DATE('2020-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario9,50, 300, 500, 5, 'NEUTRA','Equilíbrio entre foco e contato com equipe',TO_DATE('2019-01-01','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  PRC_INS_PREFERENCIA_SENSORIAL(v_id_usuario10,45, 280, 430, 3, 'SILENCIOSA','Em adaptação, prefere ambientes silenciosos',TO_DATE('2024-01-05','YYYY-MM-DD'), NULL, 'S', v_id_pref_dummy);
  
END;
/
------------------------------------------------------------------------
-- BLOCO 4: LEITURAS DE SENSORES / RESERVAS / AVALIAÇÕES
------------------------------------------------------------------------
DECLARE
  v_sensor_ruido1 SENSOR.ID_SENSOR%TYPE;
  v_sensor_lux1   SENSOR.ID_SENSOR%TYPE;
  v_sensor_ruido2 SENSOR.ID_SENSOR%TYPE;
  v_sensor_lux2   SENSOR.ID_SENSOR%TYPE;

  v_estacao1      ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao2      ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao3      ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao4      ESTACAO_TRABALHO.ID_ESTACAO%TYPE;
  v_estacao5      ESTACAO_TRABALHO.ID_ESTACAO%TYPE;

  v_user_ana      USUARIO.ID_USUARIO%TYPE;
  v_user_bruno    USUARIO.ID_USUARIO%TYPE;
  v_user_diego    USUARIO.ID_USUARIO%TYPE;
  v_user_felipe   USUARIO.ID_USUARIO%TYPE;
  v_user_gabriela USUARIO.ID_USUARIO%TYPE;

  v_status_pre    STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_status_conf   STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_status_uso    STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_status_conc   STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_status_cancel STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;
  v_status_noshow STATUS_RESERVA.ID_STATUS_RESERVA%TYPE;

  v_id_leitura_dummy LEITURA_SENSOR.ID_LEITURA%TYPE;

  v_id_res1  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res2  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res3  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res4  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res5  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res6  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res7  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res8  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res9  RESERVA_ESTACAO.ID_RESERVA%TYPE;
  v_id_res10 RESERVA_ESTACAO.ID_RESERVA%TYPE;

  v_id_avaliacao_dummy AVALIACAO_ESTACAO.ID_AVALIACAO%TYPE;
BEGIN
  -- Sensores principais
  SELECT ID_SENSOR INTO v_sensor_ruido1 FROM SENSOR WHERE IDENTIFICADOR_HARDWARE = 'HW-RUIDO-SP-01';
  SELECT ID_SENSOR INTO v_sensor_lux1   FROM SENSOR WHERE IDENTIFICADOR_HARDWARE = 'HW-LUX-SP-01';
  SELECT ID_SENSOR INTO v_sensor_ruido2 FROM SENSOR WHERE IDENTIFICADOR_HARDWARE = 'HW-RUIDO-SP-02';
  SELECT ID_SENSOR INTO v_sensor_lux2   FROM SENSOR WHERE IDENTIFICADOR_HARDWARE = 'HW-LUX-SP-02';

  -- Estações principais
  SELECT ID_ESTACAO INTO v_estacao1 FROM ESTACAO_TRABALHO WHERE CODIGO_ESTACAO = 'Z-SIL-SP-01';
  SELECT ID_ESTACAO INTO v_estacao2 FROM ESTACAO_TRABALHO WHERE CODIGO_ESTACAO = 'Z-SIL-SP-02';
  SELECT ID_ESTACAO INTO v_estacao3 FROM ESTACAO_TRABALHO WHERE CODIGO_ESTACAO = 'Z-FOC-SP-01';
  SELECT ID_ESTACAO INTO v_estacao4 FROM ESTACAO_TRABALHO WHERE CODIGO_ESTACAO = 'Z-COL-SP-01';
  SELECT ID_ESTACAO INTO v_estacao5 FROM ESTACAO_TRABALHO WHERE CODIGO_ESTACAO = 'Z-SIL-RJ-01';

  -- Usuários
  SELECT ID_USUARIO INTO v_user_ana      FROM USUARIO WHERE EMAIL_CORPORATIVO = 'ana.souza@neurosync.com';
  SELECT ID_USUARIO INTO v_user_bruno    FROM USUARIO WHERE EMAIL_CORPORATIVO = 'bruno.lima@neurosync.com';
  SELECT ID_USUARIO INTO v_user_diego    FROM USUARIO WHERE EMAIL_CORPORATIVO = 'diego.santos@neurosync.com';
  SELECT ID_USUARIO INTO v_user_felipe   FROM USUARIO WHERE EMAIL_CORPORATIVO = 'felipe.araujo@neurosync.com';
  SELECT ID_USUARIO INTO v_user_gabriela FROM USUARIO WHERE EMAIL_CORPORATIVO = 'gabriela.costa@neurosync.com';

  -- Status de reserva
  SELECT ID_STATUS_RESERVA INTO v_status_pre    FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'PRE_RESERVA';
  SELECT ID_STATUS_RESERVA INTO v_status_conf   FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'CONFIRMADA';
  SELECT ID_STATUS_RESERVA INTO v_status_uso    FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'EM_USO';
  SELECT ID_STATUS_RESERVA INTO v_status_conc   FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'CONCLUIDA';
  SELECT ID_STATUS_RESERVA INTO v_status_cancel FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'CANCELADA';
  SELECT ID_STATUS_RESERVA INTO v_status_noshow FROM STATUS_RESERVA WHERE CODIGO_STATUS = 'NO_SHOW';

  --------------------------------------------------------------------
  -- LEITURAS DE SENSOR (10)
  --------------------------------------------------------------------
  PRC_INS_LEITURA_SENSOR(v_sensor_ruido1,TO_DATE('2025-11-20 09:00','YYYY-MM-DD HH24:MI'), 38, 90, 'ONLINE', v_id_leitura_dummy);
  PRC_INS_LEITURA_SENSOR(v_sensor_lux1,TO_DATE('2025-11-20 09:00','YYYY-MM-DD HH24:MI'), 340, 95, 'ONLINE', v_id_leitura_dummy);

  PRC_INS_LEITURA_SENSOR(v_sensor_ruido1,TO_DATE('2025-11-20 09:30','YYYY-MM-DD HH24:MI'), 40, 92, 'ONLINE', v_id_leitura_dummy);
  PRC_INS_LEITURA_SENSOR(v_sensor_lux1,TO_DATE('2025-11-20 09:30','YYYY-MM-DD HH24:MI'), 360, 96, 'ONLINE', v_id_leitura_dummy);

  PRC_INS_LEITURA_SENSOR(v_sensor_ruido2,TO_DATE('2025-11-20 10:00','YYYY-MM-DD HH24:MI'), 42, 93, 'ONLINE', v_id_leitura_dummy);
  PRC_INS_LEITURA_SENSOR(v_sensor_lux2,TO_DATE('2025-11-20 10:00','YYYY-MM-DD HH24:MI'), 330, 94, 'ONLINE', v_id_leitura_dummy);

  PRC_INS_LEITURA_SENSOR(v_sensor_ruido2,TO_DATE('2025-11-20 10:30','YYYY-MM-DD HH24:MI'), 39, 91, 'ONLINE', v_id_leitura_dummy);
  PRC_INS_LEITURA_SENSOR(v_sensor_lux2,TO_DATE('2025-11-20 10:30','YYYY-MM-DD HH24:MI'), 345, 93, 'ONLINE', v_id_leitura_dummy);

  PRC_INS_LEITURA_SENSOR(v_sensor_ruido1,TO_DATE('2025-11-20 11:00','YYYY-MM-DD HH24:MI'), 37, 90, 'ONLINE', v_id_leitura_dummy);
  PRC_INS_LEITURA_SENSOR(v_sensor_lux1,TO_DATE('2025-11-20 11:00','YYYY-MM-DD HH24:MI'), 355, 95, 'ONLINE', v_id_leitura_dummy);

  --------------------------------------------------------------------
  -- RESERVAS DE ESTAÇÃO (10)
  --------------------------------------------------------------------
  PRC_INS_RESERVA_ESTACAO(
      v_user_ana, v_estacao1, v_status_conc,
      TO_DATE('2025-11-20 09:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-20 11:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Reserva de foco profundo pela manhã', v_id_res1);

  PRC_INS_RESERVA_ESTACAO(
      v_user_bruno, v_estacao2, v_status_conc,
      TO_DATE('2025-11-20 10:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-20 12:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Sprint de desenvolvimento', v_id_res2);

  PRC_INS_RESERVA_ESTACAO(
      v_user_diego, v_estacao3, v_status_conc,
      TO_DATE('2025-11-20 14:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-20 16:00','YYYY-MM-DD HH24:MI'),
      'PORTAL_WEB', NULL, NULL,
      'Reunião híbrida com equipe', v_id_res3);

  PRC_INS_RESERVA_ESTACAO(
      v_user_felipe, v_estacao1, v_status_conf,
      TO_DATE('2025-11-21 14:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-21 17:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Preparação de apresentação sensível a estímulos', v_id_res4);

  PRC_INS_RESERVA_ESTACAO(
      v_user_gabriela, v_estacao4, v_status_conc,
      TO_DATE('2025-11-19 15:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-19 17:00','YYYY-MM-DD HH24:MI'),
      'PORTAL_WEB', NULL, NULL,
      'Workshop sobre neurodiversidade', v_id_res5);

  PRC_INS_RESERVA_ESTACAO(
      v_user_ana, v_estacao3, v_status_cancel,
      TO_DATE('2025-11-18 09:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-18 10:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', 'Usuária optou por trabalho remoto', NULL,
      'Reserva cancelada por opção da colaboradora', v_id_res6);

  PRC_INS_RESERVA_ESTACAO(
      v_user_bruno, v_estacao4, v_status_noshow,
      TO_DATE('2025-11-17 14:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-17 16:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', 'Usuário não realizou check-in', NULL,
      'Reserva marcada mas sem comparecimento', v_id_res7);

  PRC_INS_RESERVA_ESTACAO(
      v_user_diego, v_estacao2, v_status_uso,
      TO_DATE('2025-11-22 09:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-22 11:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Uso atual para foco em código', v_id_res8);

  PRC_INS_RESERVA_ESTACAO(
      v_user_felipe, v_estacao5, v_status_conf,
      TO_DATE('2025-11-23 09:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-23 11:00','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Teste piloto de estação no RJ', v_id_res9);

  PRC_INS_RESERVA_ESTACAO(
      v_user_ana, v_estacao1, v_status_conc,
      TO_DATE('2025-11-19 09:00','YYYY-MM-DD HH24:MI'),
      TO_DATE('2025-11-19 10:30','YYYY-MM-DD HH24:MI'),
      'APP_MOBILE', NULL, NULL,
      'Reserva anterior de testes de conforto', v_id_res10);

  --------------------------------------------------------------------
  -- AVALIAÇÕES DE ESTAÇÃO (10)
  --------------------------------------------------------------------
  PRC_INS_AVALIACAO_ESTACAO(v_id_res1, 5, 5, 5, 5,
      'Conforto excelente, ajudou muito no foco.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res2, 4, 4, 5, 4,
      'Ambiente bom, um pouco de ruído em alguns momentos.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res3, 3, 3, 4, 3,
      'Ficaria melhor com menos passagem de pessoas.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res4, 5, 5, 4, 5,
      'Estação perfeita para tarefas complexas.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res5, 4, 3, 4, 4,
      'Ambiente engajante para workshop.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res1, 5, 5, 5, 4,
      'Nova reserva, novamente muito confortável.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res2, 4, 4, 4, 3,
      'Luz boa, mas poderia ter menos conversas ao redor.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res3, 3, 3, 3, 3,
      'Ok, mas zona neutra ainda tem ruídos imprevisíveis.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res5, 5, 4, 5, 5,
      'Workshop com boa iluminação e som.', v_id_avaliacao_dummy);

  PRC_INS_AVALIACAO_ESTACAO(v_id_res10, 5, 5, 4, 5,
      'Primeiro teste de conforto foi excelente.', v_id_avaliacao_dummy);
END;
/
