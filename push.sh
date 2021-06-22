set -e

docker tag fastapi:$1 ihsansolusi/fastapi:$1
docker push ihsansolusi/fastapi:$1
