import os
import random
import sys
home = os.path.expanduser("~")
mypath = os.path.join(home,"Applications/Wallpapers/")
onlyfiles = [os.path.join(mypath,f) for f in os.listdir(mypath) if f.endswith(('.jpg','.png'))]
sys.stdout.write(random.choice(onlyfiles) +'\n')
