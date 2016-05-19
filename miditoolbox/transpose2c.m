function trans = transpose2c(nmat)
% Transposition to C tonic
% trans = transpose2c(nmat);
% Transposes NMAT to C major or minor using the Krumhansl-Kessler
% algorithm. Note that the algorithm may not give reliable results if the 
% NMAT is especially short or has a modulating structure.
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	TRANS = tranposed notematrix 
%
% Example: trans = transpose2c(nmat);
%
% Authors:
%  Date		Time	Prog	Note
% 6.8.2002	13:24	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

matrix=kkcc(nmat);
[maximum k] = max(matrix);
trans=[nmat(:,1:3) nmat(:,4)-k+1 nmat(:,5:end)];
