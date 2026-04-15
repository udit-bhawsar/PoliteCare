# Step 1: Project ko Maven se build karna
FROM maven:3.8.4-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Tomcat par deployment
FROM tomcat:10.1-jdk17
# Tomcat ki purani file saaf karo
RUN rm -rf /usr/local/tomcat/webapps/*
# Hamari project war file ko Tomcat me copy karke naam 'ROOT.war' rakhdo
COPY --from=build /target/*.war /usr/local/tomcat/webapps/ROOT.war

# Folder jahan images save hongi (Disk ke liye)
RUN mkdir -p /data/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]