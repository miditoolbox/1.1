function n = writemidi(nmat, ofname, tempo, tpqn)
% Writes a MIDI file from a NMAT 
% n = writemidi(NMAT, OFNAME, <TEMPO>, <TPQN>);
%
% Creates a MIDI file from a NMAT using various optional parameters
%
% Input arguments: NMAT = notematrix
%     OFNAME = Output filename (*.mid)
%	  TEMPO (Optional) = bpm, beats per minute (default 100)
%	  TPQ (Optional) = Ticks per quarter note (default 120)
%
% Output: MIDI file
%
% Example: writemidi(a,'demo.mid'); creates a file name DEMO.MID from notematrix A with
% default settings. 
%
%  Author		Date
%  T. Eerola	1.2.2003
%  T. Eerola    18.5.2016 Adapted the Music Dynamics version writeNMatToSmf
% Part of the MIDI Toolbox, Copyright 2016, University of Jyvaskyla, Finland
% See License.txt

%default tempo and tpqn (ticks per quarter note)
if (nargin<3)
    tempo = 120;
    tpqn = 480;
elseif (nargin<4)
    tpqn = 480;
end

n = writeNMatToSmf(nmat, ofname, tempo, tpqn);

