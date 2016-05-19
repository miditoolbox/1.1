function r = maxkkcc(nmat)
% Maximal correlation from Krumhansl-Kessler algorithm
% r = maxkkcc(NMAT);
% Returns the maximum across the correlations between the pitch class
% distribution of NMAT and each of the 24 Krumhansl-Kessler profiles
%
% Input argument:
%	NMAT = notematrix
%	
% Output:
%	R = maximum correlation
%
% Change History :
% Date		Time	Prog	Note
% 10.6.2002	16:00	PT	Created under MATLAB 5.3 (Mac)
%
% See also KEYMODE, KKCC, and KKKEY in the MIDI Toolkit.
%
% Reference:
%	Krumhansl, C. L. (1990). Cognitive Foundations of Musical Pitch.
%	New York: Oxford University Press.
%
% Part of the MIDI Toolbox, Copyright 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

r = max(kkcc(nmat));
