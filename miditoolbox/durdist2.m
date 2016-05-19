function dd = durdist2(nmat)
% Duration dyad distribution
% dd = durdist2(nmat);
% Returns the distribution of pairs of note durations of successive
% notes as a 9 * 9 matrix
% For bin centers, see DURDIST1
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	DD = 9 * 9 distribution matrix of note duration pairs
%
% Change History :
% Date		Time	Prog	Note
% 10.6.2002	16:03	TE	Created under MATLAB 5.3 (PC)
% 8.8.2002	15:10	PT	Revised
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); dd=[]; return; end

du = dur(nmat);
du = du(du>0); % remove zero duations
du = round(2*log2(du)); % take logarithms & categorize
du = du(abs(du)<=4); % include duations between 1/16 and 1/1 notes
du = du+5; % shift category indeces to range 1 ... 9

durd = zeros(9,9);

for k=2:length(du)
	durd(du(k-1),du(k)) = durd(du(k-1),du(k))+1;
%pcolor(durd); % diagnostics...
end

dd = durd/sum(sum(durd+ 1e-12)); % normalize 

