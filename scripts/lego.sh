#!/bin/bash
#

envsubst < /root/.mc/mc.config.tmpl > /root/.mc/config.json

EMAIL=${EMAIL:-"xxxxxxxxxx"}

REF_NAME=${CI_COMMIT_REF_NAME}
read PROVIDER DOMAINS <<< $(echo ${REF_NAME} | tr '/' ' ')

for domain in $(echo $DOMAINS | sed 's/,/ /g')
do
{
    _domain=$(echo $domain | sed 's/wild./*./')
    DOMAIN_LIST="${DOMAIN_LIST} --domains=${_domain}"
}
done


PARAMS="--dns.resolvers ${RESOLVERS:-223.5.5.5} --key-type rsa2048 --accept-tos ${DOMAIN_LIST} "

function aliyun()
{
    /usr/bin/lego --email="${EMAIL}" ${PARAMS} --path=$(pwd) --dns alidns run 
}

function qcloud()
{
    /usr/bin/lego --email="${EMAIL}" ${PARAMS} --path=$(pwd) --dns dnspod run 
}

function archive()
{
    tar zcf ${DOMAINS}.tgz certificates && mc cp ${DOMAINS}.tgz cos/bucket/ && {

        TGZ=https://xxxxxxxxxx/${DOMAINS}.tgz

        echo ""
        echo $TGZ
        echo "wget -c $TGZ"
    }

    
}

case $PROVIDER in
aliyun)
    aliyun && archive ;;
qcloud)
    export DNSPOD_HTTP_TIMEOUT=${DNSPOD_HTTP_TIMEOUT:-300} ;
    qcloud && archive ;;
esac
