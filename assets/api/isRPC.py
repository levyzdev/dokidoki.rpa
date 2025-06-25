from pypresence import Presence
import time
import sys

client_id = '1387137814872985701'

file_name = sys.argv[1] if len(sys.argv) > 1 else "Unknown"
file_extension = sys.argv[2] if len(sys.argv) > 2 else ""
act_identify = sys.argv[3] if len(sys.argv) > 3 else "E"
trueorfalse = sys.argv[4] if len(sys.argv) > 4 else "false"

act_type = ""
act_type2 = "Idling"

if trueorfalse == "true":
    if file_extension != "":
        file_extension = ".rpa" 

    if act_identify == "E":
        act_type = "Extracting: "
        act_type2 = "In Extractor"
    else:
        act_type = "Decompiling: "
        act_type2 = "In Decompiler"
else:
    if file_name == "Unknown":
        file_name = ""
        file_extension = ""

state = f"{act_type}{file_name}{file_extension}"
details = act_type2

state = (state[:125] + "...") if len(state) > 128 else state
details = (details[:125] + "...") if len(details) > 128 else details

RPC = Presence(client_id)
try:
    RPC.connect()
    RPC.update(state=state, details=details)
except Exception as e:
    print("Failed to connect to Discord RPC:", str(e))
    sys.exit(1)

while True:
    try:
        time.sleep(15)
    except KeyboardInterrupt:
        RPC.clear()
        RPC.close()
        break
