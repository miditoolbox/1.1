function n = nnotes(nmat)
% Number of notes in NMAT
% n = nnotes(nmat);
% Returns the number of notes in NMAT
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	N = number of notes in NMAT
%
% Remarks:
%
% Example:
%
%  Author		Date
%  T. Eerola	4.5.2002
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

n = size(nmat,1);
