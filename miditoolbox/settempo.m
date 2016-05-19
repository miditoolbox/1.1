function nmatf = settempo(nmat,bpm)
% Set tempo (in BPM)
% y = settempo(nmat,bpm)
% Assigns a new tempo to the NMAT in beats per minute (BPM)
%
% Input argument:
%	NMAT = notematrix
%	BPM = new tempo (in beats per minute)
%
% Output:
%	NMATF = new notematrix
%
% Change History :
% Date		Time	Prog	Note
% 1.7.2003	18:53	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

t=gettempo(nmat);
x= bpm/t;
nmatf=nmat;
nmatf(:,6) = onset(nmat,'sec')/x;
nmatf(:,7) = dur(nmat,'sec')/x;
