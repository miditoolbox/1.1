function y = movewindow(nmat,wlength,wstep,timetype,varargin)
% Windowed analysis of notematrix using a specified function
% y = movewindow(nmat,wlength,wstep,timetype,varargin)
% Applies function defined in VARARGIN to a series of windowed note matrices
% using window length WLENGTH and step WSTEPs across NMAT
%
% Input arguments: 
%	NMAT = notematrix
%	WLENGTH = window length in seconds
%	WSTEP = window step size in seconds
%	TIMETYPE = time representation, 'beat' (default) or 'sec' 
%	VARARGIN = function (string) or functions
%
% Output: 
%	Y = output of the function VARARGIN (or nested function FUNC2(FUNC1) etc.) 
%		applied to NMAT
%
% Example 1: Find maximal key correlation within a 3-second window -
%      that is moved by 1.5 seconds at a time - of NMAT
%      y = movewindow(nmat,3,1.5,'sec','maxkkcc');
%
% Example 2: Find average key velocity within a 6-second window -
%		that is moved by 2 seconds at a time - of NMAT
%		y = movewindow(nmat,6,2,'velocity','mean');
%
% Authors:
%  Date		Time	Prog	Note
% 5.2.2003	17:44	PT	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if strcmp(timetype, 'sec')~=1 && strcmp(timetype, 'beat')~=1
   disp(['Unknown timetype:' timetype])
   disp('Accepted timeformats are ''sec'' or ''beat''! ')
   return
end

if strcmp('sec',timetype)
   os=onset(nmat,'sec');
   ds = dur(nmat,'sec');
else
   os=onset(nmat);
   ds = dur(nmat);
end

y= [];
for t = 0:wstep:(os(end)+ds(end))
   x = onsetwindow(nmat,t-wlength,t,timetype);
   for f=1:length(varargin)
      if isempty(x) % Return empty for empty matrix
         z=[];
      else
         z = feval(varargin{f},x);
         x=z;
      end
   end
   y = [y;z];
end
