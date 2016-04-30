FROM windowsservercore

RUN powershell -Command \
    Invoke-WebRequest -Method Get -Uri http://packages.couchbase.com/releases/4.5.0-DP1/couchbase-server-enterprise_4.5.0-DP1-windows_amd64.exe -OutFile c:\couchbase.exe ; \
    Invoke-WebRequest -Method Get -Uri https://gist.githubusercontent.com/arun-gupta/a3858d6fc0cdfac5afa27f650844619b/raw/0a6a48275fbae57cc2374cb64b6904149c1a5bc3/Couchbase%25204.5%2520Headless%2520install%2520on%2520Windows -OutFile c:\install.iss ; \
    C:\\couchbase.exe /s /f1"c:\\install.iss" ;

WORKDIR C:\\Couchbase\\Server\\bin

RUN powershell -Command Start-Sleep -Seconds 120; \
    service_stop.bat

CMD ["service_start.bat"]
