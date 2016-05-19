function ch = mchannels(nmat)
% MIDI channels used in notematrix
% ch = mchannels(nmat);
% Returns the midi channels that are used in notematrix NMAT
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	CH = vector containing the nummbers of all MIDI channels
%		that are used in NMAT
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

c = nmat(:,3);
ch = [];

for k=1:16
	if sum(c==k) > 0
		ch = [ch k];
	end
end 
