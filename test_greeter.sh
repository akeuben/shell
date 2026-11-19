#!/usr/bin/env bash
sudo greetd \
    --socket-path /run/greetd-dev.sock \
    --config ./greetd.toml \
    --vt 8
