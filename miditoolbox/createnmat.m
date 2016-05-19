function nmat = createnmat(notes,dur,vel,ch)
% Create isochronous notematrix
% nmat = createnmat(notes,<dur>,<vel>,<ch>);
% Function creates a notematrix of isochronous pitches based on the NOTES vector. 
% This is useful for demonstration purposes and for creating stimuli with certain properties.
%
% Input arguments:
%	NOTES = pitch vector (e.g. [ 60 64 67] for C major chord)
%	DUR (optional) = note durations in seconds (default 0.25)
%	VEL (optional) = note velocities (0-127, default 100)
%	CH (optional) = note channel (default 1)
%
% Output:
%	NMAT = notematrix
%
% Remarks: only the NOTES vector is required for the input, other input arguments are 
% optional and will be replaced by default values if omitted. 
%
% Example: Create major scale going up
%   major = [0 2 4 5 7 9 11 12] + 60;
%   nmat = create_nmat(major,0.2,127,1);
%
% Authors:
%  Date		Time	Prog	Note
% 26.1.2003	18:44	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if nargin<1, notes=[0 2 4 5 7 9 11 12] + 60; end; % if no arguments at all, create major scale
if nargin<2, dur=0.25;end;
if nargin<3, vel=100;end;
if nargin<4, ch=1; end;

% DEFAULT
if ~isempty(notes)
	if isempty(dur), dur=0.25; end
	if isempty(vel), vel=100; end
	if isempty(ch), ch=1; end

% Pitches
notenro = size(notes,2);
% Durations
dur_t = repmat(dur,notenro,1);
% Velocities
vel_t = repmat(vel,notenro,1);
% Channel
ch_t = repmat(ch,notenro,1);

		onset=zeros(1,notenro)';
	for i = 2:notenro
		onset(i) = onset(i-1)+dur_t(i-1);
	end

dur_t = repmat(dur,notenro,1);
notes = notes';

onsetb = onset * 1.666666;
dur_tb = dur_t * 1.666666;

% onset(beats)	dur(beats)	ch	pitch	velocity	onset(secs)	dur(secs)

nmat = [onsetb dur_tb ch_t notes vel_t onset dur_t]; 

else
disp('Notes needed!')
end
