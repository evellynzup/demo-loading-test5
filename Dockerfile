FROM amazoncorretto:17-alpine as base
RUN addgroup --system app && \
  adduser -S -s /bin/false -G app app && \
  mkdir -p /opt/app/target/classes && \
  chown -R app:app /opt/app && \
  apk add --no-cache musl-dev libc6-compat dumb-init && \
  ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2
USER app
WORKDIR /opt/app

FROM base as builder
COPY --chown=app:app src src
COPY --chown=app:app build.gradle.kts build.gradle.kts
COPY --chown=app:app settings.gradle.kts settings.gradle.kts
COPY --chown=app:app --chmod=555 gradlew gradlew
COPY --chown=app:app --chmod=555 gradle gradle
RUN ./gradlew clean build --stacktrace -x test

FROM base as runtime
COPY --chown=app:app --chmod=555 --from=builder /opt/app/target/-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD dumb-init java -jar app.jar
