function ivd = ivdirdist1(nmat)
% Distribution of interval directions
% function ivd = ivdirdist1(nmat);
% Returns the proportion of upward intervals for each interval size
% in NMAT as a 12-component vector
% The components are spaced at semitone distances with the first
% component representing minor second and the last component
% the upward octave
%
% Input arguments:
%	NMAT = notematrix
%
% Output:
%	IVD = interval direction distribution of NMAT
%
% Change History :
% Date		Time	Prog	Note
% 25.4.2003	15:20	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox Software Package, Copyright © 2002, University of Jyväskylä, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); ivd=[]; return; end

tmp = ivdist1(nmat);
for k=1:12
	summa = tmp(k+13)+tmp(13-k);
	if summa>0
		ivd(k) = ((tmp(k+13)-tmp(13-k))/summa);
	else
		ivd(k) = 0;
	end
end
