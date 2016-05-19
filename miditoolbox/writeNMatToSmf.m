function debugMat = writeNMatToSmf(midMat, filename, tempo, tpqn)
% writeNMatToSmf(midMat,filename, [tempo], [tpqn])
%
% Takes an nmat and writes to a midi file
% 
% Uses utility functions from Ken Schutte
% http://www.kenschutte.com/midi

%default tempo and tpqn (ticks per quarter note)
if (nargin<3)
    tempo = 120;
    tpqn = 480;
elseif (nargin<4)
    tpqn = 480;
end


tmp_array = midMat(:, 6) +   midMat(:, 7); %compute note_off times
note_off_rows = [tmp_array 144*ones(length(tmp_array) ,1) midMat(:, 3:5)]; %this and the next row creates note off with note on message of 0 velocity
note_off_rows(:, 5) = 0; %zero velocity
midMat(:, 2) = 144; %note on indication, replaces duration in beats column
midMat(:, 1) = midMat(:, 6); % replace onset beats with onset seconds
eventsMat = [midMat(:, 1:5); note_off_rows];

%each row is midi note on/off event, collapse message type with channel
%(one byte in binary message)
eventsMat(:, 2) = eventsMat(:, 2) +  eventsMat(:, 3);
eventsMat(:, 3) = [];

%sort by onset time in beats, then by velocity, so that the same note
%on the same channel is turned off prior to next note_on message
eventsMat = sortrows(eventsMat, [1 4]);

%convert beats into deltatimes
eventsMat(:,1) = round((eventsMat(:, 1) - [0; eventsMat(1:end-1, 1)])/60 * tempo * tpqn);

debugMat = eventsMat;


%make the first event the tempo setting
tempo_data = encode_int((floor((60/tempo)*1e6)), 3); %beat/quarter note duration in microseconds, in 24-bits/3bytes
databytes_track = [0; encode_meta_msg(hex2dec('51'), tempo_data')]; 

[num_events, ~] = size(eventsMat);
for j=1:num_events %loop required because delta times can be a variable number of bytes
    
    %append delta time and note message to the previous track data
    databytes_track = [databytes_track; encode_var_length(eventsMat(j, 1)); eventsMat(j, 2:4)'];
    
end


% HEADER
% double('MThd') = [77 84 104 100]
rawbytes = [77 84 104 100 ... %Chuck string (4 bytes)
	    0 0 0 6 ...         %Chunk length (4 bytes)
	    encode_int(0,2) ... % SMF format, type 0 (2 bytes)
	    encode_int(1,2) ... % num tracks, 1 track(2 bytes)
	    encode_int(tpqn,2) ... %ticks per quarter note (2 bytes)
	   ]';

% TRACK_CHUNK
% double('MTrk') = [77 84 114 107]
  tmp = [77 84 114 107 ...
	 encode_int(length(databytes_track),4) ...
	 databytes_track']';
  rawbytes(end+1:end+length(tmp)) = tmp;


% write to file
fid = fopen(filename,'w');
fwrite(fid,rawbytes,'uint8');
fclose(fid);

%% Utility Functions
% return a _column_ vector
function A=encode_int(val,Nbytes)

for i=1:Nbytes
  A(i) = bitand(bitshift(val, -8*(Nbytes-i)), 255);
end


function bytes=encode_var_length(val)

% What should be done for fractional deltatime values?
% Need to do this round() before anything else, including
%  that first check for val<128 (or results in bug for some fractional values).
% Probably should do rounding elsewhere and require
% this function to take an integer.
val = round(val);

if val<128 % covers 99% cases!
    bytes = val;
    return
end
binStr = dec2base(round(val),2);
Nbytes = ceil(length(binStr)/7);
binStr = ['00000000' binStr];
bytes = [];
for i=1:Nbytes
  if (i==1)
    lastbit = '0';
  else
    lastbit = '1';
  end
  B = bin2dec([lastbit binStr(end-i*7+1:end-(i-1)*7)]);
  bytes = [B; bytes];
end

function bytes=encode_meta_msg(type, data)

bytes = 255;
bytes = [bytes; type];
bytes = [bytes; encode_var_length(length(data))];
bytes = [bytes; data];