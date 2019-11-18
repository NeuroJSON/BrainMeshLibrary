# Brain Mesh Library - High-quality 3D tetrahedral mesh models for human brain atlases

* Authors: Anh Phong Tran <tran.anh at husky.neu.edu> and Qianqian Fang <q.fang at neu.edu>
  * Computational Optics and Translational Imaging (COTI) Lab, http://fanglab.org
  * Northeastern University
  * 360 Huntington Ave, Boston, MA 02115
* Version: 0.5
* License: CC-BY-SA (Creative Commons-Attribution-ShareAlike 4.0)
* URL: http://mcx.space/brain2mesh
* Project website: http://openjdata.org

## Introduction 

This library is described in the following paper pre-print:

* Anh Phong Tran and Qianqian Fang, "Fast and high-quality 
  tetrahedral mesh generation from neuroanatomical scans,". 
  In: arXiv pre-print (August 2017). arXiv:1708.08954v1 [physics.med-ph] 
  URL: https://arxiv.org/abs/1708.08954

## How to download

To download the latest version of the entire brain mesh library, you 
may use the below link

https://github.com/OpenJData/BrainMeshLibrary/archive/master.zip

or use the below git command
```
    git clone https://github.com/OpenJData/BrainMeshLibrary.git
```

To download the latest release (stable version), please browse

https://github.com/OpenJData/BrainMeshLibrary/releases

If you only need to download a particular brain mesh model, you 
may browse https://github.com/OpenJData/BrainMeshLibrary
and select the mesh file (.jmsh) and click on the "Download" button.

## How to use

The mesh data in this mesh library are stored in the JSON/JMesh 
format. The JMesh data format is a JSON-compatible data annotation 
open-standard defined in the JMesh Specification 
(http://github.com/fangq/jmesh).

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
        MeshVertex3: [256537x3 single]
           MeshElem: [1567340x5 uint32]
```
where the `/path/to/filename.jmsh` should be replaced by the 
relative or full path to the .jmsh file from the library.

The loaded mesh contains a metadata record (`x0x5F_DataInfo_` 
in MATLAB and `_DataInfo_` in Octave), storing the mesh
information such as version and atlas name etc.

The `data.MeshVertex3` is an `N x 3` matrix storing the 
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
    plotmesh(data.MeshVertex3, data.MeshElem);
```
or
```
    plotmesh(data.MeshVertex3, data.MeshElem,'x>100');
```
to plot a cross-section of the mesh.

To plot a particular tissue segment, one can use the 
5th column in the MeshElem array, for example, to plot the
white-matter (WM) segment, one can use

```
    plotmesh(data.MeshVertex3, data.MeshElem(data.MeshElem(:,5)==5,:),'x>100');
```

## Acknowledgement 

This project is funded by the National Institutes of Health (NIH) / 
National Institute of General Medical Sciences (NIGMS) grant# 
R01-GM114365 (PI: Fang), Natonal Cancer Institute (NCI) grant# 
R01-CA204443 (PI: Fang), and National Institute of Neurological 
Disorders and Stroke (NINDS) grant# R01-EB026998 (PI: Fang).
