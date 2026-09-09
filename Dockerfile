# Etapa 1: Construcción del proyecto con Maven y Java 21
FROM eclipse-temurin:21-jdk-jammy AS build

WORKDIR /app

# Copiamos el wrapper de Maven y el pom.xml primero para aprovechar el cache de capas de Docker
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copiamos el resto del código fuente y construimos el .jar
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# Etapa 2: Imagen final, solo con el runtime necesario
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copiamos únicamente el .jar generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]