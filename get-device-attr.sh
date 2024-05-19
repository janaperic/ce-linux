#!/bin/bash

# Bash script for gathering information about device inventory via Mender API.
# Usage: ./get-device-attr.sh [attribute]
# Make sure script is executable. To make it executable, run: chmod +x get-device-attr.sh 

MENDER_SERVER_URI='https://eu.hosted.mender.io'
PERSONAL_ACCESS_TOKEN='eyJhbGciOiJSUzI1NiIsImtpZCI6MCwidHlwIjoiSldUIn0.eyJqdGkiOiJhNzMxNWYwMy1iNjNmLTQ1NjQtYmNhMi1kYzEyOGVkMDk1MzkiLCJzdWIiOiI0MWZiYmJmNC1lMmZlLTQ4MzUtOTc2OC05YmY1NmM4OGQ2NWYiLCJleHAiOjE3NDc1OTU1NzYsImlhdCI6MTcxNjA1OTU3NiwibWVuZGVyLnRlbmFudCI6IjY2NDhmNjAzODlkNDIzNjNiOTM2Nzg5MCIsIm1lbmRlci51c2VyIjp0cnVlLCJpc3MiOiJldS5ob3N0ZWQubWVuZGVyLmlvIiwic2NwIjoibWVuZGVyLioiLCJtZW5kZXIucGxhbiI6ImVudGVycHJpc2UiLCJtZW5kZXIudHJpYWwiOnRydWUsIm1lbmRlci5hZGRvbnMiOlt7Im5hbWUiOiJjb25maWd1cmUiLCJlbmFibGVkIjp0cnVlfSx7Im5hbWUiOiJ0cm91Ymxlc2hvb3QiLCJlbmFibGVkIjp0cnVlfSx7Im5hbWUiOiJtb25pdG9yIiwiZW5hYmxlZCI6dHJ1ZX1dLCJuYmYiOjE3MTYwNTk1NzZ9.nMpoxC3kJ71S7l1O0pYafjLflO2yGCv-0veFNHiiKWi2gM0oVsAVFAuux9PKQsL8BN6QtKxUMD-lZMMwe_G4SLZPDbilTPcfDHvF1W6bCOPeBGWRLOn-o90u87HhnuFNmbpRPr5x9zyT0bGhi7VktIyaLSRRMRiHj4AIdQBoCcNZrqIx0qdTJCGdHM5-9fOmYSyvH_pcRCeqcccdirmOA47_WdNKOHHODExqChU5ZYX3IcYxPOhugGQlOrMnDIH0N66ilbAyfrQbOeG5EfIdQesCFL5LLsb2t2z71ln4v7PvVZuWTaLaIDbAdEyPnKs_goenTo2KF_oG3V_MZC2-hqB6V5O5zePkGbce5qOcjVTFEYhOMT54ggmV4dGw3P-nT8fSCjL-es_y2TGF1bGQARP2GxBXTW55WENb-4gRtVIeDRhTBFvzjlRN6__ly6oAJ3A_WCpvjVBD7lfax-loND1SuwLwi7xTav3IU_W3VbROjDymnDGWGT3bHXvUorkD'

if [ -z "$1" ]
then
	echo "Please specify desired attribute, for example: './get-device-attr.sh rootfs_type'"
	exit 0
fi

curl -s -H "Authorization: Bearer $PERSONAL_ACCESS_TOKEN" $MENDER_SERVER_URI/api/management/v1/inventory/devices  | jq '.' > device-attr.json

value=$(jq --arg name "$1" '.[].attributes[] | select(.name == $name) | .value' device-attr.json)
jq_exit_status=$?

if [ $jq_exit_status -eq 0 ]; then
    if [ -z "$value" ]; then
        echo "The .value field for $1 is empty or does not exist."
    else
        echo "$value"
    fi
else
    echo "jq failed with exit status $jq_exit_status"
fi

exit 0
