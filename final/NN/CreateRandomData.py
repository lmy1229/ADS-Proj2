import json
import random

def imagecat(name):
	return name.split('_')[0]

def imagecatIndex(name):
	return imageCategories[imagecat(name)] - 1

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

trainset = {}
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
''' load image feature '''
imagefeature = []
features = open('Feature/gist_512.txt')
for feature in features:
	imagefeature.append(feature.strip())

''' load image names ''' 
imageindex = {}

f = open('Feature/imageList.txt')


temp = 0
for l in f:
	imageCategorized[imagecat(l)].append(l.strip())
	imageindex[l.strip()] = temp
	temp = temp + 1

for key in imageCategorized:
	trainset[key] = random.sample(imageCategorized[key], 450)
	for k in imageCategorized[key]:
		if not k in trainset[key]:
			valiset[key].append(k)

# print json.dumps(trainset, indent = 4)
# print json.dumps(valiset, indent = 4)

train = open('Dataset/trainName.txt', 'w')
vali = open('Dataset/valiName.txt', 'w')

trainlist = []
valilist = []

for k in trainset:
	for s in trainset[k]:
		trainlist.append(s)
		# train.write(s + '\n');
for k in valiset:
	for s in valiset[k]:
		valilist.append(s)
		# vali.write(s + '\n');
random.shuffle(trainlist)
random.shuffle(valilist)

for s in trainlist:
	train.write(s + '\n')
for s in valilist:
	vali.write(s + '\n')

train.close()
vali.close()


''' write trainset and valiset features '''
trainf = open('Dataset/trainFeature.txt', 'w')
valif = open('Dataset/valiFeature.txt', 'w')

for s in trainlist:
	trainf.write(imagefeature[imageindex[s]] + '\n')
for s in valilist:
	valif.write(imagefeature[imageindex[s]] + '\n')

trainf.close()
valif.close()
