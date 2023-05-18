columns = []
labels = []
with open("/tmp/test.fps", "r") as file:
    NL = -1
    for line in [ line.strip() for line in file.readlines() ]:
        NL += 1
        NW = -1
        for word in [ word.strip() for word in line.split(',') ]:
            NW += 1
            if len(columns) == 0:
                columns = [ [] for x in line.split(',') ]
                labels = [ 'FPS' for x in columns ]
            if word.replace('.', '0').replace('-', '0').isdigit():
                columns[NW][NL] = float(word)
            elif NL == 0:
                labels[NW] = word
                NL -= 1
