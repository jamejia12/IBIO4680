# Importa paquetes necesarios.

import os
import urllib.request
import tarfile
import random
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import scipy.io
import time
import cv2


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

x = [0, 1, 2, 3]
plt.figure(1)
for i in x:
    img = mpimg.imread(iTest + iContents[idImgs +i])
    plt.subplot(3, 4, i+1)
    plt.imshow(img)
    plt.axis('off')

    gr = scipy.io.loadmat(gTest + gContents[idImgs +i])
    gr = (gr['groundTruth'])[0,0]
    s = gr['Segmentation'][0,0]
    b = gr['Boundaries'][0,0]

    plt.subplot(3, 4, i+5)
    plt.imshow(s)
    plt.axis('off')

    plt.subplot(3, 4, i+9)
    plt.imshow(b, cmap="Greys")
    plt.axis('off')


print(time.time() - start, 'segundos')
plt.show()
