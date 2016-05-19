function nm2 = extreme(nmat,meth)
% Returns the extreme pitches (high or low) of a polyphonic NMAT
% nm2 = extreme(nmat,<meth>)
%
% Input argument: 
%	NMAT = notematrix
%	METH = method, either HIGH (default) or LOW
%
% Output: 
%	NM2 = monophonic notematrix containing only highest/lowest pitches
%
% Remarks: 
%
% Example: Obtain a new notematrix containing only the lowest lowest pitches:
% nm2 = extreme(nmat,'low');
%
% Authors:
%  Date		Time	Prog	Note
% 11.1.2004	12:00	PT	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

if nargin==1, meth='high'; end % defaul: high

if strcmp(meth,'low')
	meth=2;
elseif strcmp(meth,'high')
	meth=1;
else
	disp('Unknown METH: Only high or low accepted! High will be used.')
end

nm2=[];

p=pitch(nmat); on=onset(nmat); du=dur(nmat);
high=1; k=1;
while k<length(p)
		if on(k)+du(k)<=on(k+1)
		        nm2=[nm2; nmat(high,:)];
        		high=k+1;
		elseif p(high)<p(k+1) && meth==1 % HIGH
		high=k+1;
		elseif p(high)>p(k+1) && meth==2 % LOW
		high=k+1;
		end
    k=k+1;
end
nm2=[nm2; nmat(high,:)];
