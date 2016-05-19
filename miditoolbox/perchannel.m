function chout = perchannel(nmat,func)
% Channel-by-channel analysis of notematrix using a specified function
% chout = perchannel(nmat,varargin);
% Channel-by-channel analysis of notematrix using a specified function.
% Works only with functions returning either scalar or row vector.
%
% Input argument:
%	NMAT = notematrix
%	FUNC = function (string)
%
% Output:
%	chout = scalar or row vector for each channel. Size depends on the FUNC.
%
% Example:
%	p=perchannel(nmat,'pcdist1');
%
% Change History :
% Date		Time	Prog	Note
% 17.6.2002	20:03	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

if size(feval(func,createnmat),1)>1
	disp([mfilename ' works only with functions returning either scalar or row vector!'])
	chout=[];
	return
end

chout =[];

for m=1:max(mchannels(nmat))
	temp=getmidich(nmat,m);
	chout(m,:) = [feval(func,temp)];
	chout=[chout;];
end
