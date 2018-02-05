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

![Usuarios](/home/lubuntu/Downloads/3.png)

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

![UsersAndShells](/home/lubuntu/Downloads/4_1.png)

El comando cut tiene una opción -d que permite especificar cuál es el delimitador en el cual se deben cortar los strings.
En este caso el delimitador es *:*, como se explicó en el punto 3.
Otra opción del comando cut es -f. Esta permite tomar únicamente los campos o segmentos cortados especificados.
En este caso, los campos de interés son el 1 y el 7.
Finalmente, otra opción es --output-delimiter='', el cual permite reemplazar el delimitador por lo que desee el usuario.
En este caso, por facilidad se reemplazó con un espacio vacío.

Para ordenar la lista de usuarios por su shell hay que tener en cuenta el campo 2.

![UsersAndShells](/home/lubuntu/Downloads/4_2.png)

Sort tiene una opción (-k) que permite elegir bajo qué columna se debe ordenar.
Usando ello se obtiene la lista final de usuarios ordenada por su tipo de shell.

## Punto 5
cksum da como output un número para un archivo basado en su contenido y en su peso.
El script propuesto permite encontrar imágenes exactamente iguales.
El script busca a través de todos los archivos de imagen presentes en una carpeta.

'''
# Encuentra todas las imagenes presentes en la maquina, y guarda las rutas y el$
find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' > imgs.txt

# Se queda unicamente con las rutas de las imagenes
images=$(cut imgs.txt -d' ' -f1)

# Recorre todas las rutas de las imagenes.

# La idea es que se pare en una imagen y compare con las otras (doble recorrido).
# Si el checksum de las dos es igual, que guarde la ruta de la comparada y lo guarde en un txt.
# Al final se tendrian tantos txt como imagenes repetidas.

for im in ${images[*]}
do
   # check if the output from identify contains the word "gray"
   identify $im | grep -q -i gray
   
   # $? gives the exit code of the last command, in this case grep, it will be zero if a match was found
   if [ $? -eq 0 ]
   then
      echo $im is gray
   else
      echo $im is color
      cp $im color_images
   fi
done
'''

