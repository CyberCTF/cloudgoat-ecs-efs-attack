#!/bin/sh
# The foothold works: the ruse box accepts the lab's SSH key (made by terraform/keygen.sh).
set -eu
ssh -i .keys/cloudgoat -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=10 \
  -o BatchMode=yes -o LogLevel=ERROR "ubuntu@$ISOLOOM_OUTPUT_RUSE_BOX_IP" true
