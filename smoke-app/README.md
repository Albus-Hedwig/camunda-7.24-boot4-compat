# Smoke application

Minimal Camunda 7.24 + Spring Boot 4.1.2 application used to verify the patch set.
It uses an in-memory H2 database by default and auto-deploys `processes/smoke.bpmn`.

## Prerequisites

1. Apply the patches to Camunda 7.24.0 and install the patched artifacts:

   ```bash
   ../scripts/apply-patches.sh /path/to/camunda-bpm-platform
   cd /path/to/camunda-bpm-platform
   ./mvnw -DskipTests install
   ```

2. Use JDK 21 and Maven 3.9+.

## Build and run

```bash
mvn -f smoke-app/pom.xml -DskipTests package
java -jar smoke-app/target/camunda-boot4-smoke-0.0.1-SNAPSHOT.jar
```

The application starts on port `8080`.

## Smoke checks

```bash
curl -s http://localhost:8080/engine-rest/version
curl -s http://localhost:8080/engine-rest/process-definition
curl -s -X POST http://localhost:8080/engine-rest/process-definition/key/smoke-process/start \
  -H 'Content-Type: application/json' -d '{"businessKey":"smoke-1"}'
curl -s 'http://localhost:8080/engine-rest/task?processInstanceBusinessKey=smoke-1'
```

Complete the returned task:

```bash
curl -s -X POST http://localhost:8080/engine-rest/task/{taskId}/complete \
  -H 'Content-Type: application/json' -d '{}'
```

## PostgreSQL

Override the datasource and run against an empty database:

```bash
java -jar smoke-app/target/camunda-boot4-smoke-0.0.1-SNAPSHOT.jar \
  --spring.datasource.url=jdbc:postgresql://localhost:5432/camunda_smoke \
  --spring.datasource.username=postgres \
  --spring.datasource.password=postgres
```

Camunda creates the schema automatically because `camunda.bpm.database.schema-update` is enabled in
`application.yaml`. Back up an existing database before pointing the smoke app at it.
