# How to use this image

## Starting the image
```shell
docker run -p 80:80 -p 1935:1935 -d schroenser/nginx-rtmp:latest
```

## Docker compose
```yaml
version: "3.3"
services:
  nginx-rtmp:
    image: schroenser/nginx-rtmp:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "1935:1935"
```