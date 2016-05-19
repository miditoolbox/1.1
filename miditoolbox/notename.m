function names=notename(n)
% Conversion of MIDI numbers to American pitch spelling (text)
% names=notename(n)
% Converts MIDI numbers to American pitch spelling (text) where C4# 
% denotes C sharp in octave 4. Octave 4 goes from middle C up to 
% the B above middle C. 
%
% Input argument: 
%	N = The pitches of NMAT (i.e. pitch(nmat))
%
% Output: text string of equivalent size of N.
%
% Remarks:
%
% Example:
%
%  Author		Date
%  T. Eerola	3.1.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

%n=pitch(nmat)
  m=round(n(:));
  o=floor(m/12)-1;
  m=m-12*o+6*sign(n(:))-5;
  a=('CDDEEFGGAABBCCDDEFFGGAAB')';
  b=(' - -  - - -  # #  # # # ')';
  names=char([a(m) mod(o,10)+'0' b(m)]);