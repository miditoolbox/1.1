function [nmat_e,coverage] = elim(nmat,extent_crit)
% Elimination of "short" midi tracks
% [nmat_e,coverage] = elim(nmat,<extent_crit>)
% Eliminates tracks shorter than EXTENT_CRIT from NMAT.
% Short tracks are those that are shorter 
% than EXTENT_CRIT as percentage of the whole duration. 
%
% Input arguments: 
%	NMAT = notematrix
%	EXTENT_CRIT (optional) = minimum proportion of duration that is 
%	required for the track (default value is 0.5, that is, 50% coverage)
%
% Output: 
%	NMAT_E = new, eliminated notematrix
%	COVERAGE = the proportion of onsets in track
%
% Remarks: This function is used in removing the drum tracks from MIDI file
% but this function is under construction. 
%
% Example: Eliminate those tracks that have onsets covering 
%	less than 50% of the whole duration:
% 	nmat2 =elim(nmat,0.5);
%
% Authors:
%  Date		Time	Prog	Note
% 28.12.2002	0:06	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

if nargin<2, extent_crit=0.5; end; % default value

duration= onset(nmat(end,:),'sec'); % duration of the song

% number of tracks
nch = channel(nmat);
hist_nch= hist(nch,1:25);
channel_index = find(hist_nch);
channel_nro = length(channel_index);

% for each track
for i=1:channel_nro
	
	nmat_i = channel(nmat==channel_index(i));
	nmatf=nmat(nmat_i,:);
		onset_f=onset(nmatf,'sec');
		multiplier=100/duration;
		cats=multiplier*duration;
		timeline=1:cats+1;
		onset2=onset_f*multiplier;
		timeline2=timeline(floor(onset2)+1);
		timeline3=hist(timeline2,1:100);
		onset_on_song(i)=(length(find(timeline3)))/100;

end
%nmat_e = nmat((channel(nmat==onset_on_song(2)>0.5)),:);

nmat_e2 = onset_on_song>extent_crit;
nmat_e3= channel_index(nmat_e2);

for j=1:length(nmat_e3)
	nmat_e4(:,j) = channel(nmat==nmat_e3(j));
end
for k=1:length(nmat_e4)
	b(k)=any(nmat_e4(k,:));
end

nmat_e = nmat(b,:);
coverage=onset_on_song;
