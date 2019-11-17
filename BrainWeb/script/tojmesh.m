ROILabels=table({'Scalp','Skull','CSF','WM','GM'}',(1:5)','VariableNames',{'ROI','Label'});

for i=1:54
	fn=sprintf('Brainweb_Subject%02d.mat',i);
	if(exist(fn,'file'))
		obj=load(fn);
		mesh=struct('x0x5F_DataInfo_',struct('BrainAtlasName',...
                   'BrainWeb','BrainAtlasURL','https://brainweb.bic.mni.mcgill.ca/brainweb/','BrainAtlasID',sprintf('Subject%02d',i),...
                   'BrainROILabels',ROILabels,'Author','Fang Lab (http://fanglab.org)',...
                   'Date',datestr(now,29),'MeshGenerator','Brain2Mesh','DataFormat',...
                   'JSON/JMesh (Draft 1) http://openjdata.org','MeshVersion',1,'Citation',...
                   'Tran AP, Yan S, Fang Q*, (2019) "Improving model-based fNIRS analysis using mesh-based anatomical and light-transport models," Neurophotonics (in press)'));
		mesh.MeshVertex3=obj.node;
		mesh.MeshElem=obj.elem;
                disp(i);
		tic;savejson('',mesh,'filename',sprintf('../BrainWeb_Subject%02d.jmsh',i),'compression','zlib');toc
	end
end