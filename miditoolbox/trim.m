function nm2 = trim(nmat)
% Removal of leading silence
% nm2 = trim(nmat)
% Removes potential silence in the beginning of NMAT
% by shifting the note onsets so that the first onset occur at zero time
%
% Input arguments: 
%	NMAT = notematrix%
% Output: 
%	NM2 = shifted note matrix 
%
% Authors:
%  Date		Time	Prog	Note
% 5.2.2003	17:44	PT	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
nm2=nmat; nm2(:,1)=nm2(:,1)-nm2(1,1); nm2(:,6)=nm2(:,6)-nm2(1,6);