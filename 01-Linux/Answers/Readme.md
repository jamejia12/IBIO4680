# Labs 01 y 02

## Punto 1
El comando *grep* es utilizado para encontrar una palabra de interés (un patrón de caracteres) en un archivo dado.
El output de este comando son las líneas que contengan la palabra que se esta buscando.
El comando permite buscar mas de un patrón de strings a la vez (usando -e y -f).
El comando permite buscar en todos los archivos presentes en un folder, usando la opción -r.
Otra opción útil es -i. Esta opción ignora la distinción entre mayúsculas y minúsculas.

## Punto 2
El '#!/bin/bash' es un indicador de cómo leer el script en cuestión.
En este caso, bin bash debe ser ejecutado usando sf, Bourne sheel o un shell compatible.
Otra modificación es '#!/bin/bash'. En este caso se debe ejecutar usando csh, C sheel o algo compatible.
En conlcusión, dice qué tipo de sheel se debe usar para hacer uso de un archivo.

## Punto 3
**Existen 42 usuarios en el servidor 157.253.63.7.**

Para lograr obtener esto se utilizó el comando cat /etc/passwd, el cual da la información de todos los usuarios presentes en el servidor.

![Usuarios](https://github.com/jamejia12/IBIO4680/tree/master/01-Linux/Imagenes/3.png)

La información de los usuarios esta delimitada por *:*. Es decir, hay 7 características obtenidas por dicho comando.
En su orden son:
-Nombre de usuario.
-Password(si es x esta encriptada)
-ID del usuario.
-Grupo principal del usuario.
-Info adicional del usuario (opcional).
-Carpeta personal del usuairio (nombre de usuario por defecto).
-Shell del usuario.

Finalmente, usando wc -l se cuenta y se muestra el número de lineas (y por ende de usuarios) que son obtenidos al ejecutar el comando explicado anteriormente.

## Punto 4
Teniendo en cuenta lo explicado en el punto 3, los items de interés son el 1 y el 7 (nombre y shell).
Para únicamente tener esos items en un txt se uso el comando cut.

![UsersAndShells](https://github.com/jamejia12/IBIO4680/tree/master/01-Linux/Imagenes/4_1.png)

El comando cut tiene una opción -d que permite especificar cuál es el delimitador en el cual se deben cortar los strings.
En este caso el delimitador es *:*, como se explicó en el punto 3.
Otra opción del comando cut es -f. Esta permite tomar únicamente los campos o segmentos cortados especificados.
En este caso, los campos de interés son el 1 y el 7.
Finalmente, otra opción es --output-delimiter='', el cual permite reemplazar el delimitador por lo que desee el usuario.
En este caso, por facilidad se reemplazó con un espacio vacío.

Para ordenar la lista de usuarios por su shell hay que tener en cuenta el campo 2.

![Sorted](https://github.com/jamejia12/IBIO4680/tree/master/01-Linux/Imagenes/4_2.png)

Sort tiene una opción (-k) que permite elegir bajo qué columna se debe ordenar.
Usando ello se obtiene la lista final de usuarios ordenada por su tipo de shell.

## Punto 5
cksum da como output un número para un archivo basado en su contenido y en su peso.
El script propuesto permite encontrar imágenes exactamente iguales.
El script busca a través de todos los archivos de imagen presentes en una carpeta.

```
# Encuentra todas las imagenes presentes en la maquina, y guarda las rutas y el$
find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' > imgs.txt

# Se queda unicamente con las rutas de las imagenes
images=$(cut imgs.txt -d' ' -f1)

# Recorre todas las rutas de las imagenes.

# La idea es que se pare en una imagen y compare con las otras (doble recorrido).
# Si el checksum de las dos es igual, que guarde la ruta de la comparada y lo guarde en un txt.
# Al final se tendran tantos txt como imagenes repetidas.

for im in ${images[*]}
do
   # Toma el valor de cksum para el archivo a comparar.
   c1 = cksum $im | cut -d' ' -f1
   
   for imc in ${images[*]}
   do
      # Toma el valor de cksum del archivo con el que se va a comparar.
      c2 = cksum $imc | cut -d' ' -f1
      
      if [c1 -eq c2]
      then
          echo $im y $imc son duplicados.
      fi
   done
done
```

## Punto 6
Para descargar la base de datos se utilizó wget con el url del archivo.

![Sorted](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/6.png)

Para descomprimirlo se utilizó tar con -xf (extraer y que es un file).

## Punto 7
**La carpeta descomprimida pesa aproximadamente 71MB.**
Para ello se utilizó el comando ls -l (muestra en lista) --block-size='MB' (da el tamaño de los archivos listados).

![Size](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/7_7.png)

También se intentó utilizar los comandos ls -s (size) pero no se sabía en qué unidades era el output.
Otra alternativa fue usar el comando ls -l -h (tamaño reconocible por humano), pero el tamaño no fue el esperado (69M).


**Las carpetas test, train y val al interior de la carpeta imgs tienen 500 imagenes.**
Para ello se usó un wc -l porque se supusó que habia solo imágenes al interior de la carpeta. Esto dio un total de 503 imágenes.

![NumImgs](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/7_1.png)

Sin embargo, al ingresar a las carpetas se observo la presencia de un archivo .db por carpeta.
Restando esos .db, se tienen las 500 imágenes presentes en el directorio mencionado.

![dbFile](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/7_2.png)
![dbFile](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/7_3.png)
![dbFile](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/7_4.png)

Para evitar tener que hacer esas comprobaciones manuales se sugiere usar un comando para identificar imágenes como el propuesto en el punto 5.

## Punto 8
**Las imágenes tienen una resolucion de 481x321 o 321x481. El formato es .jpg (JPEG) y estan almacenadas en formato de 8bits.**

Para ello se utilizó el siguiente codigo:

```
imgs=$(find train -name *.jpg)
for im in ${imgs[*]}
do
   identify -ping $im
done
```

find encuentra todos los archivos .jpg (que ya se sabía que eran de ese formato por inspección, nuevamente se sugiere usar lo del punto 5).
Luego recorre dichas imágenes y al usar identify -ping, se obtiene información básica de la imagen.

## Punto 9
**Hay 348 imágenes en orientación landscape.**
Usando la información brindada por identify -ping, se sabe que la resolución está en la tercera columna.
Utilizando lo del punto 4 (cut -d -f3) se obtiene únicamente la resolución de las imágenes.

![Resolution](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/9_1.png)

El mismo procedimiento se realizó en las tres carpetas (test, train y val) y se guardó en txt.

![Resolution](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/9_2.png)

Finalmente, se sabe que una imagen está en landscape si su primer número es mayor al segundo (481*321).
Realizando un wc -l en los 3 txt de resoluciones por carpeta, se obtuvo el numero de imagenes en landscape (348).

![NumLandscape](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/9_3.png)


## Punto 10
**Para recortar todas las imagenes de 256x256 se usó convert -gravity Center -crop 256x256+0+0 +repage *.jpg** 

![Crop](https://github.com/jamejia12/IBIO4680/blob/master/01-Linux/Imagenes/10_3.png)

convert es la herramienta para editar imágenes usando imagemagick.
La opción -gravity permite especificar en dónde fijarse. En este caso se busca fijarse en el centro.
La opción -crop recorta la imagen segun las especificaciones dadas (si no se pone el +0+0 para especificar en qué posición pararse, se crean más imágenes de las que se deberían crear).
*.jpg especifica el formato a recortar.
+repage borra información del borde de la imágen recortada (que el borde se ajuste al recorte).

Usando esta alternativa la imagen queda de 256x256 pero se pierde información.

Para conservar informacion se puede utilizar 'mogrify -resize' o 'convert -crop'.
Sin embargo, al utilizar estos codigos, la imagen de salida no queda de 256x256 (el canvas queda de esa dimensión, pero la imagen como tal queda limitada por las dimensiones originales).


## Referencias
Punto 1: 
https://www.cyberciti.biz/faq/howto-use-grep-command-in-linux-unix/

Punto 2: 
https://stackoverflow.com/questions/13872048/bash-script-what-does-bin-bash-mean

Punto 3: 
https://www.cyberciti.biz/faq/linux-list-users-command/
https://www.computerhope.com/unix/upasswor.htm

Punto 4: 
https://www.cyberciti.biz/faq/linux-list-users-command/
https://www.thegeekstuff.com/2013/06/cut-command-examples
http://www.ubuntu-es.org/node/131720#.WnO0ILXLfQo
http://francisconi.org/linux/comandos/sort

Punto 5: 
https://www.clonefileschecker.com/blog/hashing-algorithms-to-find-duplicates/
https://www.controlledvocabulary.com/imagedatabases/de-dupe.html
https://www.thegeekstuff.com/2012/07/cksum-command-examples/
https://stackoverflow.com/questions/16758105/linux-find-list-all-graphic-image-files-with-find

Punto 7:
https://unix.stackexchange.com/questions/64148/how-do-i-make-ls-show-file-sizes-in-megabytes/64149
https://stackoverflow.com/questions/20895290/count-number-of-files-within-a-directory-in-linux-not-using-wc

Punto 8:
https://blog.desdelinux.net/como-manipular-imagenes-desde-el-terminal/

Punto 10:
http://www.imagemagick.org/Usage/crop/#crop
