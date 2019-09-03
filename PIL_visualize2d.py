#-*-coding:utf-8;-*-

"""
A simple script to visualize the values of a function(x,y).

Input: save_path, xfrom, xto, xlen, yfrom, yto, ylen, func.

Newest version: grayscale, faster.
"""

import numpy as np
from PIL import Image
import math

### input ###

save_path = r"C:\Users\User\Desktop\visualize.png"

xfrom, xto, xlen = 2, 3, 1000
yfrom, yto, ylen = 2, 3, 1000

def func(x, y):
    return y/x # 1000000/x + 1000000/y # x*y # x*x+y*300 # (x+y) % 2 # for fun

def func_par(x, y):
    """
    Parallel resistance of x and y.
    """
    if (x+y)==0: return 0
    return x*y/(x+y)

### input ###


def normalizer(minval, maxval):
    def normalize(val):
        return int((val-minval)/(maxval-minval)*5)*51 ## 255 = 3*5*17
    return normalize

print("Generate x,y...")
y, x = np.mgrid[yto:yfrom:complex(0,ylen), xfrom:xto:complex(0,xlen)].reshape(2,-1) ## y reversed, x change first
## from https://stackoverflow.com/questions/32208359/is-there-a-multi-dimensional-version-of-arange-linspace-in-numpy
# print("y:",y) # debug
# print("x:",x) # debug
print("Compute...")
z = tuple(map(func, x, y))
# z = tuple(map(math.log, z))
# print("z:", min(z), max(z)) # debug
print("Normalize to grayscale...")
rgb = tuple(map(normalizer(min(z), max(z)), z))
# print(min(rgb), max(rgb))

print("Save image...")
img = Image.new("L", (xlen, ylen)) ## https://pillow.readthedocs.io/en/3.1.x/handbook/concepts.html#concept-modes
img.putdata(rgb)
img.save(save_path)
print("Done.")
