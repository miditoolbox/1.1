function a = meteraccent(nmat)
% Measure of phenomenal accent synchrony
% a = meteraccent(nmat);
% Returns a measure of phenomenal accent synchrony. It consists of 
% durational accents, pitch accents and accentuation from inferred metrical hierarchy.
%
% Input arguments:
%	NMAT = notematrix
%
% Output:
%	A = integer
%
% References:
%  Eerola, T., Himberg, T., Toiviainen, P., & Louhivuori, J. (2006). Perceived complexity of Western and African folk melodies by Western and African listeners. Psychology of Music, 34(3), 341-375. 
%  Jones, M. R. (1987). Dynamic pattern structure in music: Recent theory and research. Perception and Psychophysics, 41, 621-634.
%
% Change History :
% Date		Time	Prog	Note
% 30.9.2003	20:22	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); a=[]; return; end

mh = metrichierarchy(nmat);
ma = melaccent(nmat);
du = duraccent(dur(nmat,'sec'));

a = mean(mh .* ma .* du) *-1; 
