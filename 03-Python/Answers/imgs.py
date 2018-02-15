# Importa paquetes necesarios.

import os
import urllib.request
import tarfile
import random
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import scipy.io
import time


start = time.time()

# Descarga el archivo y lo descomprime si es la primera vez que se corre.

actual = os.path.dirname(os.path.abspath(__file__))
info = os.listdir(actual)

# Verifica si el archivo ya esta descargado.
down = 1
for x in info:
    comp = x.find('BSR')
    down = comp*down
    if down == 0:
        break

# Si no esta descargado, lo descarga.
if down != 0:
    actual = actual + '\BSR_bsds500.tgz'

    url = 'http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz'
    urllib.request.urlretrieve(url, actual)

    tar = tarfile.open(actual, 'r')
    tar.extractall()
    tar.close()



# Genera el numero aleatorio de imagenes que se van a ver.
idImgs = random.randint(0, 196)


# Muestra las imagenes aleatorias.
iTest = 'BSR/BSDS500/data/images/test/'
gTest = 'BSR/BSDS500/data/groundTruth/test/'
iContents = os.listdir(iTest)
gContents = os.listdir(gTest)

img1 = mpimg.imread(iTest + iContents[idImgs])
img2 = mpimg.imread(iTest + iContents[idImgs+1])
img3 = mpimg.imread(iTest + iContents[idImgs+2])
img4 = mpimg.imread(iTest + iContents[idImgs+3])

gr1 = scipy.io.loadmat(gTest + gContents[idImgs])
gr1 = (gr1['groundTruth'])[0,0]
s1 = gr1['Segmentation'][0,0]
b1 = gr1['Boundaries'][0,0]

gr2 = scipy.io.loadmat(gTest + gContents[idImgs+1])
gr2 = (gr2['groundTruth'])[0,0]
s2 = gr2['Segmentation'][0,0]
b2 = gr2['Boundaries'][0,0]

gr3 = scipy.io.loadmat(gTest + gContents[idImgs+2])
gr3 = (gr3['groundTruth'])[0,0]
s3 = gr3['Segmentation'][0,0]
b3 = gr3['Boundaries'][0,0]

gr4 = scipy.io.loadmat(gTest + gContents[idImgs+3])
gr4 = (gr4['groundTruth'])[0,0]
s4 = gr4['Segmentation'][0,0]
b4 = gr4['Boundaries'][0,0]

plt.figure(1)
plt.subplot(341)
plt.imshow(img1)
plt.subplot(342)
plt.imshow(img2)
plt.subplot(343)
plt.imshow(img3)
plt.subplot(344)
plt.imshow(img4)
plt.subplot(345)
plt.imshow(s1)
plt.subplot(346)
plt.imshow(s2)
plt.subplot(347)
plt.imshow(s3)
plt.subplot(348)
plt.imshow(s4)
plt.subplot(349)
plt.imshow(b1)
plt.subplot(3,4,10)
plt.imshow(b2)
plt.subplot(3,4,11)
plt.imshow(b3)
plt.subplot(3,4,12)
plt.imshow(b4)

print(time.time() - start, 'segundos')
plt.show()