#!/bin/bash

echo 'Esse é um script com o passo a passo. Não deve ser executado diretamente'
exit

# DEPLOY ENRICHMENT
cd bluetec-message-processor
mvn clean install


# enviar o jar para o servidor na pasta tmp
cd bluetec-telemetry-enrichment-processor
scp target/bluetec-telemetry-enrichment-processor-0.0.1-SNAPSHOT.jar carlos.silva.ext@uatparser:/tmp/bluetec-telemetry-enrichment-processor.jar

# enviar os arquivos de config para o servidor na pasta tmp
scp configs/uat/telemetry-enrichment-processor-config.sh carlos.silva.ext@uatparser:/tmp/
scp configs/uat/telemetry-enrichment-processor.sh carlos.silva.ext@uatparser:/tmp/

# conectar no servidor de uat
ssh carlos.silva.ext@10.41.0.69
sudo su

# matar o processo que estiver rodando
ps aux | grep enrichment
kill <id do processo>

# copiar as configs de startup
cp /tmp/telemetry-enrichment-processor-config.sh /etc/profile.d/
cp /tmp/telemetry-enrichment-processor.sh /usr/bin/


# fazer backup da versão atual 
cd /sistemas/telemetry-enrichment-processor
cp bluetec-telemetry-enrichment-processor.jar bkp__bluetec-telemetry-enrichment-processor.jar

# copiar o jar
cp /tmp/bluetec-telemetry-enrichment-processor.jar .

# executar o sh que inicia o processo
chmod +x /usr/bin/telemetry-enrichment-processor.sh
source /root/.bash_profile
/usr/bin/telemetry-enrichment-processor.sh

# visualizar logs 
tail -f /var/log/telemetry-enrichment-processor/app.log