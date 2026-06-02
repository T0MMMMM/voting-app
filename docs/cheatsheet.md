# Cheat Sheet

|`docker ps`| Affiche les containers en cours d'execution|
|`docker ps -a`| affiche tous les containers même stoppé|
|`docker rm <container name or container id>`| supprime le container |
|`docker images`| liste les images docker sur le système |
|`docker rmi <image name or image id>`| supprimer une image docker |
|`docker build -t <image>:<tag> <context>`| Build une image docker |
|
|`docker compose up` | Lance le docker compose |
|`docker compose up -d`| Lance le docker compose en arrière plan |
|`docker compose up --build`| Lance le docker compose et build les images si le bloc build est présent |
|`docker compose stop`| Stoppe les containers du docker compose |
|`docker compose start`| Démarre les containers du docker compose |
|`docker compose down`| Stoppe et supprime les containers du docker compose |
|`docker compose ps`| Affiche les containers du docker compose|