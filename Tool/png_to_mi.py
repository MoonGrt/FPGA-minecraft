import numpy as np
import cv2

def color_to_hex(color):
    return '{:02x}{:02x}{:02x}'.format(color[2], color[1], color[0])

f = open('textures.mi', mode='w')
print('#File_format=Hex\n#Address_depth=256\n#Data_width=24', file=f)

img = cv2.imread('./{}.png'.format('18'), cv2.IMREAD_UNCHANGED)
# cv2.imshow('img', np.repeat(np.repeat(img, 10, axis=0), 10, axis=1))
# cv2.waitKey(0)  # 等待按键
for j in range(16):
    for k in range(16):
        print(color_to_hex(img[j, k, 0:3]), end='\n', file=f)
    # print('', file=f)
print('', file=f)
