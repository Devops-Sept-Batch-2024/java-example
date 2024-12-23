FFROM alpine:latest AS checkout-stage
RUN apt update && apt install git -y
RUN git clone https://github.com/Devops-Sept-Batch-2024/java-example.git
WORKDIR /java-example

FROM maven:amazoncorretto AS build
WORKDIR /app
COPY --from=checkout-stage /java-example/pom.xml ./
RUN mvn clean package

FROM artisantek/tomcat:1
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]

