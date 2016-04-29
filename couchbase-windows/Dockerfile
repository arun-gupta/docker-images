FROM windowsservercore

RUN powershell -Command \
    Invoke-WebRequest -Method Get -Uri http://packages.couchbase.com/releases/4.5.0-DP1/couchbase-server-enterprise_4.5.0-DP1-windows_amd64.exe -OutFile c:\couchbase.exe ; \
    Invoke-WebRequest -Method Get -Uri https://gist.github.com/arun-gupta/a3858d6fc0cdfac5afa27f650844619b -OutFile c:\install.iss ; \
    C:\\couchbase.exe /s /f1"c:\install.iss" ; \
    C:\\couchbase\\server\\bin\\service_stop.bat

WORKDIR C:\\couchbase\\server

CMD ["C:\\couchbase\\server\\bin\\service_start.bat"]
