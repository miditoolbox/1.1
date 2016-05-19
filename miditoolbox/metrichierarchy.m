function mh = metrichierarchy(nmat)
% Location of notes in metric hierarchy
% mh = metrichierarchy(nmat);
% Returns a vector indicating the location of each note of NMAT
% in metric hierarchy. The meter of NMAT is estimated using the
% function METER
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	MH = vector indicating the location of each note in metric
%		hierarchy; encoding:
% 		strong beat = 5, weak beat = 4, etc.
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

ob = onsetmodmeter(nmat);
mh = (abs(ob)<1e-6);
mh = mh + (abs(ob-round(ob))<1e-6);
for k=1:3
	ob=ob*2;
	mh = mh + (abs(ob-round(ob))<1e-6);

end
mh=mh';
