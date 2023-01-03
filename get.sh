V=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/latest | grep tag_name | cut -d '"' -f 4)
L=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${V} |\
	jq .assets[0].browser_download_url | tr -d \")
wget -O glpi-latest.tgz $L
