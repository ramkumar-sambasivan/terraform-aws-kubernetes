FROM store/oracle/serverjre:8

WORKDIR /app

COPY ./target/helloworld.war /app

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "helloworld.war"]