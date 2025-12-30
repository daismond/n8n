# Installation de n8n avec Docker

Ce projet contient les fichiers nécessaires pour déployer n8n sur un serveur distant avec Docker.

## Prérequis

- Docker installé sur votre serveur
- Docker Compose (optionnel mais recommandé)

## Installation

### Méthode 1 : Avec Docker Compose (Recommandé) ⭐

**Cette méthode utilise directement l'image officielle n8n et évite les problèmes de commande.**

1. Transférez les fichiers sur votre serveur :
   ```bash
   scp -r . user@votre_serveur:/chemin/vers/n8n
   ```

2. Connectez-vous à votre serveur :
   ```bash
   ssh user@votre_serveur
   cd /chemin/vers/n8n
   ```

3. Lancez n8n avec Docker Compose :
   ```bash
   docker-compose up -d
   ```

4. Accédez à n8n via : `http://votre_serveur:5678`

### Méthode 2 : Avec Docker uniquement (Image officielle)

Utilisez directement l'image officielle sans construire :

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  --restart unless-stopped \
  n8nio/n8n:latest
```

### Méthode 3 : Dockerfile personnalisé

Si vous voulez construire une image personnalisée, utilisez `Dockerfile.custom` :

```bash
docker build -f Dockerfile.custom -t n8n-custom .
docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8n-custom
```

## Configuration

### Variables d'environnement importantes

- `N8N_HOST` : Adresse IP d'écoute (par défaut: 0.0.0.0)
- `N8N_PORT` : Port d'écoute (par défaut: 5678)
- `N8N_PROTOCOL` : Protocole (http ou https)
- `NODE_ENV` : Environnement (production ou development)

### Sécurisation (Production)

Pour sécuriser n8n en production, modifiez le fichier `docker-compose.yml` et décommentez les lignes suivantes :

```yaml
- N8N_BASIC_AUTH_ACTIVE=true
- N8N_BASIC_AUTH_USER=admin
- N8N_BASIC_AUTH_PASSWORD=your_secure_password
```

### Utilisation avec une base de données PostgreSQL

Pour utiliser une base de données externe, décommentez et configurez les variables de base de données dans `docker-compose.yml`.

## Gestion

### Voir les logs
```bash
docker-compose logs -f n8n
# ou
docker logs -f n8n
```

### Arrêter n8n
```bash
docker-compose down
# ou
docker stop n8n
```

### Redémarrer n8n
```bash
docker-compose restart
# ou
docker restart n8n
```

### Mettre à jour n8n
```bash
docker-compose pull
docker-compose up -d
```

## Sauvegarde

Les données sont stockées dans le volume Docker `n8n_data`. Pour sauvegarder :

```bash
docker run --rm -v n8n_data:/data -v $(pwd):/backup alpine tar czf /backup/n8n-backup.tar.gz -C /data .
```

## Restauration

```bash
docker run --rm -v n8n_data:/data -v $(pwd):/backup alpine tar xzf /backup/n8n-backup.tar.gz -C /data
```

## Dépannage

### Erreur "Command n8n not found"

Si vous rencontrez l'erreur `Error: Command "n8n" not found`, cela signifie que vous essayez de construire une image personnalisée qui ne fonctionne pas correctement.

**Solution recommandée** : Utilisez directement l'image officielle via `docker-compose.yml` (déjà configuré par défaut).

Si vous devez absolument construire une image, utilisez `Dockerfile.custom` qui installe n8n correctement :

```bash
docker build -f Dockerfile.custom -t n8n-custom .
```

Ou modifiez `docker-compose.yml` pour utiliser l'image officielle directement (déjà fait par défaut) :

```yaml
services:
  n8n:
    image: n8nio/n8n:latest  # Au lieu de build: .
```

### Vérifier que le conteneur fonctionne

```bash
docker logs n8n
```

Vous devriez voir des messages indiquant que n8n démarre correctement.

## Support

Documentation officielle : https://docs.n8n.io/

