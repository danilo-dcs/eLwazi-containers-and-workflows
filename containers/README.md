# Containers Instructions

### Building the images: 
```
docker build -t <image_name>:<tag> <repository_path> 
```

### Runnig the container iteratively:
```
docker run -it <image_name>:<tag>
```


### To login in your docker hub account:
```
docker login
```

### To logout from your docker hub account:
```
docker logout
```

### To create a tag between the image you build and the repository in docker hub:
```
docker image tag <image_name>:<tag> <dockerhub_repository_name>/<image_name>:<tag>
```

### To push an image to docker hub:
```
docker push <dockerhub_repository_name>/<image_name>:<tag>
```
