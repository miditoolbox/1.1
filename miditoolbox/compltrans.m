function s = compltrans(nmat)
% Melodic originality measure (Simonton, 1984) 
% s = compltrans(nmat)
% Calculates Simonton's melodic originality score (1984) 
% based on 2nd order pitch-class distribution of classical music that
% are derived from 15618 classical music themes.
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	S = integer (inverse of averaged probability), scaled 
%     between 0 and 10 (higher value indicates higher melodic
%     originality.
%
% References:
%     Simonton, D. K. (1984). Melodic structure and note transition 
% probabilities: A content analysis of 15,618 classical themes. 
% Psychology of Music, 12, 3-16. 
%     Simonton, D. K. (1994). Computer content analysis of melodic
% structure: Classical composers and their compositions. 
% Psychology of Music, 22, 31-43.
%
% Change History :
% Date		Time	Prog	Note
% 26.3.2003	21:42	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); s=[]; return; end

pc = mod(pitch(nmat),12)+1; % C = 1 etc.
pcd = zeros(12,12);
for k=2:length(pc)
	pcd(pc(k-1),pc(k)) = pcd(pc(k-1),pc(k))+1;
end

% Get Simonton's tone-transition probabilities 
% (from 15618 classical music themes)

a=refstat('pcdist2classical1');

total = pcd .* a;
s=((sum(sum(total))/(length(pc)-1)) * -1); % average and inverse in order to get 'originality'
s=(s+0.0530)*188.68; % scaled from 0-10 (10=complex)
