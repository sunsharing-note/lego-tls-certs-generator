#!/bin/bash

cd $(dirname $0)

husky version --skip-push --skip-commit --skip-tag
VERSION=v$(cat .version)

sed -i "s/lego-tls-certs-generator:v.*/lego-tls-certs-generator:${VERSION}/" ci/gitlab-ci.yml
