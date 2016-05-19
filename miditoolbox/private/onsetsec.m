function os = onsetsec(nmat);
% Onset times in seconds
% os = onsetsec(nmat);
% Returns the onset times of notes in NMAT in seconds
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	OS = onset times of notes in NMAT in seconds
%
% Comment: Auxiliary function that resides in private directory
%
%  Date		Time	Prog	Note
% 4.6.2002	18:36	TE	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyväskylä, Finland
% See License.txt
os = nmat(:,6);
