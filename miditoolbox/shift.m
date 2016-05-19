function nm = shift(nmat,dim,sh,timetype)
% Shifting of notematrix values
% nm = shift(nmat,dim,amount,<timetype>);
% Shifts note data in given dimension (onset time, duration, or pitch)
%
% Input arguments:
%	NMAT = notematrix
%	DIM = dimension ('onset', 'dur', 'pitch', 'chan' or 'vel')
%	AMOUNT =  amount of shift
%	TIMETYPE = (optional) time representation, 'beat' (default) or 'sec' 
%
% Output:
%	NM = notematrix containing the shifted version of NMAT
%
% Examples:
%	nm = shift(nmat,'onset',5); % shifts note onsets 5 beats ahead
%	nm = shift(nmat,'dur',-0.1,'sec'); % shortens durations by 0.1 secs
%	nm = shift(nmat,'pitch',12); %transposes one octave up
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

nm = nmat;
warning off
if nargin <4, timetype = 'beat'; end
if strcmp(timetype,'beat')+strcmp(timetype,'sec')==0
		disp(['Unknown timetype:' timetype])
		disp('Accepted timeformats are ''sec'' or ''beat''! ')
	return;
end
timesc=max(nmat(:,2))./max(nmat(:,7));
if strcmp(dim, 'onset')==1
	if strcmp(timetype, 'beat')==1
		nm(:,1)=nm(:,1)+sh; nm(:,1)=max(nm(:,1),0);
		nm(:,6)=nm(:,6)+sh/timesc; nm(:,6)=max(nm(:,6),0);
	elseif strcmp(timetype,'sec')==1
		nm(:,1)=nm(:,1)+sh*timesc; nm(:,1)=max(nm(:,1),0);
		nm(:,6)=nm(:,6)+sh; nm(:,6)=max(nm(:,6),0);
	end
elseif strcmp(dim, 'dur')==1
	if strcmp(timetype, 'beat')==1
		nm(:,2)=nm(:,2)+sh; nm(:,2)=max(nm(:,2),0);
		nm(:,7)=nm(:,7)+sh/timesc; nm(:,7)=max(nm(:,7),0);
	elseif strcmp(timetype,'sec')==1
		nm(:,2)=nm(:,2)+sh*timesc; nm(:,2)=max(nm(:,2),0);
		nm(:,7)=nm(:,7)+sh; nm(:,7)=max(nm(:,7),0);
	end
elseif strcmp(dim, 'pitch')
	nm(:,4)=round(nm(:,4)+sh); nm(:,4)=max(nm(:,4),0); nm(:,4)=min(nm(:,4),127);
elseif strcmp(dim, 'chan')
	nm(:,3)=round(nm(:,3)+sh); nm(:,3)=max(nm(:,3),1); nm(:,3)=min(nm(:,3),16);
elseif strcmp(dim, 'vel')
	nm(:,5)=round(nm(:,5)+sh); nm(:,5)=max(nm(:,5),0); nm(:,5)=min(nm(:,5),127);
else
	disp(['Unknown dimension:' dim])
	disp('Accepted dimensions are ''onset'', ''dur'', ''pitch'', ''chan'' or ''vel''! ')
end
