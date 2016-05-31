import numpy as np
import network
from CreateRandomData import imagecatIndex


def loadFeatureData(path):
	d = np.loadtxt(path, delimiter = ' ')
	return np.transpose(d)
	# return d

def vectorized_result(j):
	e = np.zeros((10, 1))
	e[j] = 1.0
	return e

def loadimageLabelData(path):
	f = open(path);
	labels = []
	for l in f:
		labels.append(imagecatIndex(l))
	d = np.zeros((10, len(labels)))
	for index, label in enumerate(labels):
		d[label, index] = 1.0
	return d

def loadImagetagData(path):
	tags = np.loadtxt(path, delimiter = ' ')
	return np.transpose(tags)

def loadData():
	# train = zip(loadFeatureData('trainf.txt'), loadLabelData('trainset.txt'))
	# vali = zip(loadFeatureData('valif.txt'), loadLabelData('valiset.txt'))

	# trainf = loadFeatureData('trainf.txt')
	# traint = loadimageLabelData('trainset.txt')
	# tf = [np.reshape(trainf[0:512, x], (512, 1)) for x in range(trainf.shape[1])]
	# tt = [np.reshape(traint[0:10, x], (10, 1)) for x in range(traint.shape[1])]
	# t = zip(tf, tt)

	# valif = loadFeatureData('valif.txt')
	# valit = loadimageLabelData('valiset.txt')
	# vf = [np.reshape(valif[0:512, x], (512, 1)) for x in range(valif.shape[1])]
	# vt = [np.reshape(valit[0:10, x], (10, 1)) for x in range(valit.shape[1])]
	# v = zip(vf, vt)

	trainf = loadFeatureData('gist/Train_x.txt')
	traint = loadImagetagData('gist/Train_y_new.txt')
	tf = [np.reshape(trainf[0:256, x], (256, 1)) for x in range(trainf.shape[1])]
	tt = [np.reshape(traint[0:10, x], (10, 1)) for x in range(traint.shape[1])]
	t = zip(tf, traint)

	valif = loadFeatureData('gist/val_x.txt')
	valit = loadImagetagData('gist/val_y_new.txt')
	vf = [np.reshape(valif[0:256, x], (256, 1)) for x in range(valif.shape[1])]
	vt = [np.reshape(valit[0:10, x], (10, 1)) for x in range(valit.shape[1])]
	v = zip(vf, valit)

	return (t, v)

def runNetwork():
	net = network.Network([512, 100, 10])
	train, vali = loadData()
	net.SGD(train, 100, 30, 0.001, vali)

runNetwork()