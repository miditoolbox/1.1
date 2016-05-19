function k = keymode(nmat)
% Mode (major vs. minor) estimation
% k = keymode(nmat);
% Functions estimates the key mode (1=major, 2=minor) based on 
% Krumhansl-Kessler key finding allgorithm and NMAT pitch distribution.
% This function is used to assign TONALITY values to NMAT.
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	K = estimated mode of NMAT (1=major, 2=minor)
%
% Remarks: 
%
% Example: k = keymode(nmat)
%
% See also KKCC, KKMAX, and KKKEY in the MIDI Toolkit.
%
% Authors:
%  Date		Time	Prog	Note
% 10.11.2002	11:21	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

u = kkcc(nmat);
major =u(1);
minor =u(13);
	if major>minor
		k=1;
	elseif major<minor
		k=2;
	else
		k=0;
		disp('major/minor equally strong!')
	end
