import json
import pathlib
import os
DIR = pathlib.Path(__file__).parent.resolve()
TEMPLATE_DIR = os.path.join(DIR,"template")

f=open(os.path.join(DIR,"config.json"))
config = json.loads(f.read())
f.close()

for each in os.listdir(TEMPLATE_DIR):
    if each.endswith(".template") == False:
        continue
    f = open(os.path.join(TEMPLATE_DIR,each),"r")
    data = f.read()
    f.close()
    for k in config.keys():
        current_key = "$"+k+"$"
        data = data.replace(current_key, config[k])
    f = open(os.path.join(DIR,"out",each.split(".template")[0]),"w")
    f.write(data)
    f.close()