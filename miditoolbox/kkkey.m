function k = kkkey(nmat)
% Key of NMAT according to the Krumhansl-Kessler algorithm
% k = kkkey(nmat);
% Returns the key of NMAT according to the Krumhansl-Kessler algorithm.
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	K = estimated key of NMAT encoded as a number
% 	encoding: 	C major = 1, C# major = 2, ...
%           		c minor = 13, c# minor = 14, ...
%
% Remarks:
%
% See also KEYMODE, KKMAX, and KKCC.
%
% Example:
%
% Reference:
%	Krumhansl, C. L. (1990). Cognitive Foundations of Musical Pitch.
%	New York: Oxford University Press.
%
%  Author		Date
%  P. Toiviainen	8.8.2002
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

[tmp, k] = max(kkcc(nmat));
