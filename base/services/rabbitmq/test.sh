#!/bin/bash

set -eo pipefail

kubectl -n rabbitmq exec rabbitmq-server-0 -c rabbitmq -- \
  rabbitmqctl authenticate_user ba-admin super-secure-password
