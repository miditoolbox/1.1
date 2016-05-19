function D = duraccent(dur,tau,accent_index)
% Duration accent by Parncutt (1994)
% function D = duraccent(dur,<tau>,<accent_index>)
%
% Function returns duration accent of the events (Parncutt, 1994), p. 430-431
% where tau represents saturation duration (proportional to the duration of the echoic 
% store) and accent index that covers the minimum discriminable duration. The 
% difference between Parncutt's model and this implementation is on the IOI.
%
% Input arguments: 
%	DUR = vector of note duration in seconds
%	TAU (optional) = saturation duration (default 0.5)
%	ACCENT_INDEX (optional) = minimum discriminable duration (default 2)
%
% Output: 
%	D = new duration vector corresponding to the size of input vector
%
% Remarks: The original model uses IOI (Inter-onset-intervals) for input whereas 
% this version takes the note duration value in seconds.
%
% Example 1: plot duration accents with Parncutt's default parameters:
% 	d = 0:0.01:2;
%	D = duraccent(d);
%	plot(d,D); ylabel('durational accent'); xlabel('duration (secs)')
%
% Example 2: duracc = duraccent(dur(NMAT,'sec'));
%
% References: Parncutt, R. (1994). A perceptual model of pulse salience and metrical
%    accent in musical rhythms. Music Perception. 11(4), 409-464.
%
% Authors:
%  Date		Time	Prog	Note
% 12.2.2003	15:50	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt
if nargin < 3; tau=0.5; end
if nargin < 2; accent_index=2; end

D = (1-exp(-dur/tau)).^accent_index; % duration weigth
