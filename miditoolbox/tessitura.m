function y= tessitura(nmat)
% Melodic tessitura based on deviation from median pitch height (Hippel, 2000)
% Y = tessitura(NMAT)
% Calculates the tessitura that is based on standard deviation of pitch height.
% The median range of the melody tends to be favoured and thus 
% more expected. Tessitura predicts whether listeners expect tones close 
% to median pitch height (Hippel, 2000).
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	Y = tessitura value for each tone in NMAT
%
% See also: NARMOUR, MOBILITY
%
% Remarks:
%
% Example: y = tessitura(nmat)
%
% References:
% von Hippel, P. (2000). Redefining pitch proximity: Tessitura and 
%     mobility as constraints on melodic interval size. Music Perception, 
%     17 (3), 315-327. 
%
%  Author		Date
% 2.7.2003	12:04	TE	Created under MATLAB 5.3 (PC)
% Part of the MIDI Toolbox, Copyright 2004, University of Jyvaskyla, Finland

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); y=[]; return; end

for i=2:length(nmat)
	m(i-1)=median(pitch(nmat(i-1,:)));
	deviation(i-1) = std(pitch(nmat(1:i-1,:)));
	y(i-1)=(pitch(nmat(i,:))-m(i-1))/deviation(i-1);
	y(1)=0;
end
y=[0 y];
y=abs(y'); % FIX: for continous ratings