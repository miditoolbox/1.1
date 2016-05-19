function m = hz2midi(hz)
% Hertz to MIDI note number conversion
% m = hz2midi(hz)
% Converts frequency values given in Hertz to MIDI note numbers
% Notes are numbered in semitones with middle C being 60. 
% Midi note 69 (A3) has a frequency of 440 hertz (abbreviated Hz), i.e. 
% 440 cycles per second.
%
% Input arguments: 
%	HZ = Frequency values in hertz
%
% Output: 
%	M = MIDI note numbers
%
% Example:
%
%  Author		Date
%  T. Eerola	1.2.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(hz), return; end
m=(69+12 * log(abs(hz)/440)/log(2));
