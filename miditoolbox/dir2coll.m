function [nm,name] = dir2coll(ofname)
% Conversion of directory of midi files to cell matrix
% [nm,name] = dir2coll(ofname)
% Function converts all MIDI files in a directory to a collection format, 
% which is a cellmatrix structure (NM). 
% The filenames are also saved (NAMES). Optionally the variables are 
% saved as Matlab *.MAT file.
%
% Input arguments: 
%	OFNAME = 'filename' (string) 
%
% Output: 
%	NM = cell matrix of all NMATs
%	NAMES = filenames (string)
%
% Remarks: If the input argument is left out, no variables are saved. 
%
% Example: [nm,name] = dir2coll;
%	Reads the midi files in the current directory to the cell matric structure
%
% Authors:
%  Date		Time	Prog	Note
% 28.1.2003	20:21	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

d=dir('*.mid');
h = waitbar(0,'Please wait ...');

for k=1:length(d)
	nm = readmidi(d(k).name);
	matr(k) = {nm};
	waitbar(k/length(d));
end

nm = matr;
name = char({d.name});

if nargin>0
	filename = [ofname '.mat'];
	save (filename, 'nm','name')
end
close(h);
