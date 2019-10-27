#!/bin/bash

# Script: validateHyperlinksInGithubRepo.sh
# Description: Validation of hyperlinks in Github repositories
# License: MIT License
# Author: neikei (https://github.com/neikei/validateHyperlinksInGithubRepo)

url=$1
projectname=$(echo "$url" | grep -oE '[^/]+$')
projectfolder="$projectname-master"
logfile=$(date "+%Y%m%d_%H%M%S")"_$projectname.log"

function log () {
    echo $(date "+%Y-%m-%d %H:%M:%S") ">>" $1 | tee -a $logfile
}

function usage () {
    echo 'FAILED: Missing parameter'
    echo '    Usage: bash validateHyperlinksInGithubRepo.sh "https://github.com/neikei/validateHyperlinksInGithubRepo"'
    exit
}

function validateParameter () {
    if [[ $url == "" ]]; then
        usage
    fi
}

function validateUrl () {
    if [[ $(echo "$url" | grep -coe "http[s]://github\.com\/[-A-Za-z0-9+&@#/%\?\=\~\_\|\!\:\,\.\;]*") != "1" ]]; then
        log "$url is not a Github repository"
        exit
    fi
    if [[ $(echo "$url" | grep -coe "http[s]://[-A-Za-z0-9+&@#/%\?\=\~\_\|\!\:\,\.\;]*") != "1" ]]; then
        log "$url is no valid URL"
        exit
    fi
    if [[ $(curl -I -s -o /dev/null -w "%{http_code}" "$url") -ge 400 ]]; then
        log "$url is not reachable"
        exit
    fi
    log "$url successfully validated"
}

function getRepo () {
    wget "$url"/archive/master.zip &>/dev/null
    unzip master.zip &>/dev/null
    rm master.zip
    log "$url successfully downloaded"
}

function testLinks () {
    for hyperlink in $(find "$projectfolder" -type f -exec grep -oe "http[s]://[-A-Za-z0-9+&@#/%\?\=\~\_\|\!\:\,\.\;]*" {} \;)
    do
        responsecode=$(curl -I -k -s -o /dev/null -w "%{http_code}" --connect-timeout 3 --max-time 10 "$hyperlink")
        if [[ $responsecode == "200" || $responsecode == "302" || $responsecode == "301" ]]; then
            status="OK    "
        else
            status="FAILED"
        fi
        log "$status $responsecode $hyperlink"
    done
}

function cleanup () {
    rm -r "$projectfolder"
    log "$projectfolder successfully cleaned up"
}

validateParameter
log "--------------------------------------------------------------------------------"
log "==> Validate repository URL"
validateUrl
log
log "==> Download repository from Github"
getRepo
log
log "==> Find and test all hyperlinks in the repository"
testLinks
log
log "==> Cleanup downloaded repository"
cleanup
log
log "==> Summary | OK: $(ls *.log | sort -r | head -n 1 | xargs -i grep -c " >> OK" {}) | FAILED: $(ls *.log | sort -r | head -n 1 | xargs -i grep -c " >> FAILED" {})"
log "--------------------------------------------------------------------------------"
