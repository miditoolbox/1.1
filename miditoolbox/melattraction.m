function m = melattraction(nmat)
% Melodic attraction according to Lerdahl (1996)
% m = melattraction(nmat)
% Calculates melodic attraction according to Fred Lerdahl (1996, p. 343-349):
%   Each tone in key has certain anchoring strength ("weight") in tonal pitch space
%   Melodic attraction strength is note2/note1 in a two-note window, which is
%   affected by the distance between tones.
%
%   The algorithm has two extensions:
%   Extension 1: attraction is modified not only by subsequent neighbor but also 
%	on the pitch's other neighbors (this is realized in the way Lerdahl suggested,
%     not only limiting the attraction to one neighbor but to all possible neighbors).
%   Extension 2: directed motion also affects melodic attraction (this is done somewhat
%     differently than in Lerdahl's paper due to modification of the first extension).
%
% Remarks: 
%   The output has been scaled to fit between 0 and 1, larger value 
%      indicating higher melodic attraction. Also, the key and the mode needs to be inferred
%      in order to apply correct tonal pitch space values.
%
% Input arguments: 
%	NMAT = notematrix
%
% Output: 
%	M = Melodic attraction values for each note in the NMAT (between 0-1)
%
% Example:
%	melattraction(reftune('laksin'));
%
% Reference:
%       Lerdahl, F. (1996). Calculating tonal tension. Music Perception, 13(3), 319-363.
%
% Change History :
% Date		Time	Prog	Note
% 25.4.2004	22:48	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); m=[]; return; end

nmat=transpose2c(nmat); % transpose to C / c

% needs to know the key and mode (major or minor)

%---------------------> anchoring weights for each PC <-----------------------
mode=keymode(nmat);
if mode==1
	anchorweights=[4,1,2,1,3,2,1,3,1,2,1,2]; % MAJOR
else
	anchorweights=[4,1,2,3,1,2,1,3,2,2,1,2]; % MINOR (natural with raised leading), 
end

pc0 = mod(nmat(:,4),12)+1;
pc_aw=anchorweights(pc0);
pc=pitch(nmat);  % 

%---------------------> DIRECTED MOTION INDEX: <-----------------------
%    (change of dir = -1, repetition=0, cont. same di. = 1)
	d=sign(diff(pitch(nmat)));
	m1=[0; (1-[abs(sign(diff(sign(sign(diff(pitch(nmat)))))))])*2-1];
	m2zero=d==0; motion=m1; motion(m2zero)=0;

%---------------------> ATTRACTION <-----------------------
prox = [0 abs(diff(pitch(nmat)))'];  % pitch proximity

%---------------------> EXTENSION 1: attraction of the other consonant neighbors <-----------------------
for i=1:length(pc_aw)-1
	if pc_aw(i)>pc_aw(i+1)
		sd1(i)=0;
	elseif pc_aw(i)==pc_aw(i+1)
		sd1(i)=0;
	else
		sd1(i)=stabilitydistance(pc_aw(i),pc_aw(i+1),prox(i+1));
	end

	%---------------------> OTHER CANDIDATES
	neighbor0 = pc0(i+0)-1; % This could alternatively be attracted to somewhere else
	neighbor1=(neighbor0+[1:9])-5; % other candidates
	neighbor2=mod(neighbor1,12)+1;
	neighbor3=anchorweights(neighbor2); % set anchor values

	%---------------------> ELIMINATE CORRECT CONTINUATION FROM THE LIST OF CANDIDATES

	eliminate_correct_cont=pc(i+1)-pc(i)+5;
		if eliminate_correct_cont>8
			eliminate_correct_cont=[];
		elseif eliminate_correct_cont<1
			eliminate_correct_cont=[];
		else 
			% do nothing
		end
	%---------------------> CHOOSE ONLY MORE STABLE CANDIDATES
	n1=(pc_aw(1)<neighbor3);
	n1(5)=0;
	%---------------------> CHECK THE REMAINING CANDIDATES
	if sum(n1)==0	% if all candidates lower, then skip over
		alternative_anchor=0; alternative_anchor_distance=0; sd2(i)=0;
	else

		%---------------------> REMOVE THE CORRECT CONT. --- START
		if isempty(eliminate_correct_cont)
		% do nothing if empty
		else
			if find(n1)==eliminate_correct_cont  % HERE CORRECT CONT. IS REMOVED
				% do nothing
			else
				n1(eliminate_correct_cont)=0;
				n1(5)=0; % remove also the starting tone
			end
		end
		%---------------------> REMOVE THE CORRECT CONT. ---- END
		more_stable_tones=(n1.*neighbor3);
		eligible_stable_tones=more_stable_tones(more_stable_tones>0);
		eligible_stable_tones_index=find(more_stable_tones);

		%---------------------> PROCESS ALL MORE STABLE TONES (as suggested by Lerdahl but not shown)
		for j=1:length(more_stable_tones(more_stable_tones>0))
			alternative_anchor(j)=eligible_stable_tones(j);
			alternative_anchor_distance(j)=eligible_stable_tones_index(j)-5;
			alternative_anchor_distance(j)=abs(alternative_anchor_distance(j));
			sd2b(j)=stabilitydistance(pc_aw(i),alternative_anchor(j),alternative_anchor_distance(j));
		end

		%---------------------> ATTRACTION TO OTHER TONES
		% IF THERE ARE MORE THAN ONE CANDIDATE, TAKE THE 
		% SUM OF THE MAX AND THE HALF OF THE OTHER VALUES
		
		if length(sd2b)>1
			sd2(i)=sum(((1-(max(sd2b)==sd2b)).*.5).*sd2b)+max(sd2b);
		else
			sd2(i)=sd2b(j);	
		end
	end

	%---------------------> EXTENSION 2: directed motion <-----------------------
	anchoring(i)=sd1(i)-sd2(i);
	dd1(i)=motion(i)+anchoring(i);  % This is not how Lerdahl suggested but...
end   

%---------------------> SCALE THE RESULTS BETWEEN 0 and 1
%    raw values range mainly between 5 and -1 so
dd1=(dd1+1)/5;
dd1(find(dd1<0))=0; dd1(find(dd1>1))=1;  % bring those which exceed the scaled values between 0 and 1
m=[0 dd1]';


%%%%%%%% SUBFUNCTION %%%%%%%%%%%%%%%%%
function sd=stabilitydistance(bspace1,bspace2,prox)
% sd=stabilitydistance(bspace1,bspace2,prox)
% Calculate the stability of anchoring given two pitch-space values and their distance in semitones
sd = (bspace2./bspace1).*(1./(prox^2)); % relative stability & distance
