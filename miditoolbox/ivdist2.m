function ivd = ivdist2(nmat)
% Distribution of interval dyads
% ivd = ivdist2(nmat);
% Returns the distribution of interval dyads in NMAT. The distribution is
% weighted by note durations. The note durations are based on duration
% in seconds that are modified according to Parncutt's durational 
% accent model (1994).
%
% Input arguments:
%	NMAT = notematrix
%
% Output:
%	IVD = interval distribution of NMAT
%
% See IVDIST1
%
% Change History :
% Date		Time	Prog	Note
% 28.6.2002	16:48	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); ivd=[]; return; end

iv0=nmat(:,4);
pcdiff=diff(iv0);
a=[0 pcdiff'];
iv=mod(abs(a),12).*sign(a)+13;    %

	du = duraccent(dur(nmat,'sec')); % durations are weighted by Parncutt's durational accent

ivd = zeros(25,25);
for k=2:length(iv)
 	ivd(iv(k-1),iv(k)) = ivd(iv(k-1),iv(k))+du(k-1)+du(k);
 end
ivd = ivd/sum(sum(ivd + 1e-12)); % normalize 
