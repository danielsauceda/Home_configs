import os
import random
import sys
home = os.path.expanduser("~")
mypath = os.path.join(home,"Applications/Wallpapers/")
file_list = []
for root, dirs, files in os.walk(mypath):
    for file in files:
            if file.endswith(('.jpg','.png')):
                file_list.append(os.path.join(root, file))

sys.stdout.write(random.choice(file_list) +'\n')
