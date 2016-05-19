function nmatf = dropshortnotes(nmat,timetype,threshold)
% Filter out short notes
% nmatf = dropshortnotes(nmat,timetype,threshold);
% Filters out note events in NMAT that are shorter than THRESHOLD
% 
% Input arguments:
%	NMAT = notematrix
%	TIMETYPE = time unit for duration: possible values are
% 		'sec' and 'beat' (default)
%	THRESHOLD = duration threshold for filtering
%
% Output:
%	NMATF = filtered notematrix
%
% Example: Filter out notes shorter than 1/16:
%	nmatf = dropshortnotes(nmat, 'beat', 1/16)
%
% Change History :
% Date		Time	Prog	Note
% 18.6.2002	18:37	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<3, threshold=.1; end
if nargin<2, timetype='beat'; end

secs = dur(nmat,timetype);
nmatf = nmat(secs >= threshold,:); 
