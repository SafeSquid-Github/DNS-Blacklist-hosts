#!/bin/bash

URL_LIST="/usr/local/src/dnsbl_openSource_data/url_list.txt"
HOST_FILES_DIR="/usr/local/src/dnsbl_openSource_data/host_file"

while read -r URL
do 
    FILE_NAME=$(echo "${URL}" | awk -F'/' '{print $(NF-1)}')
    [ ! -d "${HOST_FILES_DIR}" ] && echo "INFO: ${HOST_FILES_DIR} NOT FOUND, CREATING NEW DIR" && mkdir "${HOST_FILES_DIR}"
    [ -f "${FILE_NAME}" ] && echo "INFO: ${FILE_NAME} FOUND" && continue
    echo "INFO: FETCH DATA FROM ${URL}"
    curl --silent "${URL}" | awk '($1 ~ /0.0.0.0/ && $2 != "0.0.0.0") {print $2}' > "${HOST_FILES_DIR}/${FILE_NAME}"
    echo "INFO: OUTPUT SAVED TO "${HOST_FILES_DIR}/${FILE_NAME}""

done < "${URL_LIST}"
