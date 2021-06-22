set -e

docker build -t fastapi:$1 -f docker/$1/Dockerfile .
docker tag fastapi:$1 ihsansolusi/fastapi:$1
