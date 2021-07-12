#!/bin/bash
set -euo pipefail

echo; echo "[$(date)] $0 job has been started."

echo; echo "# Creating directories"
mkdir -p {analysis/$(date +%F),data/$(date +%F),scripts}

echo; echo "# Running Shell Script for Downloading Data"
bash scripts/run_data_downloader.sh

echo; echo "# Running Shell Script for Inspecting Data"
bash scripts/run_data_inspector2.sh > analysis/output.txt

echo; echo "# Print operating system characteristics"
uname -a
sw_vers

# Done
echo; echo "[$(date)] $0 has been successfully completed."

: <<'#__COMMENT_OUT__'

(bash scripts/run_all.sh &) >& log.$(date +%F).txt

#__COMMENT_OUT__

