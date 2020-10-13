# Ear canal segmentation

The purpose of this project was to segment anatomical structures coming from CT scans.

### Contents

The used dataset contained a reference image along with 7 binary masks, one for each anatomical or artifical structure of interest. 

### Images

Input images (image.nii) are NIfTI images created from CT scans of the temporal bone of various cadaver heads during pre-clinical trials.

### Masks

Masks are binary images of the various anatomical structures we need to segment, cropped around the region of interest and aligned with the input image.

### Code

1. Task_Segmentation_1st_script.ipynb and Task_Segmentation_2nd_script.ipynb contain the python code for the exploration of the dataset, of various measurements, and the automatisation by template matching.

2. The matlab code contains code for segmenting the structure.

## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
