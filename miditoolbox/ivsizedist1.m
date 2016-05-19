function ivd = ivsizedist1(nmat)
% Distribution of interval sizes
% function ivd = ivsizedist1(nmat);
% Returns the distribution of interval sizes in NMAT as a 13-component
% vector. The components are spaced at semitone distances with the 
% first component representing the unison and the last component
% the octave
%
% Input arguments:
%	NMAT = notematrix
%
% Output:
%	IVD = interval size distribution of NMAT
%
% Change History :
% Date		Time	Prog	Note
% 25.4.2003	15:20	PT	Created under MATLAB 5.3 (Macintosh)
% 30.6.2003	13:04	TE	Revised
%© Part of the MIDI Toolbox Software Package, Copyright © 2002, University of Jyväskylä, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); ivd=[]; return; end

tmp = ivdist1(nmat);
ind = [13:-1:1 2:13];
ivd=zeros(1,13);
for k=1:25
	ivd(ind(k)) = ivd(ind(k))+tmp(k);
end
