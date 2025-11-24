# **🧠 Neuro-Sync API**

**Backend para inclusão produtiva com monitoramento sensorial e reservas inteligentes**

---

## **📖 Sobre o Projeto**

**Neuro-Sync API** é o backend REST (Spring Boot) do desafio **Global Solution 2025 - O Futuro do Trabalho**.  
Exposição de serviços para reservas de estações, preferências sensoriais, autenticação JWT e indicadores calculados a partir do Oracle.  
📹 **Demonstração em vídeo:** https://www.youtube.com/watch?v=rRhjcRP6Sb8

O neuro-sync é uma solução tecnológica voltada para inclusão produtiva e bem-estar no ambiente de trabalho, alinhada ao tema “o futuro do trabalho” e aos objetivos de desenvolvimento sustentável (ods 8 - trabalho decente e crescimento econômico, e ods 10 – redução das desigualdades). a proposta combina iot, análise de dados e acessibilidade sensorial, permitindo que profissionais neurodivergentes possam localizar, reservar e monitorar estações de trabalho sensorialmente adequadas, com controle de ruído, luminosidade e estímulos visuais em tempo real.

O modelo open-plan de escritórios modernos foi desenhado para um ideal neurotípico de colaboração. Embora promova interação, este formato gera sobrecarga sensorial para profissionais neurodivergentes (como pessoas com TDAH, TEA, Dislexia ou Dispraxia). Ruídos constantes, luzes fluorescentes e estímulos visuais excessivos tornam o ambiente exaustivo e improdutivo, afetando a saúde mental e a permanência dessas pessoas no mercado de trabalho. Empresas investem em tecnologia e automação, mas ainda falham em incluir a diversidade neurológica, gerando desigualdade e perda de talentos qualificados.

O principal objetivo do Neuro-Sync é desenvolver uma infraestrutura digital e física que permita a personalização do ambiente de trabalho com base em dados sensoriais monitorados continuamente. A solução propõe o uso de Internet das Coisas (IoT) para captura e processamento de variáveis ambientais, integradas a uma aplicação móvel que possibilita ao colaborador localizar e reservar estações de trabalho ideais. Além disso, a camada de software corporativo fornece indicadores e relatórios para gestores de RH e facilities, permitindo decisões baseadas em evidências sobre adaptação de espaços e políticas de inclusão. A arquitetura foi desenhada para garantir escalabilidade e interoperabilidade, permitindo integração com sistemas corporativos de reserva de salas, diretórios de usuários e plataformas de Business Intelligence. Assim, o projeto combina inovação tecnológica e impacto social, demonstrando que a inclusão pode ser tratada como um problema de engenharia de sistemas, e não apenas como uma iniciativa de diversidade.

---

### **🎯 Objetivo (ODS 8 e 10)**

Viabilizar ambientes de trabalho adaptáveis e inclusivos para pessoas neurodivergentes, conectando dados sensoriais, reservas e preferências em uma API segura e escalável.

---

## **✨ Funcionalidades Principais**

### **🌐 API REST**

1. **Autenticação JWT:** Login por e-mail corporativo, perfis/roles via tabela `PERFIL` + `USUARIO_PERFIL`.  
2. **Gestão de Usuários:** CRUD básico e associação de perfis.  
3. **Preferências Sensoriais:** Cadastro e consulta por usuário.  
4. **Zonas e Estações:** Listagem paginada e filtrada de estações por zona/status/permite reserva.  
5. **Reservas:** Criação via procedure Oracle (`PRC_INS_RESERVA_ESTACAO`), avaliação via procedure (`PRC_INS_AVALIACAO_ESTACAO`), listagem paginada com filtros.  
6. **Indicadores:** Chamada de functions Oracle (`FNC_CALC_INDICE_CONFORTO`, `FNC_TAXA_OCUPACAO_ESTACAO`, `FNC_RESERVA_COMPATIVEL`).  
7. **Swagger/OpenAPI:** Documentação disponível em `/swagger-ui.html`.

#### 🔍 Functions Oracle (regras de negócio)
- `FNC_CALC_INDICE_CONFORTO(p_id_estacao, p_data_inicio, p_data_fim)`  
  - Entrada: estação e intervalo de datas.  
  - Saída: `NUMBER` (ex.: 0–100) representando o índice médio de conforto no período, combinando leituras de sensores e avaliações da estação.  
  - Endpoint: `GET /api/indicadores/estacoes/{id}/indice-conforto?inicio=...&fim=...`
- `FNC_TAXA_OCUPACAO_ESTACAO(p_id_estacao, p_data_inicio, p_data_fim)`  
  - Entrada: estação e intervalo de datas.  
  - Saída: `NUMBER` em porcentagem (0–100) indicando quanto tempo a estação esteve ocupada no período.  
  - Endpoint: `GET /api/indicadores/estacoes/{id}/taxa-ocupacao?inicio=...&fim=...`
- `FNC_RESERVA_COMPATIVEL(p_id_reserva)`  
  - Entrada: reserva.  
  - Saída: `CHAR` (`'S'` ou `'N'`) informando se a reserva está compatível com as preferências sensoriais do usuário (ruído, luz, visual).  
  - Endpoint: `GET /api/reservas/{id}/compatibilidade`

---

### **🔗 Integrações**

* **Oracle:** Persistência via JPA (DDL auto desabilitado) e chamadas de procedures/functions nativas para reservas, avaliações e indicadores.

---

## **🛠️ Tecnologias Utilizadas**

* **Backend:** Spring Boot 3, Spring Data JPA, Spring Security (JWT), Bean Validation.  
* **Banco:** Oracle Database (dialeto Oracle, sem geração de schema).  
* **Documentação:** springdoc-openapi (Swagger UI).  
* **Build/Runtime:** Maven, Java 21, Docker multi-stage.  
* **Infra (deploy):** Docker/Azure (uso de variáveis de ambiente; 12-factor).

---

## **📂 Estrutura do Projeto**

```
neuro-sync/
├── src/
│   ├── main/
│   │   ├── java/br/com/neurosync/api/
│   │   │   ├── controller/          # REST controllers
│   │   │   ├── service/             # Regras de negócio + procedures/functions
│   │   │   ├── repository/          # Spring Data JPA
│   │   │   ├── entity/              # Entidades JPA Oracle
+│   │   │   ├── dto/                 # DTOs + Bean Validation
│   │   │   ├── mapper/              # Converters Entity <-> DTO
│   │   │   ├── security/            # JWT, filtros, UserDetails
│   │   │   ├── config/              # CORS, OpenAPI
│   │   │   └── exception/           # Handler global
│   │   └── resources/
│   │       ├── application.yml      # (use variáveis de ambiente)
│   │       └── application.yml.example
│   │       
├── pom.xml
└── Dockerfile
```

---

## **🚀 Como Rodar o Projeto**

### **Pré-requisitos**

* Java 21, Maven.  
* Banco Oracle acessível.  
* Variáveis de ambiente configuradas:  
  * `NEUROSYNC_DB_URL`  
  * `NEUROSYNC_DB_USERNAME`  
  * `NEUROSYNC_DB_PASSWORD`  
  * `NEUROSYNC_JWT_SECRET` (>= 32 chars)  
  * (opcional) `NEUROSYNC_JWT_EXPIRATION`, `PORT`

### **Passo a Passo (Maven)**
```
cp src/main/resources/application.yml.example src/main/resources/application.yml  # ajuste se preferir arquivo local
./mvnw spring-boot:run
```

### **Passo a Passo (Docker)**
```
docker build -t neurosync-api .
docker run --env NEUROSYNC_DB_URL=... \
           --env NEUROSYNC_DB_USERNAME=... \
           --env NEUROSYNC_DB_PASSWORD=... \
           --env NEUROSYNC_JWT_SECRET=... \
           -p 8080:8080 neurosync-api
```

### **Swagger**
```
http://localhost:8080/swagger-ui.html
```

---

## **🧪 Como Testar (Fluxo de Uso)**

1. **Login:** POST `/auth/login` com e-mail corporativo e senha. Receba JWT.  
2. **Listar estações:** GET `/api/estacoes?page=0&size=10&status=ATIVA`.  
3. **Criar reserva:** POST `/api/reservas` (usa procedure `PRC_INS_RESERVA_ESTACAO`).  
4. **Avaliar estação:** POST `/api/reservas/avaliacoes` (procedure `PRC_INS_AVALIACAO_ESTACAO`).  
5. **Indicadores:** GET `/api/indicadores/estacoes/{id}/indice-conforto?inicio=...&fim=...` (function Oracle).  
6. **Preferências:** POST `/api/preferencias-sensoriais` e GET `/api/preferencias-sensoriais/usuario/{usuarioId}`.

---

## **👥 Equipe**

* [@gabrielCZz](https://github.com/orgs/kgb-fiap/people/gabrielCZz) - Gabriel Cruz | RM 559613  
* [@k-auaferreira](https://github.com/orgs/kgb-fiap/people/k-auaferreira) - Kauã Ferreira | RM 560992  
* [@Vi-debu](https://github.com/orgs/kgb-fiap/people/Vi-debu) - Vinicius Bitú | RM 560227

---

**Neuro-Sync © 2025 - Global Solution FIAP**
