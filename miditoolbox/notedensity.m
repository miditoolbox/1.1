function n = notedensity(nmat,timetype)
% Number of notes per beat or second
% n = notedensity(nmat,<timetype>);
% Returns the number of notes per beat or second in NMAT
%
% Input argument:
%	NMAT = notematrix
%	TIMETYPE (Optional) = timetype ('BEAT' (default) or SEC (Seconds).
%
% Output:
%	N = Note density (in beats or seconds) in NMAT
%
% Change History :
% Date		Time	Prog	Note
% 1.4.2004	15:37	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<2, timetype='beat'; end

ob = onset(nmat,timetype);

if (ob(end)-ob(1))==0
	n=0;
else
	n = (size(nmat,1)-1) / (ob(end)-ob(1));
end
