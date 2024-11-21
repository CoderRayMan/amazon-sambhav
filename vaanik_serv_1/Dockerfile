FROM amazoncorretto:17.0.13-alpine3.20
COPY vaanik_serv_1-0.0.1-SNAPSHOT.jar .
RUN sh -c 'touch vaanik_serv_1-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-jar","vaanik_serv_1-0.0.1-SNAPSHOT.jar"]