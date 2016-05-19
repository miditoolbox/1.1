function name=keyname(n,detail)
% Conversion of key numbers to key names (text)
% name=keyname(n,<detail>)
% Convert key numbers to key names (text)
% encoding: 1 = C, 2= C#/Db, ...
%           13 = c, 14 = c#/db, ...
%
% Input argument: 
%	N = key codes (obtained eg. using KKKEY function)
%	DETAIL (optional) = 1=long, missing = short
%
% Output: text string
%
% Remarks:
%
% Example:
%
%	Change History :
% 	Date		Time	Prog	Note
% 30.9.2003	20:25	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if nargin<2, detail=1; end

if detail==1
	namemajor = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
	nameminor = {'c','c#','d','d#','e','f','f#','g','g#','a','a#','b'};
	else
	namemajor = {'C','C#/Db','D','D#/Eb','E','F','F#/Gb','G','G#/Ab','A','A#/Bb','B'};
	nameminor = {'c','c#/db','d','d#/eb','e','f','f#/gb','g','g#/ab','a','a#/bb','b'};

end

for i=1:length(n)
	if n(i) < 13
		name(i) = namemajor(n(i)); % MAJOR
	elseif n(i) >= 13
		name(i) = nameminor(n(i)-12); % MINOR
	end
end
