function l = ismonophonic(nmat,overlap,timetype)
% Returns 1 if NMAT is monophonic (logical function)
% l = ismonophonic(nmat,<overlap>,<timetype>);
% Returns 1 if the sequence has NO overlapping notes in NMAT. Function can be 
% used for finding errors in monophonic melodies and checking whether analysis is
% suitable for the selected NMAT. For example, ivdist1 cannot be meaningfully
% performed for a polyphonic input.
%
% Input argument: 
%      NMAT = notematrix
%	OVERLAP (Optional) = Criteria for allowing short overlap between events. 
%                                   The default value is 0.1 seconds
%	TIMETYPE (Optional) = timetype ('BEAT' or SEC (Seconds, default).
%
% Output: 
%	L = 1 (is monophonic) or 0 (polyphonic)
%
% Authors:
%  Date		Time	Prog	Note
% 2.11.2001	20:24	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<3, timetype='sec'; end
if nargin<2, overlap=0.1; end

l=1;
c=[];
a=onset(nmat,timetype);
b=dur(nmat,timetype);
	for i=2:size(nmat,1)
	c(i)=a(i)-(a(i-1)+b(i-1));
		if c(i) < -overlap % overlap criteria (for example, 0.05-3.0)
		l=0;
		end
	end
