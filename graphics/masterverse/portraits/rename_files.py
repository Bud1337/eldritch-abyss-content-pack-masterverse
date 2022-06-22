import os

path = '/home/manuel/PhpstormProjects/Stellaris/eldritch-abyss/src/gfx/models/portraits/vanilla/human_vanilla_male_hair_update'

for filename in os.listdir(path):
    if (filename.find("v1") != -1):
        newFilename = filename.replace("v1","vanilla")
        print(path + "/" + newFilename)
        os.rename(path + "/" + filename, path + "/" + newFilename)

