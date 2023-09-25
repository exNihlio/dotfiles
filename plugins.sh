#!/usr/bin/env bash

NVIM_PLUGIN_START_PATH="${HOME}/.local/share/nvim/site/pack/plugins/start"
PLUGIN_URLS=("https://github.com/morhetz/gruvbox" "https://github.com/kevinhwang91/rnvimr")

function main {
  pip3 install -r requirements.txt &>/dev/null
	for i in ${PLUGIN_URLS[@]}; do
		PLUGIN=$(echo ${i} | awk -F'/' {'print $NF'})
		if [[ -d "${NVIM_PUGIN_START_PATH}/${PLUGIN}" ]]; then
      echo "Updating: ${PLUGIN}"
			git fetch ${i} ${NVIM_PLUGIN_START_PATH}/${PLUGIN} 
		else
			mkdir -p ${NVIM_PLUGIN_START_PATH}/${PLUGIN}
			git clone ${i} ${NVIM_PLUGIN_START_PATH}/${PLUGIN}
		fi
	done
}

main
