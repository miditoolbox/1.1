function nm = scale(nmat,dim,fac)
% Scaling of notematrix values
% nm = scale(nmat,dim,factor);
% Scales note data in given dimension (time, onset time, or duration)
%
% Input arguments:
%	NMAT = notematrix
%	DIM = dimension ('time', 'onset', 'dur' or 'vel')
%	FACTOR =  amount of scale (must be > 0)
%
% Output:
%	NM = notematrix containing the scaled version of NMAT
%
% Examples:
%	nm = scale(nmat,'time',2); % scales time axis by a factor of 2
%	nm = scale(nmat,'dur',0.5); % shortens durations by a factor of 2
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

nm = nmat;
warning off
if fac<0, disp('Scaling factor must be greater or equal to zero!'); return; end

if strcmp(dim, 'time')==1 col = [1 2 6 7];
elseif strcmp(dim,'onset')==1 col = [1 6];
elseif strcmp(dim,'dur')==1 col = [2 7];
elseif strcmp(dim,'vel')==1 col = [5];
else
	disp(['Unknown dimension:' dim]);
	disp('Accepted dimensions are ''time'', ''onset'', ''dur'' or ''vel''! ');
	return;
end


nm(:,col)=nm(:,col)*fac;

if strcmp(dim,'vel')==1 
	nm(:,5)=min(nm(:,5),127);
end
