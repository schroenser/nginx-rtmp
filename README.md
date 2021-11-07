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

## Building the player
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
