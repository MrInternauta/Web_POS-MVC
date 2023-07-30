

# POS (Punto de venta)
Sistema punto de venta
## Descripcion 
Un pequeño sistema punto de venta, hecho con PHP, AJAX, JQUERY, JS, CSS, HTML

## Build the image
sudo docker build -f ./Dockerfile.prod -t web_pos .
## Run the image
sudo docker run -p 8080:80 -p 3306:3306 bb8e1e1c9fa7
## Instalación
```
importar la base de datos e iniciar apache.
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
