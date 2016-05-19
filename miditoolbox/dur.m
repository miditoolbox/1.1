function d = dur(nmat,timetype)
% Note durations in beats or seconds
% function d = dur(nmat,<timetype>);
% Returns the durations in beats or seconds of the notes in NMAT
%
% Input argument:
%	NMAT = notematrix
%	TIMETYPE (Optional) = timetype ('BEAT' (default) or SEC (Seconds).
%
% Output:
%	D = note durations in beats or in seconds
%
%  Date		Time	Prog	Note
% 4.6.2002	18:36	TE	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), d = []; return; end
if nargin<2, timetype='beat'; end

if strcmp(timetype, 'sec')
	d = nmat(:,7);
elseif strcmp(timetype, 'beat')
	d = nmat(:,2);
else
	disp(['Unknown TIMETYPE option:''', timetype,''''])
	disp('     =>''beat'' used instead')
	d = nmat(:,2);
end
