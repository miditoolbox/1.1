function ob = onset(nmat,timetype)
% Onset times in beats or seconds
% ob = onset(nmat,<timetype>);
% Returns the onset times in beats or seconds of the notes in NMAT
%
% Input argument:
%	NMAT = notematrix
%	TIMETYPE (Optional) = timetype ('BEAT' (default) or SEC (Seconds).
%
% Output:
% 	OB = onset times in beats or seconds of notes in NMAT
%
%  Date		Time	Prog	Note
% 4.6.2002	18:36	TE	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), ob = []; return; end
if nargin<2, timetype='beat'; end

if strcmp(timetype, 'sec')
	ob = nmat(:,6);
elseif strcmp(timetype, 'beat')
	ob = nmat(:,1);
else
	disp(['Unknown TIMETYPE option:''', timetype,''''])
	disp('     =>''beat'' used instead')
	ob = nmat(:,1);
end