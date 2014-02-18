#! /usr/bin/bash

colorDefault='\e[m'
colorServicio='\e[0;36m'

typeset -a servicios
servicios=(postgresql mysqld httpd php-fpm mpd wicd NetworkManager smbd nmbd)

estado_servicio(){
    estado=`systemctl status $1 | grep Active:`
    index=`expr "$estado" : '.*Active: '`
    longitud=$[`expr "$estado" : '.*Active:.*tive'` - $index]
    estado=${estado:$index:$longitud}
    if [ $estado = "active" ]
    then
        color='\e[0;32m'
        return 1
    else
        color='\e[0;31m'
        return 0
    fi
}

accion_servicio(){
    estado_servicio ${servicios[$1]}
    echo ''
    echo '---------------------------------------'
    echo -e $colorServicio ${servicios[$1]} $color '['$estado']' $colorDefault
    echo '---------------------------------------'
    echo '1. Iniciar    2. Parar    3. Reiniciar    4. Cancelar'
    echo 'opcion: '
    read op
    if (( op == 1 ))
    then
        `sudo systemctl start ${servicios[$1]}`
    elif (( op == 2 ))
    then
        `sudo systemctl stop ${servicios[$1]}`
    elif (( op == 3 ))
    then
        `sudo systemctl restart ${servicios[$1]}`
    elif (( op == 4 ))
    then
        echo 'accion cancelada.'
    else
        echo -e '\e[0;31m Error: Opcion invalida.\e[m'
        accion_servicio $1
        return 0
    fi
    echo ''
    menu
    return 0
}

menu(){
    i=1
    echo ''
    echo 'Administracion de Servicios'

    for s in ${servicios[*]}
    do
        estado_servicio $s
        echo -e '  '$i'.'$color $s $colorDefault
        i=$[i + 1]
    done
    echo -e '  '$i'. \e[1;31mSalir\e[m'

    echo 'Opcion: '
    read opcion
    while (( !opcion || opcion <= 0 || opcion > i ))
    do
        echo -e '\e[0;31m Error: Opcion invalida.\e[m'
        echo 'Opcion: '
        read opcion
    done

    if [ $opcion -ne $i ]
    then
        accion_servicio $[opcion - 1]
    else
        echo 'Adios. Hasta la proxima.'
    fi
}

servicios_ruta(){
    if [ -z $1 ]
    then
        ruta='/usr/lib/systemd/system'
    else
        ruta=$1
    fi
    j=0
    list=`ls $ruta | grep .service`
    servicios=()
    for x in $list
    do
        servicios[$j]=$x
        j=$[j + 1]
    done
}

main(){
    if [ -z $1 ]; then
        menu
    elif [ $1 = '-r' ]; then
        servicios_ruta $2
        menu
    else
        echo 'Uso: servicios [-r [path]]'
    fi
}

main $1 $2
