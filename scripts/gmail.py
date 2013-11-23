#!/usr/bin/python
import os
import time

#Enter your username and password below within double quotes
# eg. username="username" and password="password"

def verificar_correo():
    """@todo: Docstring for verificar_correo.
    :returns: @todo

    """
    username = "user"
    password = "password"
    com = "wget -q -O - https://" + username + ":" + password + "@mail.google.com/mail/feed/atom --no-check-certificate"

    temp = os.popen(com)
    msg = temp.read()
    index = msg.find("<fullcount>")
    index2 = msg.find("</fullcount>")
    print( msg[index + 11:index2] )
    return msg[index + 11:index2]

def escribir_correo():
    """@todo: Docstring for escribir_correo.
    :returns: @todo

    """
    correos = str(verificar_correo())
    archivo = open(os.environ.get('HOME') + '/.correo_sin_leer', 'w')
    archivo.write(correos)
    archivo.close();

while(True):
    escribir_correo()
    time.sleep(10)
