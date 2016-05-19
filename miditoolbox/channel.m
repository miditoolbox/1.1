function ch = channel(nmat)
% MIDI channels of note events
% ch = channel(nmat);
% Returns the midi channels of the events in NMAT
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	CH = vector containing the midi channel of each note in NMAT
%
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
ch = nmat(:,3);
