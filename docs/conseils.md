# Conseils

## Python
Utilisez PyEnv et les virtualenv de python pour ne pas installer pleins de libs dans tous les sens
PyEnv va vous permettre de gérer plusieurs version de python ce qui peut être utile, pour ce projet par exemple, après avoir installé pyenv
```bash
pyenv install 3.13
pyenv local 3.13 # ça va créer un fichier .python-version dans le répertoire local au moins on sait que ça fonctionne avec la version X.Y.Z de Python
python -m venv .venv # On crée un dossier .venv qui contiendra les libs python pour le projets, comme ça quand on supprime le projet on ne conserve pas les lib
source .venv/bin/activate # On active le venv
pip install redis flask # On installe
pip freeze > azure-vote/requirements.txt # On freeze les versions, comme ça on évite de casser le projet sur un simple upgrade 
```
Cette partie est utile pour le dev en local surtout ! Si vous êtes sur un repositorie git pensez a toujours exclure le dossier .venv dans le fichier `.gitignore`

## Docker

On peut gérer le build directement depuis le `docker-compose.yml` avec 
```yaml
services:
  azure-vote-front:
    build:
      context: .
```
ça évite de faire un `docker build` puis `docker compose up`.

Docker Desktop est devenu payant pour les entreprises depuis quelques années, vous pouvez utiliser différentes alternatives comme Rancher, OrbStack ou Podman