FROM arungupta/wildfly-centos
MAINTAINER Arun Gupta <arungupta@redhat.com>

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

RUN curl -O http://mirror.symnds.com/software/Apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.zip && unzip apache-maven-3.2.3-bin.zip && rm apache-maven-3.2.3-bin.zip

# Download and Unzip Java EE 7 Hands-on Lab
RUN curl -O -L https://github.com/javaee-samples/javaee7-hol/raw/master/solution/movieplex7-solution.zip && unzip movieplex7-solution.zip

# Specify the user which should be used to execute all commands below
USER jboss

RUN cd /opt/jboss/movieplex7 && /opt/jboss/apache-maven-3.2.3/bin/mvn -f pom.xml clean package

# Set the default command to run on boot
# This will deploy the generated WAR file
CMD ["/opt/jboss/wildfly/bin/jboss-cli.sh", "--connect", "--command='deploy /opt/jboss/movieplex7/target/movieplex7-1.0-SNAPSHOT.war --force'"]
