#!/bin/bash

PORT=2021

echo "(0) Server ABFP"

echo "(1) Listening $PORT"

MESSAGE=`nc -l -p $PORT`

echo "TEST! $MESSAGE"

PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "TEST HEADER"
if [ "$PREFIX" != "ABFP" ]; then

 echo "Error en la cabezera"
	
 sleep 1
 echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT
	
 exit 1
fi

echo "(4) RESPONSE HEADER"

echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT

echo "(5) LISTEN HANDSHAKE"

HANDCSHAKE=nc -l -p $PORT

echo "TEST HANDSHAKE"
if [ "$HANDSHAKE" != "THIS_IS_MY_CLASSROOM" ]; then
 echo "Error en el Handshake"
 
 sleep 1
 echo "KO_HANDSHAKE" | nc $IP_CLIENT $PORT
 
 exit 1
fi

echo "(8) RESPONSE HANDSHAKE"

sleep 1
echo "YES_IT_IS" | nc -q l $IP_CLIENT $PORT

echo "(9) LISTEN FILE_NAME"

FILE_NAME=`nc -l -p $PORT`

PREFIX=`echo $FILE_NAME | cut -d " " -f 1`
NAME=`echo $FILE_NAME | CUT -d " " -f 2`

echo "TEST FILE_NAME"

if [ "$PREFIX" != "FILE_NAME" ]; then
 
 echo "Error en el nombre de archivo"

 sleep 1
 echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

 exit 3

fi

echo "(12) RESPONSE FILE_NAME ($NAME)"

sleep 1
echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

echo "(13) LISTEN DATA"

nc -l -p $PORT > archivo_entrada.vaca

exit 0
