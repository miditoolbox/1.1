function playsound(nmat,synthtype,fs)
% Play NMAT using a simple synthesis
% playsound(nmat,<synthtype>,<fs>)
% Create waveform of NMAT using a simple FM synthesis. The default sampling rate is 
% 8192 Hz and velocities are scaled to have
% a max value of 1 before passing to the fm_synth function.
%
% Input argument:
%	NMAT = notematrix
%     SYNTHTYPE (Optional) = Synthesis type, either FM synthesis ('fm', default) 
%           or Shepard tones ('shepard')
%     FS (optional) = sampling rate (default 8192)
%
% Output:
%	none (played through SOUNDSC)
%
% Example: playsound(laksin);
% Example: playsound(laksin,'shepard', 22050);
%
% Change History :
% Date		Time	Prog	Note
% 15.4.2004	14:27	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<3, fs=8192; end
if nargin<2, synthtype='fm'; end

soundsc(nmat2snd(nmat,synthtype,fs),fs);
