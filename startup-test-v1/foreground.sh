#!/bin/bash
systemd-analyze time
systemd-analyze blame --no-pager
echo "Uptime: $SECONDS seconds"

