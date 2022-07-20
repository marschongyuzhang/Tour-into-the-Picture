# G14 Challenge: Tour into the picture

## Introduction

Stereo images are typically used for the 3D reconstruction of a scene. However, there are also methods that can generate different views from a single image. So we we make the challenge for Computer Vision (SS22) at Technical University Munich: Tour into the picture.

> **Lecturer**: Prof. Dr.-Ing. Klaus Diepold
>
> **Assistant**: Luca Sacchetto, Sven Gronauer
>
> **Team Member**:
>
> - Shenghan Gao <ge32can@tum.de>
> - Xuejiao Li <xuejiao.li@tum.de>
> - Zhiping Li <zhiping.li@tum.de>
> - Yunshan Ye <ys.ye@tum.de>
> - Chongyu Zhang <chongyu.zhang@tum.de>

The content of the lecture contains:

- GUI Development
- choose the foreground, background, one or two vanish point
- coordinate transformations
- multi-camera-view systems
- 3D reconstruction, planar epipolar equation
- 3D and 2D Demonstration 
- View under different perspectives

1. Have user input coordinates for the polygon of foreground, the backwall and the number of vanish point (one or two, later more in developing)
(Optional: If there are two or more vanish point, the user can choose one or two vanish point and get view, which they want to concentrate on)
2. Use a mask to extract each polygon from the original image.
3. Extract the 5 polygons that comprise of the walls, ceiling, and floor.
4. Calculate the information of the image in the world coordinate system
5. Interpolation through the pixel points and rebuild in a 3D Camera system. 
6. Warp each polygon back into a rectangle.
7. Define the geometry of the 3D box and the surfaces of the walls in 3D.
8. Generate 2D and 3D perspective images


---

## GUI User's Guide

> :computer: : should work both for **WINDOWS** **MAC** and **LINUX**
>
> :MATLAB Version: at least **MATLAB R2022a**

### **Achievement and Difference Highlight**
* 3D and 2D Animation with real time changed angle alpha(x) beta(y) and theta(z)
* 3D and 2D in one GUI
* Foreground extraction then revert to the generated image
* project the picture with one or even two vanish points

### **Quality features**
* If you want to save some times, you can use the zip_pooling.function to compress image memory.

## Getting Started
* To run the application, run 'gui.mlapp' in MATLAB 2022a.
* For a quick start, run 'main.m'.

## Launch the .m program
Follow the instructions in the command window and the results can be shown after execution.

## Launch the APP:
* Step 1 
Run the App and select one subfolder in the folder 'Datasets', e.g. xxx.png...

* Step 2
First make the polygon mask for the foreground by clicking the Foreground Button, choose the number of vanish point(s), select one background from the image by clicking the Rückwand Button and a vanish point by clicking the Fuchtpunkt Button.

* Step 3 
User can input suitable smaller rotation angle. after clicking the Radiation and the 3D plot or 2D plot the new image from the user's defined perspective.

* Step 4 
User can save the generated images or upload new images to have a tour into the new picture.

> We look forward to your suggestions！Thanks for your downloading and using. 