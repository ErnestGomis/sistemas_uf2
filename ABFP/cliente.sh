#!/bin/bash

PORT=2021

IP_CLIENTE= "127.0.0.1"
IP_SERVIDOR="127.0.0.1"

FILE_NAME="archivo_salida.vaca"

echo "Cliente de ABFP"

echo "(2) SENDING HEADERS"

echo "ABFP $IP_CLIENTE" | nc -q 1 $IP_SERVIDOR $POR

echo "(3) LISTEN CONNECTION RESPONSE"

RESPONSE=`nc -l -p $PORT`

echo "TEST CONNECTION"
if [ "$RESPONSE" != "OK_CONN" ]; then
 echo "No se ha podido conectar con el servidor"
 exit 1
fi

echo "(6) SENDING HANDSHAKE"

sleep 1
echo "THIS_IS_MY_CLASSROOM" | nc -q 1 $IP_SERVER $PORT


echo "(7) LISTEN HANDSHAKE RESPONSE"

RESPONSE=`nc -l -p $PORT`

echo "TEST HANDSHAKE RESPONSE"
if [ "$RESPONSE" != "YES_IT_IS" ]; then
 echo "ERROR: No se ha recibido correctamente el Handshake"

 exit 2
fi

FILE_NAME="vaca_salida.txt"

FILE_MD5="`echo $FILE_NAME | md5sum | cut -d " " -f 1`"

echo "(10) SENDING FILE_NAME"

sleep 1
echo "FILE_NAME $FILE_NAME" | nc -q l $IP_SERVER $PORT

echo "(11) LISTEN FILE_NAME RESPONSE"
RESPONSE=`nc -l -p $PORT`

echo "TEST FILE_NAME RESPONSE"

if [ "$RESPONSE" != "OK_FILE_NAME" ]; then
 echo "Error al enviar el nombre del achrivo"

 exit 3
fi

sleep 1
cat $FILE_NAME | nc -q 1 $IP_SERVER $PORT

echo "(14) SENNDING DATA"

sleep 1
cat $FILE_NAME | nc -q 1 $IP_SERVER $PORT

exit 0
