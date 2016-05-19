function n = nPVI(nmat)
% Measure of durational variability of events (Grabe & Low, 2002)
% function n = nPVI(nmat)
%
% This measure is borne out of language research. It has been noted that 
% the variability of vowel duration is greater in stress- vs. syllable-timed 
% languages (Grabe & Low, 2002). This measure accounts for the 
% variability of durations and is also called "normalized Pairwise Variability 
% Index" (nPVI). Patel & Daniele have applied it to music (2003) by comparing
% whether the prosody of different languages is also reflected in music. There is 
% a clear difference between a sample of works by French and English composers.
%
% Input arguments: NMAT = notematrix
%
% Output: N = nPVI index
%
% Remarks:
%
% Example: the variability of duration in LAKSIN (a Finnish folk tune available in demos)
% 	nPVI(laksin);
% ans = 26.3861
%
% References:
% Patel, A. D. & Daniele, J. R. (2003). An empirical comparison of rhythm in 
%     language and music, Cognition 87, B35-B45.
% Grabe, E., & Low, E. L. (2002). Durational variability in speech and the 
%     rhythm class hypothesis. In C. Gussen-hoven & N. Warner, Laboratory 
%     phonology (pp. 515-546). 7. Berlin: Mouton de Gruyter.
%
%  Author	Date
%  T. Eerola	17.4.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

a=dur(nmat,'sec');
for i=2:length(a)
	s(i)=(a(i-1)-a(i))/((a(i-1)+a(i))/2);
end
n = 100/(length(a)-1) * sum(abs(s));
