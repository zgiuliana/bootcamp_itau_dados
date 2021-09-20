import numpy as np 
import matplotlib.pyplot as plt
from random import random
from scipy.spatial.distance import euclidean
from sklearn.datasets import make_blobs

# IMPLEMENTAÇÃO DO K-MEANS
# X_train = np.concatenate((np.random.randint(20, size=50).reshape(-1, 1), np.random.randint(20, size=50).reshape(-1, 1)), axis=1)

k = 3 # número de classes
m = 2 # número de parâmetros
maxit = 10
it = 1

X_train, _ =  make_blobs(n_samples = 100, n_features = m, cluster_std = 1., 
                              centers = k, random_state=42)

centroid = np.zeros((k, m))
colors = ['r', 'g', 'b', 'k']
symbols = ['^', '*', 's']

for i in range(k):
    centroid[i] = np.array([random() * np.max(X_train), random() * np.max(X_train)])

while True:
    data_clusters = []
    for i in range(k):
        data_clusters.append([])

    for i in range(len(X_train)):
        min_dist = 1000000
        ct = 0
        for c in range(len(centroid)):
            dist = euclidean(X_train[i], centroid[c])
            if (dist < min_dist):
                ct = c
                min_dist = dist
        data_clusters[ct].append([X_train[i, 0], X_train[i, 1]])

    data_clusters = np.array(data_clusters)

    # plotando centróides
    plt.cla()
    plt.clf()
    #plt.axis([0, np.max(X_train[0,:]), 0, np.max(X_train[1,:])])
    plt.text(0.2, 2.3, 'Interation: ' + str(it))

    for i in range(k):
        plt.plot(centroid[i,0], centroid[i,1], colors[i] + 'x', linewidth=10, markersize=10)
        try:
            plt.plot(np.array(data_clusters[i])[:,0], np.array(data_clusters[i])[:,1], colors[i] + symbols[i])
        except:
            pass
    plt.pause(2)

    meanx, meany = 0, 0

    centroid_ant = np.copy(centroid)

    for i in range(k):
        try:
            meanx = np.mean(np.array(data_clusters[i])[:,0])
            meany = np.mean(np.array(data_clusters[i])[:,1])
            centroid[i] = np.array([meanx, meany])
        except:
            centroid[i] = np.array([random() * np.max(X_train), random() * np.max(X_train)])

    # média do somatório da diferença das coordenadas dos centróides
    mean  = np.mean(np.abs(centroid_ant - centroid))
    if (mean < 1e-10):
        plt.show()
        break

    it += 1