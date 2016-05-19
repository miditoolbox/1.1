function b = boundary(nmat, fig)
% Local Boundary Detection Model by Cambouropoulos
% function b = boundary(nmat, <fig>)
% Returns the boundary strength profile of NMAT
% according to the Local Boundary Detection Model
% by Cambouropoulos (1997)
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	B = strength of boundary following each note
%	FIG (optional) = if any value is given, creates a graphical output
%
% Reference: 
% Cambouropoulos, E. (1997). Musical rhythm: A formal model for determining local 
%      boundaries, accents and metre in a melodic surface. In M. Leman (Ed.), 
%      Music, Gestalt, and Computing: Studies in Cognitive and Systematic Musicology 
%      (pp. 277-293). Berlin: Springer Verlag.
%
% Example: y = boundary(nmat)
%
% Authors:
%  Date		Time	Prog	Note
% 7.4.2004	18:44	PT	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if nargin==1, fig=0; else fig=1;end

% profiles
pp = abs(diff(pitch(nmat))); % pitch profile
on = onset(nmat); off = on+dur(nmat);
po = diff(on); % ioi profile
pr = max(0, on(2:end)-off(1:end-1)); % rest profile

% degrees of change
rp = [abs(pp(2:end)-pp(1:end-1)) ./ (1e-6+pp(2:end)+pp(1:end-1)); 0];
ro = [abs(po(2:end)-po(1:end-1)) ./ (1e-6+po(2:end)+po(1:end-1)); 0];
rr = [abs(pr(2:end)-pr(1:end-1)) ./ (1e-6+pr(2:end)+pr(1:end-1)); 0];

% strengths
sp = pp.*[0; (rp(1:end-1)+rp(2:end))]; if max(sp)>0.1, sp = sp/max(sp); end
so = po.*[0; (ro(1:end-1)+ro(2:end))]; if max(so)>0.1, so = so/max(so); end
sr = pr.*[0; (rr(1:end-1)+rr(2:end))]; if max(sr)>0.1, sr = sr/max(sr); end

% overall profile
b = [1; 0.25*sp + 0.5*so + 0.25*sr];

if fig==1
	pianoroll(nmat); set(gca,'Position',[0.05 0.55 0.9 0.4]); xl=get(gca,'XLim');
	subplot('Position',[0.05 0.05 0.9 0.4])
	stem(on,b);
	set(gca,'XLim',xl);
	set(gcf,'NumberTitle','off');
	set(gcf,'Name','Boundary strengths');
end
