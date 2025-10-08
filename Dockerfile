# استخدم JDK لتجميع المشروع
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# استخدم JRE لتشغيل التطبيق
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# المنفذ الذي سيستخدمه Render
ENV PORT=8080
EXPOSE 8080

# أمر التشغيل
CMD ["java", "-jar", "app.jar"]
