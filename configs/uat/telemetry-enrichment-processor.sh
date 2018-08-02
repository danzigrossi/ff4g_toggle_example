#!/bin/bash

source /etc/profile.d/telemetry-enrichment-processor-config.sh

nohup java -jar /sistemas/telemetry-enrichment-processor/bluetec-telemetry-enrichment-processor.jar > /var/log/telemetry-enrichment-processor/app.log &
echo "Starting telemetry-enrichment-processor"
