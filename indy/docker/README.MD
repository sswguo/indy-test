#### Build the test image locally  

```
docker build -t indy:1.0 .
```

#### Tag the image

```
docker tag indy:1.0 jind0001/indy:1.0
```

#### Push the image

_note:_ Before push the image, make sure that you login into the docker registry

```
docker login docker.io

docker push jind0001/indy:1.0
```

#### Check the remote image
[Docker repo](https://cloud.docker.com/repository/docker/jind0001/indy)
