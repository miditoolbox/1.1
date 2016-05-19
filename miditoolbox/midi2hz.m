function f=midi2hz(m)
% Conversion of MIDI note number to frequency (Hz)
% f=midi2hz(m)
% Convert MIDI note numbers to frequencies in hertz (Hz). The A3 
% (Midi number 69) is 440Hz.
%
% Input arguments: M = pitches in MIDI numbers
%
% Output: F = pitches in hertz
%
% Example: midi2hz(pitch(createnmat));
%
%  Author		Date
%  T. Eerola	1.2.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(m), return; end
f= 440 * exp ((m-69) * log(2)/12);
