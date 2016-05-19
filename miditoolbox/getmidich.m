function nmatf = getmidich(nmat, ch)
% Note events on a given MIDI channel
% nmatf = getmidich(nmat, ch);
% Returns note events of NMAT that are on MIDI channel CH
%
% Input arguments:
%	NMAT = notematrix
%	CH = MIDI channel
%
% Output:
%	NMATF = notematrix containing notes of NMAT that are on MIDI
%		channel CH
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
c = nmat(:,3);
nmatf = nmat(c == ch,:); 
