function nm = setvalues(nmat,dim,val,timetype)
% Sets the chosen notematrix value for every event
% nm = setvalues(nmat,dim,val,<timetype>);
% Sets the chosen notematrix value for every event
%
% Input arguments:
%	NMAT = notematrix
%	DIM = dimension ('onset', 'dur', 'vel', or 'chan')
%	VAL =  Value
%	TIMETYPE = (optional) time representation, 'beat' (default) or 'sec' 
%
% Output:
%	NM = notematrix containing the scaled version of NMAT
%
% Examples:
%	nm = setvalues(nmat,'vel',64); % Sets all note velocities to 64
%	nm = setvalues(nmat,'onset',0); % Sets all onset times to zero
%	nm = setvalues(nmat,'dur',1,'sec'); % Sets all note durations to 1 sec
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

nm = nmat;
if nargin <4, timetype = 'beat'; end
if strcmp(timetype,'beat')+strcmp(timetype,'sec')==0
		disp(['Unknown timetype:' timetype])
		disp('Accepted timeformats are ''sec'' or ''beat''! ')
	return;
end

timesc=max(nmat(:,2))./max(nmat(:,7));

if strcmp(dim, 'onset')==1
	if strcmp(timetype, 'beat')==1
		nm(:,1)=val; nm(:,1)=max(nm(:,1),0);
		nm(:,6)=val/timesc; nm(:,6)=max(nm(:,6),0);
	elseif strcmp(timetype,'sec')==1
		nm(:,1)=val*timesc; nm(:,1)=max(nm(:,1),0);
		nm(:,6)=val; nm(:,6)=max(nm(:,6),0);
	end
elseif strcmp(dim, 'dur')==1
	if strcmp(timetype, 'beat')==1 % fix TE 18.11.2004
		nm(:,2)=val; nm(:,2)=max(nm(:,2),0);
		nm(:,7)=val/timesc; nm(:,7)=max(nm(:,7),0);
	elseif strcmp(timetype,'sec')==1
		nm(:,2)=val*timesc; nm(:,2)=max(nm(:,2),0);
		nm(:,7)=val; nm(:,7)=max(nm(:,7),0);
	end
elseif strcmp(dim, 'pitch')
	nm(:,4)=round(val); nm(:,4)=max(nm(:,4),0); nm(:,4)=min(nm(:,4),127);
elseif strcmp(dim, 'chan')
	nm(:,3)=round(val); nm(:,3)=max(nm(:,3),1); nm(:,3)=min(nm(:,3),16);
elseif strcmp(dim, 'vel')
	nm(:,5)=round(val); nm(:,5)=max(nm(:,5),0); nm(:,5)=min(nm(:,5),127);
else
	disp(['Unknown dimension:' dim])
	disp('Accepted dimensions are ''onset'', ''dur'', ''pitch'', ''chan'' or ''vel''! ')
end
