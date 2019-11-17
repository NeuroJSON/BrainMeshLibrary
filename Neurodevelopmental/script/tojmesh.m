ROILabels=table({'WM','GM'}',[4,5]','VariableNames',{'ROI','Label'});

fnames=dir('*.mat');
for i=1:length(fnames)
	fn=fnames(i);
        obj=load(fn.name);
        obj.elem(obj.elem(:,end)<4,:)=[];
        [obj.node,obj.elem(:,1:4)]=removeisolatednode(obj.node,obj.elem(:,1:4));
        atlasid=regexprep(fn.name,'\.mat$','');
        mesh=struct('x0x5F_DataInfo_',struct('BrainAtlasName',...
           'Neurodevelopmental MRI Database', 'BrainAtlasURL','https://jerlab.sc.edu/projects/neurodevelopmental-mri-database','BrainAtlasID',atlasid,...
           'SegmentationDataVersion','Version 1',...
           'BrainROILabels',ROILabels,'Author','Fang Lab (http://fanglab.org)',...
           'Date',datestr(now,29),'MeshGenerator','Brain2Mesh','DataFormat','JSON/JMesh (Draft 1) http://openjdata.org','MeshVersion','0.5',...
           'Comment','No scalp, CSF and skull layers','Contact','q.fang<at>neu.edu','Citation',...
           'Tran AP, Yan S, Fang Q*, (2019) "Improving model-based fNIRS analysis using mesh-based anatomical and light-transport models," Neurophotonics (in press)'));
        mesh.MeshVertex3=obj.node;
        mesh.MeshElem=obj.elem;
        disp(i);
        tic;savejson('',mesh,'filename',sprintf('../NDD_%s.jmsh',atlasid),'compression','zlib');toc
end