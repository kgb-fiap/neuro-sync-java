# **🧠 Neuro-Sync API**

**Backend para inclusão produtiva com monitoramento sensorial e reservas inteligentes**

---

## **📖 Sobre o Projeto**

**Neuro-Sync API** é o backend REST (Spring Boot) do desafio **Global Solution 2025 - O Futuro do Trabalho**.  
Exposição de serviços para reservas de estações, preferências sensoriais, autenticação JWT e indicadores calculados a partir do Oracle.

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
│   │       └── application.yml      # (use variáveis de ambiente)
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
