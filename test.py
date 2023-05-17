import subprocess as subproc
try:
    import matplotlib
    import numpy
except ImportError:
    subproc.run('python3 -m pip install matplotlib', shell=True, check=True)
    subproc.run('python3 -m pip install numpy', shell=True, check=True)
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import statistics as stat

    
values_list = []
with open("/tmp/test.fps") as file:
    lines = file.readlines()
    for j in range(0, len(lines)):
        words = lines[j].split(',')
        if not values_list:
            values_list = [[] for x in words]
            continue
        for i in range(0, len(words)):
            values_list[i].append(float(words[i]))
            
            