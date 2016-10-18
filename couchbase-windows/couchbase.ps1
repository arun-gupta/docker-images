#Install Chocolatey package manager
iex (wget 'https://chocolatey.org/install.ps1' -UseBasicParsing)

#Install Couchbase
choco install -y --allow-empty-checksums couchbase-server-community

