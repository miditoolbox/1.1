function nmatf = dropmidich(nmat, ch)
% MIDI channel based filtering of notes
% nmatf = dropmidich(nmat, ch);
% Filters out note events of NMAT that are on channel CH
%
% Input arguments:
%	NMAT = notematrix
%	CH = number of midi channel to be filtered out
% 
% Output:
%	NMATF = filtered notematrix
% 
% Example:
%	nmatf = dropmidich(nmat,10) 
% removes drum track of general MIDI
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
c = nmat(:,3);
nmatf = nmat(c ~= ch,:); 
