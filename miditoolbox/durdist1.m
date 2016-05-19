function dd = durdist1(nmat)
% Note duration distribution
% dd = durdist1(nmat);
% Returns the distribution of note durations in NMAT as a 9-component
% vector
% The centers of the bins are on a logarithmic scale as follows:
%	component	bin center (in units of one beat)
%	1		1/4
%	2		sqrt(2)/4
%	3		1/2
%	4		sqrt(2)/2
%	5		1
%	6		sqrt(2)
%	7		2
%	8		2*sqrt(2)
%	9		4
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	DD = 9-component distribution of note durations
%
% Change History :
% Date		Time	Prog	Note
% 8.8.2002	16:03	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
du = dur(nmat);
du = du(du>0); % remove zero duations
du = round(2*log2(du)); % take logarithms & categorize
du = du(abs(du)<=4); % include duations between 1/16 and 1/1 notes
du = du+5; % shift category indeces to range 1 ... 9

	if ~isempty(du)
		dd = hist(du, 1:9);
	else
		dd = zeros(1,9);
	end

dd=dd/sum(dd + 1e-12);
