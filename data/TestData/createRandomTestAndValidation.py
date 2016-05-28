import json
import random


def imagecat(name):
	return name.split('_')[0]

imageCategories = {
	'n01613177' : 1,
	'n01923025' : 2,
	'n02278980' : 3,
	'n03767203' : 4,
	'n03877845' : 5,
	'n04515003' : 6,
	'n04583620' : 7,
	'n07897438' : 8,
	'n10247358' : 9,
	'n11669921' : 10
}

imageCategorized = {
	'n01613177' : [],
	'n01923025' : [],
	'n02278980' : [],
	'n03767203' : [],
	'n03877845' : [],
	'n04515003' : [],
	'n04583620' : [],
	'n07897438' : [],
	'n10247358' : [],
	'n11669921' : []
}

testset = {}
valiset = {
	'n01613177' : [],
	'n01923025' : [],
	'n02278980' : [],
	'n03767203' : [],
	'n03877845' : [],
	'n04515003' : [],
	'n04583620' : [],
	'n07897438' : [],
	'n10247358' : [],
	'n11669921' : []
}

f = open('imageList.txt')

for l in f:
	imageCategorized[imagecat(l)].append(l.strip())

for key in imageCategorized:
	testset[key] = random.sample(imageCategorized[key], 450)
	for k in imageCategorized[key]:
		if not k in testset[key]:
			valiset[key].append(k)

# print json.dumps(testset, indent = 4)
# print json.dumps(valiset, indent = 4)

test = open('testset.txt', 'w')
vali = open('valiset.txt', 'w')

testlist = []
valilist = []

for k in testset:
	for s in testset[k]:
		testlist.append(s)
		# test.write(s + '\n');
for k in valiset:
	for s in valiset[k]:
		valilist.append(s)
		# vali.write(s + '\n');
random.shuffle(testlist)
random.shuffle(valilist)

for s in testlist:
	test.write(s + '\n')
for s in valilist:
	vali.write(s + '\n')

test.close()
vali.close()