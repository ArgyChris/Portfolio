# Ear canal segmentation

The purpose of this project was to segment anatomical structures coming from CT scans.

### Contents

The used dataset contained a reference image along with 7 binary masks, one for each anatomical or artifical structure of interest. 

### Images

Input images (image.nii) are NIfTI images created from CT scans of the temporal bone of various cadaver heads during pre-clinical trials.

### Masks

Masks are binary images of the various anatomical structures we need to segment, cropped around the region of interest and aligned with the input image.

### Code

<ol>
<li> Task_Segmentation_1st_script.ipynb and Task_Segmentation_2nd_script.ipynb contain the python code for the exploration of the dataset, of various measurements, and the automatisation by template matching. </li>

<li>
The matlab folder contains:
<ul>
    <li> The subfolder Tensor_Voting (Tensor_Voting_Segmentation.m) for the initial segmentation of the structure using the tensor voting approach. </li>
    <li> The subfolder Active_Surfaces (running_Active_Surfaces.m) for refinement of the segmentation using the active surfaces approach. </li>
    <li> The subfolder Measurements for the comparison of the segmentation against the mask, and various measurments. </li>
</ul>
</li>
</ol>

## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
