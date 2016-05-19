function ivd = ivdist1(nmat)
% Distribution of intervals
% ivd = ivdist1(nmat);
% Returns the distribution of intervals in NMAT as a 25-component vector
% The components are spaced at semitone distances with the first
% component representing the downward octave and the last component
% the upward octave. The distribution is weighted by note durations.
% The note durations are based on duration in seconds that are 
% modified according to Parncutt's durational accent model (1994).
%
%
% Input arguments:
%	NMAT = notematrix
%
% Output:
%	IVD = interval distribution of NMAT
%
% Change History :
% Date		Time	Prog	Note
% 2.5.2002	15:20	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); ivd=[]; return; end

ch = mchannels(nmat);
du = duraccent(dur(nmat,'sec')); % durations are weighted by Parncutt's durational 
ivd = zeros(1,25);
for k=1:length(ch)
	d = getmidich(nmat,ch(k));
	p = d(:,4);
	iv = diff(p);
	for m=1:length(iv)
		if abs(iv(m))<=12
			ivd(iv(m)+13)=ivd(iv(m)+13)+1*(du(m+1)+du(m));
		end
	end
end
ivd = ivd/sum(ivd + 1e-12); 
