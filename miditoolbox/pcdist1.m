function pcd = pcdist1(nmat)
% Pitch-class distribution weighted by note durations
% pcd = pcdist1(nmat);
% Calculates the pitch-class distribution of NMAT weighted by note durations. The note 
% durations are based on duration in seconds that are modified according to Parncutt's 
% durational accent model (1994).
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	PCD = 12-component vector listing the probabilities of
% 	pitch-classes (C, C#, D, D#, E, F, F#, G, G#, A, A#, B).
%
% See also: IVDIST1, DURDIST1, PCDIST2, IVDIST2, DURDIST2
%
% Remarks:
%
% Example: pcd = pcdist1(nmat)
%
%  Author		Date
%  T. Eerola	2.2.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
pc = mod(nmat(:,4),12)+1; % C = 1 etc.
%dur = nmat(:,2);
du = duraccent(dur(nmat,'sec')); % durations are weighted by Parncutt's durational accent
pcd = zeros(1,12);
for k=1:length(pc)
	pcd(pc(k)) = pcd(pc(k))+du(k);
end
pcd = pcd/sum(pcd + 1e-12); % normalize 
