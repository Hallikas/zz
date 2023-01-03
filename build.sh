docker build -t glpi .
docker tag glpi registry.gamehost.fi/semi/glpi:latest
docker push registry.gamehost.fi/semi/glpi:latest
