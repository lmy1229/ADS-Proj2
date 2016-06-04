import sys

filepath = sys.argv[1]

f = open(filepath)
label = f.readline().strip()

temp = filepath.split('.')
temp[0] = temp[0] + '_' + label
ofilepath = temp[0] + '.' + temp[1]

fo = open(ofilepath, 'w')
imagelistout = open(filepath.split('/')[0] + "/imageList.txt", 'w')

while True:
	s = f.readline()
	if len(s) == 0:
		break
	imagelistout.write(s)
	fo.write(f.readline())


f.close()
fo.close()
imagelistout.close()