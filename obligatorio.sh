#!/bin/bash
#Santiago Clavere num:329571 , Agustin Obispo num:288482
echo "ingrese usuario"
read usuario
echo "ingrese su contraseña"
read contrasenia

menuinicial() { #8
echo  "1- listar usuarios registrados"
echo  "2- Dar de alta un usuario"
echo  "3- configurar letra de inicio"
echo  "4- configurar letra de fin"
echo  "5- configurar letra contenida"
echo  "6- consultar diccionario"
echo  "7- ingresar vocal"
echo  "8- listar palabras del diccionario solo con esa vocal"
echo  "9- Algoritmo 1"
echo  "10- Algoritmo 2"
echo  "11- Salir"
}
seguir=true
listarusuarios() { #22
cut -d' ' -f1 cuentas.txt #agarra la primera palabra de cada linea de cuentas.txt
}

archivo="/home/alumno/Escritorio/cuentas.txt"
 
daraltausuario() { #28
echo "ingrese nuevo usuario"
read nusu
if grep -q "$nusu" "$archivo"; then
echo ese usuario ya existe
echo indique otro nombre de usuario
daraltausuario
else
echo "ingrese contraseña"
read nucont
echo "$nusu $nucont" >> "$archivo"
fi
}

letraini() { #42
echo "ingrese letra con la que quiere que inicie"
read  letra1
}

letrafin() { #47
echo "ingrese letra con la que quiere que termine"
read  letra2
}

letracont() { #52
echo "ingrese que quiere que contenga"
read  letra3
}

diccionario='/home/alumno/Escritorio/diccionario.txt'
resultado='/home/alumno/Escritorio/palabras.txt'

funcion6() { #60

}

algoritmo2() { #71
echo "ingrese palabra"
read pala
palam="${pala^^}"
capi=""
largo=${#palam} #es el largo de la palabra
for (( i=largo-1; i>=0; i-- ))
do
capi+="${palam:$i:1}" #un charAt(i)
done
if [ "$capi" == "$palam" ]; then
echo "$pala es capicua"
else
echo "$pala no es capicua"
fi
}


vocal(){
echo "Ingrese una vocal"
read VOCAL
 if [[ ! "$VOCAL" =~ ^[aeiouAEIOU]$ ]]; then #verifica que la letra sea una vocal y si no lo es alerta al usuario
        echo "No ingreso una vocal"
        VOCAL=""
    fi
}


algoritmo1() {
    echo "¿Cuántos datos desea ingresar?"
    read cantidadDatos
    
    suma=0
    min=0
    max=0

    for (( i=1; i<=cantidadDatos; i++ )); do
        echo "Ingrese el dato $i:"
        read dato

        if [[ $i -eq 1 ]]; then #-eq se usa para comparar si dos numeros son iguales
            min=$dato
            max=$dato
        else
            if [[ $dato -lt $min ]]; then #-lt se utiliza para ver si un numero es mayor que otro
                min=$dato
            fi
            if [[ $dato -gt $max ]]; then #-gt se utiliza para ver si un numero es mayo que otro
                max=$dato
            fi
        fi

        suma=$((suma + dato))
    done
    

    promedio=$(echo "scale=2; $suma / $cantidadDatos" | bc)
    echo "Promedio: $promedio"
    echo "Menor dato: $min"
    echo "Mayor dato: $max"
}



 listarpalabrasvocal() {
    if [[ -z "$VOCAL" ]]; then #-z verifica si la cadena esta vacia
        echo "Debe configurar la vocal"
        return
    fi
    
    palabras=$(grep -i "^[^aeiou]*$VOCAL[^aeiou]*$" "$diccionario") #-i se usa para que no se distinga entre mayusculas y minusculas
    echo "Palabras que contienen únicamente la vocal $VOCAL:"
    echo "$palabras"
}







if grep -q "^$usuario $contrasenia$" "$archivo"; then #el -q significa que no se manda por consola pero si le indica a>
while $seguir; do
menuinicial
echo "ingrese opcion"
read opcion
case $opcion in
1) listarusuarios ;;
2) daraltausuario ;;
3) letraini ;;
4) letrafin ;;
5) letracont ;;
6) funcion6 ;;
7) vocal ;;
8) listarpalabrasvocal ;;
9) algoritmo1 ;;
10) algoritmo2 ;;
11) seguir=false ;;
*) echo "esa opcion no esta disponible por favor ingrese otra"
esac
done
else
echo "usuario o contraseña incorrecto"
fi

