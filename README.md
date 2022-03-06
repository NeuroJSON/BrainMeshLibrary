# Brain Mesh Library - High-quality 3D tetrahedral mesh models for human brain atlases

* Authors: Anh Phong Tran <tran.anh at husky.neu.edu> and Qianqian Fang <q.fang at neu.edu>
  * Computational Optics and Translational Imaging (COTI) Lab, http://fanglab.org
  * Northeastern University
  * 360 Huntington Ave, Boston, MA 02115
* Version: 0.6
* License: CC-BY-SA (Creative Commons-Attribution-ShareAlike 4.0)
* URL: http://mcx.space/brain2mesh
* Project website: http://neurojson.org

## What's New

The [NeuroJSON](http://neurojson.org) [JData](https://github.com/NeuroJSON/jdata)/[JMesh](https://github.com/NeuroJSON/jmesh) 
specifications are now officially funded by the National Institute of Health (NIH) and National Institute of Neurological
Disorders and Stroke (NINDS) under grant# [U24-NS124027](https://reporter.nih.gov/project-details/10308329).

Starting from V0.6, we include the originally excluded scalp, skull and CSF mesh layers for all Neurodevelopmental
MRI atlas meshes. The segmentations of the CSF and skull layers were created using SPM12. For atlases of younger
populations, the SPM segmentations may not be accurate as they were computed based on an adult head template. The scalp
surfaces were extracted from the T1 MRI image using a threshold-based method. Details regarding processing steps 
of these tissue types can be found in Section 3.3 and Fig. 9 of [our paper](http://dx.doi.org/10.1117/1.NPh.7.1.015008).

Please be cautious when using meshes of these tissue layers, especially in the younger populations, in your analyses.
Although they were generated using the best tools that are currently available, understanding their known limitations
helps to avoid inaccurate conclusions derived from this mesh data library.


## Introduction 

This library is described in the following paper:

* Anh Phong Tran†, Shijie Yan†, Qianqian Fang*, (2020) "Improving model-based fNIRS analysis using mesh-based anatomical and light-transport models," Neurophotonics,  7(1), 015008, URL: http://dx.doi.org/10.1117/1.NPh.7.1.015008

## How to download

To download the latest version of the entire brain mesh library, you 
may use the below link

https://github.com/NeuroJSON/BrainMeshLibrary/archive/master.zip

or use the below git command
```
    git clone https://github.com/NeuroJSON/BrainMeshLibrary.git
```

To download the latest release (stable version), please browse

https://github.com/NeuroJSON/BrainMeshLibrary/releases

If you only need to download a particular brain mesh model, you 
may browse https://github.com/NeuroJSON/BrainMeshLibrary
and select the mesh file (.jmsh) and click on the "Download" button.

## How to use

The mesh data in this mesh library are stored in the JSON/JMesh 
format. The JMesh data format is a JSON-compatible data annotation 
open-standard defined in the JMesh Specification 
(http://github.com/NeuroJSON/jmesh).

The data files in this library are essentially JSON files. One
can open these files using any JSON parser, widely avaialble 
for many programming languages. The data in these JSON files
are zlib-compressed and base64-encoded. We have developed 
several open-source JMesh/JData decoders to load these data 
files conveniently.

To load the mesh files in MATLAB/GNU Octave, one need to install
the JSONLab and ZMat toolboxes, from the below URLs:

* JSONLab: https://github.com/fangq/jsonlab/releases/latest
* ZMat: https://github.com/fangq/zmat/releases/latest

Once the toolboxes are downloaded and uncompressed, one need
to run `addpath` in MATLAB to add the path to the toolboxes, 
then, the data files can be loaded by
```
>> data=loadjson('/path/to/filename.jmsh')

data = 

    x0x5F_DataInfo_: [1x1 struct]
           MeshNode: [256537x3 single]
           MeshElem: [1567340x5 uint32]
```
where the `/path/to/filename.jmsh` should be replaced by the 
relative or full path to the .jmsh file from the library.

The loaded mesh contains a metadata record (`x0x5F_DataInfo_` 
in MATLAB and `_DataInfo_` in Octave), storing the mesh
information such as version and atlas name etc.

The `data.MeshNode` is an `N x 3` matrix storing the 
x/y/z coordinates of all the nodes in the mesh, and 
`data.MeshElem` stores a 5-column integer array, with the 
first 4 columns denoting the indices of the tetrahedral
elements and the last column denoting the region label.
The meanings of the labels are defined in the table 
stored as `data.x0x5F_DataInfo_.ROIBrainROILabels`.

To plot or process the loaded mesh, one need to install 
the Iso2Mesh toolbox from

* Iso2Mesh: https://github.com/fangq/iso2mesh/

Similarly, after installing the toolbox, one need to run
```
    plotmesh(data.MeshNode, data.MeshElem);
```
or
```
    plotmesh(data.MeshNode, data.MeshElem,'x>100');
```
to plot a cross-section of the mesh.

To plot a particular tissue segment, one can use the 
5th column in the MeshElem array, for example, to plot the
white-matter (WM) segment, one can use

```
    plotmesh(data.MeshNode, data.MeshElem(data.MeshElem(:,5)==5,:),'x>100');
```

## Acknowledgement 

This project is funded by the National Institutes of Health (NIH) / National Institute 
of Neurological Disorders and Stroke (NINDS) grant# U24-NS124027 and R01-EB026998 (PI: Fang),
National Institute of General Medical Sciences (NIGMS) grant# R01-GM114365 (PI: Fang).
