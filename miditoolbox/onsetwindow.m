function nm = onsetwindow(nmat,mintime,maxtime,timetype)
% Onset time based windowing
% nm = onsetwindow(nmat,mintime,maxtime,<timetype>);
% Returns the notes in NMAT whose onset times satisfy
% MINTIME <= onsettime[beats/secs](NMAT) <= MAXTIME
%
% Input arguments:
%	NMAT = notematrix
%	MINTIME = minimum limit of the window in beats (default) or secs
%	MAXTIME = maximum limit of the window in beats (default) or secs
%	TIMETYPE = time representation, 'beat' (default) or 'sec' 
%
% Output:
%	NM = notematrix containing the notes of NMAT whose onsets
%	are within the window
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin <4, timetype = 'beat'; end

if strcmp(timetype, 'beat')==1
	nm = nmat(mintime<=nmat(:,1) & nmat(:,1)<=maxtime,:);
elseif strcmp(timetype, 'sec')==1
	nm = nmat(mintime<=nmat(:,6) & nmat(:,6)<=maxtime,:);  
else
	disp(['Unknown timetype:' timetype])
	disp('Accepted timeformats are ''sec'' or ''beat''! ')
end