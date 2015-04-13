FROM java:8
MAINTAINER Arun Gupta <arun.gupta@gmail.com>

EXPOSE 25565 ??

EXPOSE 2376 ??

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Generate spigot-1.8.jar
RUN ["java", "-Xmx1024m", "-jar", "BuildTools.jar", "--rev", "1.8"]

# Run the server once to generate eula.txt
RUN ["java", "-Xmx1024m", "-jar", "spigot-1.8.jar"]

# Set eula=true so that server can start successfully
RUN ["echo", "eula", "=", $EULA, ">>", "eula.txt"]

# Fire the server
CMD ["java", "-Xmx1024m", "-jar", "spigot-1.8.jar"]
