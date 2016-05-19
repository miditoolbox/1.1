function p = pitch(nmat)
% MIDI note numbers
% p = pitch(nmat);
% Returns the MIDI note numbers of the events in NMAT
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	P = MIDI note numbers in NMAT
%  Date		Time	Prog	Note
% 4.6.2002	18:36	PT	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
p = nmat(:,4);
