function y = gradus(nmat)
% Degree of melodiousness (Euler, 1739)
% y = gradus(nmat)
% Calculates the degree of melodiousness (gradus suavitatis),
% proposed by L. Euler (1707-1783). He suggested that the 
% "degree of melodiousness depends on calculations made by the mind:
% fewer calculations, the more pleasant the experience. ...[The model]
% is implemented by a numerical technique based on the decomposition
% of natural numbers into a product of powers of different primes."
% (Leman, 1995, p. 5)
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	Y = integer ( degree of melodiousness)
%           where low value indicates high melodiousness
%
% References:
% Euler, L. (1739). Tentamen novae theoriae musicae.
% Leman, M.  (1995). Music and schema theory: Cognitive foundations of 
%     systematic musicology. Berlin: Springer.
%
%  Author	Date
%	Change History :
% 	Date		Time	Prog	Note
% 30.9.2003	20:26	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); y=[]; return; end

int=abs(diff(pitch(nmat))); % intervals +1 for indexing
int=mod(int,12)+1; % collapse intervals into 1 octave
% frequency ratios for intervals...
frq1=[1,16,9,6,5,4,45,3,8,5,16,15]; % nominator
frq2=[1,15,8,5,4,3,32,2,5,3,9,8]; % denominator

for k=1:length(int)
	n(k)=frq1(int(k)); % nominator
	d(k)=frq2(int(k)); % denominator
end

for s=1:length(n)
	gs(s)=suavitatis(n(s),d(s)); % decompose into product of powers...
end
y=mean(gs); % take the mean as the degree of melodiousness


%%%%%%%%%%%%%%%%%%%%%%%%
function g=suavitatis(n,d)
% Calculation of melodiousness (Euler, 1739)
% g=suavitatis(n,d)
% See gradus_suavitatis.m
%
% Input argument: 
%	N = nominator
%     D = denominator
%
% Output: 
%	G = integer (degree of melodiousness)
%

	g=n*d;
	g2=factor(g);
	for i=1:length(g2)
		g3(i)=1*g2(i)-1;
	end
	g=sum(g3)+1;
