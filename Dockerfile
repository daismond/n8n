# Dockerfile pour n8n
# Utilise l'image officielle n8n pour un déploiement en production

FROM n8nio/n8n:latest

# L'image officielle n8n a déjà tout configuré
# Pas besoin de redéfinir USER, CMD ou ENTRYPOINT
# Les variables d'environnement peuvent être passées via docker-compose.yml

# Exposer le port par défaut de n8n
EXPOSE 5678

# Volume pour persister les données (déjà configuré dans l'image officielle)
VOLUME ["/home/node/.n8n"]

