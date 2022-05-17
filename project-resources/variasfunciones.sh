#!/bin/bash

#creamos una lista con las opciones del menú
opciones="Verificar Ensamblar Crear_GIF Salir"

#esta función verifica el directorio, las imágenes y su tamaño
function verificar {
  #se leerá por teclado la ruta de acceso al directorio de imágenes
	echo "Ingrese ruta de acceso a las imágenes"
	read directorio
  #verificamos si la ruta es un directorio con el comando -d
	if [[ -d $directorio ]]; then
		echo "La ruta existe y es: $directorio"
    #entramos a la ruta con el comando cd
		cd $directorio
		echo "Kbytes	Archivos.png"
    #esta línea facilita la impresión ordenada de las imagenes con sus tamaños
		f=$(ls -sh *.png)
		for i in f;
		do
			echo "$f"
		done
  #verificamos si la ruta es un archivo con el comando -f
	elif [[ -f $directorio ]]; then
		echo "Es una ruta...pero de un archivo"
	fi
}

#esta función es la de ensamblar las imágenes con apngasm
function ensamblar {
	echo "Hola! Ahora trabajaremos desde APNG Assembler (apngasm)"
  #toma el resultado del directorio en la función anterior y lo verifica de la misma forma
	if [[ -d $directorio ]]; then
		echo "La ruta es: $directorio"
    #entramos a la ruta con el comando cd
		cd $directorio
		echo "Archivos.png"
    #imprimimos en consola solo los nombres de archivos y lo pasamos a una variable f
		f=$(ls *.png)
    #este for nos permite imprimir una sola vez todo los archivos
		for ((i=0; i<1; i++));
		do
    #el echo $f, imprimirá los nombres de archivos en la ruta donde se muestran los archivos
			echo $f
		done
		echo "ingrese el nombre del archivo de salida"
		read file_name
		echo "ingrese el retraso o delay(ejm: se escribe 1 10 ,esto es 1/10 segundos = 0.1 segundos"
		read file_delay
		echo "ingrese cantidad de ciclos a animar (cuantas veces se repetirá el gif)"
		read file_frame
    #transformamos el .png a .apng
		apngasm -o $file_name.png $f $file_delay -l$file_frame
    #imprimimos la ruta donde estamos trabajando
		a=$(pwd)
    #creamos un directorio o verificamos si existe
		if [ -d "$a/PNG2GIF" ]; then
			echo "La carpeta PNG2GIF existe"
		else
			mkdir $a/PNG2GIF
			echo "se ha creado la ruta $a/PNG2GIF"
		fi
    #movemos el archivo dentro del nuevo directorio creado
		mv $file_name.png $a/PNG2GIF
	elif [[ -f $directorio ]]; then
		echo "Es una ruta...pero de un archivo"
	fi
}
#función para crear un gif desde el .png creado con apng
function crear_GIF {
	echo "Hola! Ahora trabajaremos un gif (apng2gif)"
  #toma el resultado del directorio en la función anterior y lo verifica de la misma forma
	if [[ -d $directorio ]]; then
    #entramos a la ruta con el comando cd
		cd $directorio
    #vemos en que rutas estamos trabajando actualmente
		b=$(pwd)
    #creamos un directorio o verificamos si existe
		if [ -d "$b/PNG2GIF" ]; then
			echo "La carpeta PNG2GIF existe"
		else
			mkdir $b/PNG2GIF
			echo "se ha creado la ruta $b/PNG2GIF"
		fi

		c="$b/PNG2GIF"
		echo "Ruta en la que estamos $c"
    #entramos a la nueva ruta
		cd $c
    #imprimimos los archivos dentro de esta ruta
		echo "Archivos.png"
		f=$(ls *.png)
		for ((i=0; i<1; i++));
		do
			echo "$f"
		done
    #ingresamos los datos
		echo "Seleccione de la lista el archivo a trabajar y escribalo en el siguiente campo"
		echo "ingrese el nombre del archivo de entrada (sin el formato .png)"
		read file_in_name
		echo "ingrese el nombre del archivo de salida (sin formato)"
		read file_out_name
    #creamos el gif a partir del .png hecho en con el apng
		apng2gif $file_in_name.png $file_out_name.gif
    #movemos el archivo dentro del nuevo directorio creado
		mv $file_out_name.gif $c
	elif [[ -f $directorio ]]; then
		echo "Es una ruta...pero de un archivo"
	fi
}

#Desde aquí empieza el menú
echo "¡Bienvenido a Manejo de Archivos en BASH!"
echo "Ahora, selecciona una opción de nuestro menu"
#invocamos la lista y la pasamos como opciones dentro de un select
select opcion in $opciones;
do
	if [ $opcion = "Verificar" ]; then
		verificar
	elif [ $opcion = "Ensamblar" ]; then
		ensamblar 
	elif [ $opcion = "Crear_GIF" ]; then
		crear_GIF
	elif [ $opcion = "Salir" ]; then
		echo "Bye!"
		exit
	else
		echo "Opcion no válida!"
	fi
done