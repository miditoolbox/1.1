function p = tonality(nmat)
% Tonal stability of notes in melody
% p = tonality(nmat);
% Function gives the tonal stability ratings for tones in the melody 
% (NMAT) after determining the key mode (minor/major) using the KEYMODE 
% function.
%
% Input argument: 
%	NMAT = notematrix
%
% Output: 
%	P = tonality values for pitches in NMAT
%
% Remarks: This function calls the KEYMODE function. Alternatively,
% revised version of the Krumhansl & Kessler key profile ratings could be used.
%
% Reference: 
%	Krumhansl, C. L. (1990). Cognitive Foundations of Musical Pitch.
%	New York: Oxford University Press.
%
% Example: p = tonality(createnmat)
%
% Authors:
%  Date		Time	Prog	Note
% 9.9.2002	09:02	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

mode=keymode(nmat);

if mode ==1
	kk=refstat('kkmaj');
elseif mode ==2
	kk=refstat('kkmin');
else
	disp('Key mode not specified (major=1, minor=2)')
	kk=refstat('kkmaj');
	%return
end

pc0 = mod(nmat(:,4),12)+1;
p=kk(pc0)';
