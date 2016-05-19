function c = concur(nmat,threshold)
% Detection of simultaneous onsets in a notematrix
% c = concur(nmat, <threshold>)
% Calculates the number of simultaneous onsets in NMAT with certain beat THRESHOLD.
% This function is used in finding and eliminating short tracks in multichannel MIDI files, i.e.
% it is used in FIND_DRUMS function.
%
% Input arguments:
%	NMAT= notematrix
%	THRESHOLD = (optional) value for threshold for concurrent onsets
%			default value is ± 0.2 beats
%
% Output:
%	C = integer displaying the proportion of concurrent onsets
%
% Example: 
%	concur(nmat,0.25);
%
% Authors:
%  Date		Time	Prog	Note
% 3.1.2003	14:00	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<2, threshold=0.2; end;

u=unique(onset(nmat));

for i = 1:length(u)
	z=onset(nmat(i));
	s=sum(onset(nmat<=z+threshold & nmat>=z-threshold))-1;
end
c=s/length(nmat);
