%% mdlMStrToNMat
%  From code written by Ken Schutte
%  see http://www.kenschutte.com/midi for example
%
%  Modified by Ed Large and M. Stauffer to return note list
%  in the Midi Toolbox 'nmat' format, with these columns
%  for each note:
%   Onset (beats) (calc'ed solely from ticks-per-quarter-note)
%   Duration beats
%   Channel
%   MIDI pitch
%   mIdI velocity
%   Onset (sec)
%   Duration (sec)
%  
%  NOTE
%  This routine will NOT skip silence at begin of the midi file, as it
%  appears happens in matlab-midi's midiInfo. If the first note-on
%  in the file is not at tick 0, it will be converted to a non-zero
%  onset beat and time.
%
%  Usage:
%
%  nmat = midi2nmat(midi)
%  Where 'midi' is a matlab-midi structure as returned by readmidi.

%%
function nmat = mdlMStrToNMat(midi)



%% find tempo changes
tempos = [];
tempos_time = [];
for i=1:length(midi.track)
  cumtime=0;
  for j=1:length(midi.track(i).messages)
    cumtime = cumtime+midi.track(i).messages(j).deltatime;
    if (midi.track(i).messages(j).midimeta==0 && midi.track(i).messages(j).type==81)      
      tempos_time(end+1) = cumtime; %#ok<AGROW>
      d = midi.track(i).messages(j).data;
      tempos(end+1) =  d(1)*16^4 + d(2)*16^2 + d(3); %#ok<AGROW>
    end
  end
end

%initialize output
nmat = zeros(1,7);

%% Enter MIDI data into nmat matrices
current_tempo = 500000;  % default tempo
for i=1:length(midi.track)
  cumtime=0;
  seconds=0;
  for j=1:length(midi.track(i).messages)

    deltatime = midi.track(i).messages(j).deltatime;
    chan      = midi.track(i).messages(j).chan;
    data      = midi.track(i).messages(j).data;
    type      = midi.track(i).messages(j).type;
    midimeta  = midi.track(i).messages(j).midimeta;
    
    cumtime = cumtime + deltatime;
    beat = cumtime / midi.ticks_per_quarter_note;
    seconds = seconds + deltatime*1e-6*current_tempo/midi.ticks_per_quarter_note;
        %MGS Possibly rounding errors here with long sequences? 
        %Should instead calc delta-seconds from start in seconds of current tempo?
        
    %Tempo change?
    if ~isempty(tempos)                              % fix suggested by Andy Milne 2 June 2016
        [mx ind] = max(find(cumtime >= tempos_time));
        current_tempo = tempos(ind);
    end
    % find start/stop of notes:
    % note on with vel>0:
    if (midimeta==1 && type==144 && data(2)>0)

      %NMAT column format from 'midi toolbox' 
      nmat(end+1,1) = beat; % Onset (beats) 
      nmat(end,2) = -1;     % Duration (beats)
      nmat(end,3) = chan;   % Channel
      nmat(end,4) = data(1);% MIDI Pitch
      nmat(end,5) = data(2);% MIDI Velocity
      nmat(end,6) = seconds;% Onset (sec)
      nmat(end,7) = -1;     % Duration (sec) 

    elseif (midimeta==1 && ( (type==144 && data(2)==0) || type==128 ))
      %note-off
      
      %find matching note-on to update its values
      ind = find((...
        (nmat(:,3)==chan) + ...
        (nmat(:,4)==data(1)) + ...
        (nmat(:,2)==-1)...   %i.e., hasn't been matched yet
        )==3);

      if (length(ind)==0)
        warning('note-off with no matching note-on. skipping.');
      elseif (length(ind)>1)
       	%??? not sure about this...
        disp('warning: found multiple note-on matches for note-off, taking first...'); % Disabled by TE 9 May 2016, , brought back as suggested by Andy Mile 2 June 2016
        ind = ind(1); % Disabled by TE 9 May 2016, brought back as suggested by Andy Mile 2 June 2016
      else
        %set duration values
        nmat(ind,2) = beat - nmat(ind,1);
        nmat(ind,7) = seconds - nmat(ind,6);
      end
    end
  end %track
end %all tracks

%check for unmatched note-ons
if any(nmat == -1)
    warning('one or more unmatched note-ons');
end

%remove init row
nmat = nmat(2:end,:);
