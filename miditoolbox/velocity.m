function v = velocity(nmat)
% Velocities of notes
% v = velocity(nmat);
% Returns the velocities of the notes in NMAT
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	V = velocity values of notes in NMAT
%
%  Date		Time	Prog	Note
% 4.6.2002	18:36	TE	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

v = nmat(:,5);
