function a = ambitus(nmat)
% Melodic range in semitones
% function a = ambitus(nmat)
% Returns the melodic rage (ambitus) in semitones of NMAT 
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	A = melodic range in semitones
%
% Remarks: 
%
% Example: y = ambitus(nmat);
%
% Authors:
%  Date		Time	Prog	Note
% 12.1.2003	18:44	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
p=pitch(nmat);
a=max(p)-min(p);
