# Camunda 7.24 + Spring Boot 4.1 compatibility patches

Unofficial patch set that makes **Camunda BPM Platform 7.24.0 (community edition)** work with
**Spring Boot 4.1.x** on **Java 21**.

This project is not affiliated with, endorsed by, or supported by Camunda. It contains no Camunda
Enterprise Edition code or `-ee` artifacts. It is provided as-is, without warranty.

## Compatibility

| Component | Version |
|---|---|
| Camunda BPM Platform | 7.24.0 (upstream tag `7.24.0`, commit `43f5c7f41c46af2e2b7e35ed85290b117400b939`) |
| Spring Boot | 4.1.2 |
| Java | 21 |
| Jakarta EE | 11 |
| PostgreSQL | 15–18 (tested on 17) |
| H2 (smoke app only) | 2.3.232 |

The patch set is intentionally small: a parent POM version bump plus Spring Boot 4 package/API
changes inside `spring-boot-starter`. The engine and REST modules are used as published upstream.

## Repository contents

- `patches/` — patch series for upstream Camunda 7.24.0.
- `smoke-app/` — minimal Spring Boot 4.1 + Camunda 7.24 application (H2 by default).
- `scripts/` — helper scripts for applying patches and building the smoke app.
- `SECURITY.md` — private vulnerability reporting.
- `CONTRIBUTING.md` — contribution rules.

## Apply the patches

Requirements: Git, JDK 21, and Maven 3.9+ (the upstream repository also provides `mvnw`).

```bash
git clone https://github.com/camunda/camunda-bpm-platform.git
cd camunda-bpm-platform
git checkout 7.24.0

REPO=/path/to/camunda-7.24-boot4-compat
for patch in "$REPO"/patches/*.patch; do
  git apply --check "$patch"
  git apply "$patch"
done

./mvnw -DskipTests install
```

Or use the helper:

```bash
./scripts/apply-patches.sh /path/to/camunda-bpm-platform
```

The upstream project is archived, but the `7.24.0` tag is still available.

## Build and run the smoke app

The patched Camunda `7.24.0` artifacts must first be installed into the local Maven repository.

```bash
mvn -f smoke-app/pom.xml -DskipTests package
java -jar smoke-app/target/camunda-boot4-smoke-0.0.1-SNAPSHOT.jar
```

The app starts on port `8080` with an in-memory H2 database and auto-deploys
`src/main/resources/processes/smoke.bpmn`.

Quick checks:

```bash
curl -s http://localhost:8080/engine-rest/version
curl -s http://localhost:8080/engine-rest/process-definition
curl -s -X POST http://localhost:8080/engine-rest/process-definition/key/smoke-process/start \
  -H 'Content-Type: application/json' -d '{"businessKey":"smoke-1"}'
```

To use PostgreSQL, override the Spring datasource settings and enable schema update:

```bash
java -jar smoke-app/target/camunda-boot4-smoke-0.0.1-SNAPSHOT.jar \
  --spring.datasource.url=jdbc:postgresql://localhost:5432/camunda_smoke \
  --spring.datasource.username=postgres \
  --spring.datasource.password=postgres
```

## Use in your project

Because the patches are applied to upstream source and installed locally, the dependency
coordinates remain the same:

```xml
<dependency>
  <groupId>org.camunda.bpm.springboot</groupId>
  <artifactId>camunda-bpm-spring-boot-starter-rest</artifactId>
  <version>7.24.0</version>
</dependency>
```

This repository does **not** publish binaries. Do not publish these patched artifacts under the
`org.camunda.bpm` coordinates to Maven Central; they are the same coordinates as the official
release. If you need to distribute binaries, rebuild with your own `groupId` and version.

## Scope and limitations

- The smoke app exercises the engine, REST API, and Spring Boot starter path. Other Camunda 7.24
  modules are not part of the compatibility guarantee.
- Camunda 7.24 is the last community edition released on Maven Central and the upstream repository
  is archived. This project is community-maintained, with best-effort support and no SLA.
- Spring Boot 4.1 is newer than Camunda's published support matrix. Test your own BPMN models,
  Java delegates, listeners, and plugins.
- No Enterprise Edition features, connectors, or `-ee` artifacts are included.

## Reporting issues

- Use GitHub Issues for reproducible bugs and questions. Include Camunda, Spring Boot, Java and
  database versions, steps, expected/actual behavior, and sanitized logs.
- Report security vulnerabilities privately as described in `SECURITY.md`. Do not open a public
  issue for a vulnerability.
- Pull requests are welcome; see `CONTRIBUTING.md`. Sign off your commits with `git commit -s`.

## License

Apache License 2.0. See `LICENSE` and `NOTICE`. The upstream copyright and attribution notices are
preserved. See `FORK-NOTICE.md` for the relationship to the upstream project.

## 中文简介

这是 Camunda 7.24.0 社区版适配 Spring Boot 4.1 / Java 21 的非官方补丁集，不包含企业版功能。
补丁应用在上游源码后本地构建，不发布同坐标二进制。`smoke-app/` 提供最小可运行示例。
问题请通过 GitHub Issues 提交，安全漏洞请按 `SECURITY.md` 私下报告。
