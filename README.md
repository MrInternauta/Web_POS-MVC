

# POS (Punto de venta)
Sistema punto de venta
## Descripcion 
Un pequeño sistema punto de venta, hecho con PHP, AJAX, JQUERY, JS, CSS, HTML

## Build the image
sudo docker build -f ./Dockerfile.prod -t web_pos .
## Run the image
sudo docker run -p 8080:80 -p 3306:3306 03b24be91342
## Instalación
```
importar la base de datos e iniciar apache.

```
## Tag versión
```
sudo docker tag web_pos:latest public.ecr.aws/xxx/web_pos:latest
```

## Login
```
aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/xxx
```

## push
```
sudo docker push public.ecr.aws/xxxx/web_pos:latest
```
## Uso
```
login: admin
pass:  admin
```

## Créditos
- [@MrInternauta](https://twitter.com/mrinternauta)

## Licencia
[MIT](https://opensource.org/licenses/MIT)
