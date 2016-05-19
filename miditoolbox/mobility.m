function y= mobility(nmat)
% Melodic motion as a mobility (Hippel, 2000)
% y= mobility(nmat)
% Mobility describes why melodies change direction after large skips 
% by simply observing that they would otherwise run out of the 
% comfortable melodic range. It uses lag-one autocorrelation between 
% successive pitch heights (Hippel, 2000).
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	Y = mobility value for each tone in NMAT
%
% See also: NARMOUR, TESSITURA
%
% Remarks:
%
% Example: y = mobility(nmat)
%
% References:
% von Hippel, P. (2000). Redefining pitch proximity: Tessitura and 
%     mobility as constraints on melodic interval size. Music Perception, 
%     17 (3), 315-327. 
%
%  Author		Date
% 2.7.2003	12:09	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat) disp([mfilename, ' works only with monophonic input!']); y=[]; return; end

for i=2:length(pitch(nmat))

	m(i-1) = mean(pitch(nmat(1:i-1,:)));
	p(i-1) = pitch(nmat(i-1,:)) - m(i-1);
	p2(i) = pitch(nmat(i-1,:)) - m(i-1);

	z=[p p(i-1)];
	p3 = [p2; z]';

	c=corrcoef(p3);
	mob(i)=c(1,2);

	y(i-1) = mob(i-1)*pitch((nmat(i,:))-m(i-1));

end
y(2)=0;
y=[0 y];
y=abs(y');% FIX: for continous ratings
