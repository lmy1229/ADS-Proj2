f = open('Train_y.txt')
o = open('Train_y_new.txt', 'w')
d = []

for l in f:
	a = ['0','0','0','0','0','0','0','0','0','0']
	a[int(l) - 1] = '1'
	d.append(a)

for i in d:
	o.write(' '.join(i) + '\n')
