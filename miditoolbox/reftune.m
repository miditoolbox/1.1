function nmat = reftune(name,dur)
% Obtain a 'reference' or example tune
% nmat = reftune('name',<dur>)
%
% Input arguments: NAME= any of the following strings:
%        dowling1 = Dowling (1973) tune 1
%        dowling2 = Dowling (1973) tune 2
%        int1-12 = Hartmann & Johnson (1991)  tune 1-12
%        probe = Sample probe sequence (demonstrated in the manual)
%        tritone = 12 random tritone intervals demonstrating the Tritone Paradox (Deutsch, 1991)
%        laksin = Two first phrases of a Finnish Folk Tune, "Läksin Minä Kesäyönä"
%        laksin_complete = See above, except this is the complete version (4 phrases)
% 			    DUR(optional) = duration of tones in target NAME tune
%
% Output: NMAT = the sequence as a notematrix
%
% References:
%       Dowling, W. J. (1973). The perception of interleaved melodies, 
%             Cognitive Psychology,5, 322-337.
%       Hartmann, W. M., & Johnson, D. (1991). Stream segregation and 
%              peripheral channeling. Music Perception, 9(2), 155-184.
%       Deutsch, D. (1991). The tritone paradox: An influence of language 
%              on music perception. Music Perception, 8, 335-347.
%       Repp, B. (1994). The tritone paradox and the pitch range of the 
%             speaking voice: A dubious connection. Music Perception, 12, 227-255.
%
% Authors:
%  Date		Time	Prog	Note
% 13.7.2003	10:49	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if ~ischar(name),
   fprintf(1,'??? reftune: Argument must be a string.\n')
   return;
end;
if nargin<2, dur=0.25; end

switch lower(name),
 case 'dowling1'
nmat = createnmat([55 60 60 62 64 60 64 62 55 ...
60 60 62 64 60 60 59 55 60 60 62 64 65 64 62 ...
60 59 55 57 59 60],dur);
 case 'dowling2'
nmat = createnmat([60 60 60 55 57 57 55 55 64 ...
64 62 62 60 60 60 60 60 55 57 57 55 55 64 64 ...
62 62 60 60 60 60],dur);


case {'int1','int2','int3','int4','int5','int6','int7','int8','int9','int10','int11','int12'}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following are the sequences in the interleaved melody identification 
% task described in Hartmann & Johnson (1991)
%
% The tunes were borrowed from M.A.D (Matlab Auditory Demonstrations),
% encoded by Martin Cooke, April 1998
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m =zeros(12,16);
m(1,:)=[65 67 69 65 65 67 69 65 69 70 72 72 69 70 72 72]; n(1,:)='Frere Jacques              ';
m(2,:)=[65 65 72 72 74 74 72 72 70 70 69 69 67 67 65 65]; n(2,:)='Twinkle twinkle little star';
m(3,:)=[73 69 71 69 66 69 64 69 73 69 71 69 66 69 64 69]; n(3,:)='Peter Peter pumpkin eater  ';
m(4,:)=[69 69 71 73 69 73 71 64 69 69 71 73 69 69 68 64]; n(4,:)='Yankee doodle              ';
m(5,:)=[68 68 68 68 70 70 70 70 72 73 75 68 67 68 70 63]; n(5,:)='Sur le pont d''Avignon      ';
m(6,:)=[66 66 73 73 71 69 68 66 64 66 68 69 71 73 73 73]; n(6,:)='god rest ye merry gentlemen';
m(7,:)=[66 67 68 67 66 67 68 68 66 66 68 70 71 75 75 75]; n(7,:)='Spartan fight song         ';
m(8,:)=[68 68 72 72 75 75 72 72 73 73 70 70 67 67 63 63]; n(8,:)='Surprise Symphony (Hadyn)  ';
m(9,:)=[61 66 66 65 66 70 70 68 73 73 73 71 70 68 70 70]; n(9,:)='Hark the herald angels sing';
m(10,:)=[70 70 71 73 73 71 70 68 66 66 68 70 70 68 68 68]; n(10,:)='Ode to joy (Beethoven 9th) ';
m(11,:)=[70 70 70 72 70 70 65 65 67 65 67 69 70 70 70 70]; n(11,:)='Good king Wenceslas        ';
m(12,:)=[64 64 69 71 73 73 73 74 66 66 71 71 64 64 68 69]; n(12,:)='Man on the flying trapeze  ';

nmat = createnmat([m(str2num(name(4:end)),:)],dur);

case 'probe'
IV = createnmat([65 69 72],0.5); 
IV = setvalues(IV,'onset',0);
V = shift(IV,'pitch',2); 
V = shift(V,'onset',0.75,'sec');
I = shift(V,'pitch',-7); 
I = shift(I,'onset',0.75,'sec');
probe = createnmat([61],0.5); 
probe = shift(probe,'onset', 3, 'sec');
sequence = [IV; V; I; probe];


case 'tritone'
% Tritone paradox 
% Deutsch (1991) studied how tones related by exactly a half-octave (tritone) 
% were judged by listeners. Participants judged whether each pair formed 
% an ascending or descending pattern. The following syntax creates the notematrix 
% of the stimuli but you need to synthesize and play it:
% For example:
%                    soundsc(shepardnmat(reftune('tritone')));

tone=randperm(12)'; % create a random order for pitch-classes (1-12)

for j = 1:12
  pair(j,:) = [tone(j) tone(j)+6];
end
pair=pair'; pair=pair(:); pair=pair'; % collapse into single vector
a = createnmat(pair,.5); % tones were 500 msec in duration (Deutsch, 1991, p. 340)
nmat = a; c = 0; % constant (interpair interval)
for i = 1:2:length(a)
   nmat(i:i+1,6) = a(i:i+1,6)+c; % modify interpair intervals
   c = c+2.5; % interpair intervals were 2.5 sec (Repp, 1994, p. 233)
end

case 'laksin'

nmat=[0 0.9000 1.0000 64.0000 82.0000 0 0.5510;
1.0000 0.9000 1.0000 71.0000 89.0000 0.6122 0.5510;
2.0000 0.4500 1.0000 71.0000 82.0000 1.2245 0.2755;
2.5000 0.4500 1.0000 69.0000 70.0000 1.5306 0.2755;
3.0000 0.4528 1.0000 67.0000 72.0000 1.8367 0.2772;
3.5000 0.4528 1.0000 66.0000 72.0000 2.1429 0.2772;
4.0000 0.9000 1.0000 64.0000 70.0000 2.4490 0.5510;
5.0000 0.9000 1.0000 66.0000 79.0000 3.0612 0.5510;
6.0000 0.9000 1.0000 67.0000 85.0000 3.6735 0.5510;
7.0000 1.7500 1.0000 66.0000 72.0000 4.2857 1.0714;
9.0000 0.4528 1.0000 64.0000 74.0000 5.5102 0.2772;
9.5000 0.4528 1.0000 67.0000 81.0000 5.8163 0.2772;
10.0000 0.9000 1.0000 71.0000 83.0000 6.1225 0.5510;
11.0000 0.4528 1.0000 71.0000 78.0000 6.7347 0.2772;
11.5000 0.4528 1.0000 69.0000 73.0000 7.0408 0.2772;
12.0000 0.4528 1.0000 67.0000 71.0000 7.3469 0.2772;
12.5000 0.4528 1.0000 66.0000 69.0000 7.6531 0.2772;
13.0000 0.4528 1.0000 67.0000 83.0000 7.9592 0.2772;
13.5000 0.4528 1.0000 66.0000 72.0000 8.2653 0.2772;
14.0000 0.4528 1.0000 64.0000 74.0000 8.5714 0.2772;
14.5000 0.4528 1.0000 63.0000 70.0000 8.8776 0.2772;
15.0000 0.9000 1.0000 64.0000 82.0000 9.1837 0.5510;
16.0000 1.8028 1.0000 64.0000 75.0000 9.7959 1.1037];

case 'laksin_complete'
nmat=[0 0.9 1 64 82 0 0.5510;
1 0.9 1 71 89 0.6122 0.5510;
2 0.4500 1 71 82 1.2245 0.2755;
2.5 0.4500 1 69 70 1.5306 0.2755;
3 0.4528 1 67 72 1.8367 0.2772;
3.5 0.4528 1 66 72 2.1429 0.2772;
4 0.9 1 64 70 2.4490 0.5510;
5 0.9 1 66 79 3.0612 0.5510;
6 0.9 1 67 85 3.6735 0.5510;
7 1.7500 1 66 72 4.2857 1.0714;
9 0.4528 1 64 74 5.5102 0.2772;
9.5 0.4528 1 67 81 5.8163 0.2772;
10 0.9 1 71 83 6.1225 0.5510;
11 0.4528 1 71 78 6.7347 0.2772;
11.5 0.4528 1 69 73 7.0408 0.2772;
12 0.4528 1 67 71 7.3469 0.2772;
12.5 0.4528 1 66 69 7.6531 0.2772;
13 0.4528 1 67 83 7.9592 0.2772;
13.5 0.4528 1 66 72 8.2653 0.2772;
14 0.4528 1 64 74 8.5714 0.2772;
14.5 0.4528 1 63 70 8.8776 0.2772;
15 0.9 1 64 82 9.1837 0.5510;
16 1.8028 1 64 75 9.7959 1.1037;
18 0.4531 1 67 85 9 0.2266;
18.5 0.4531 1 66 71 9.25 0.2266;
19 0.4531 1 64 74 9.5 0.2266;
19.5 0.4531 1 63 71 9.75 0.2266;
20 0.4531 1 64 82 10 0.2266;
20.5 0.4531 1 66 80 10.25 0.2266;
21 0.9023 1 67 84 10.5 0.4512;
22 1.8047 1 66 72 11 0.9023;
24 0.4531 1 67 83 12 0.2266;
24.5 0.4531 1 66 74 12.25 0.2266;
25 0.4531 1 64 76 12.5 0.2266;
25.5 0.4531 1 66 79 12.75 0.2266;
26 0.4531 1 67 82 13 0.2266;
26.5 0.4531 1 69 80 13.25 0.2266;
27 0.9023 1 71 84 13.5 0.4512;
28 1.8047 1 71 77 14 0.9023;
30 0.4531 1 64 63 15 0.2266;
30.5 0.4531 1 67 82 15.25 0.2266;
31 0.4531 1 71 85 15.5 0.2266;
31.5 0.4531 1 71 78 15.75 0.2266;
32 0.4531 1 71 78 16 0.2266;
32.5 0.4531 1 69 71 16.25 0.2266;
33 0.4531 1 67 73 16.5 0.2266;
33.5 0.4531 1 66 70 16.75 0.2266;
34 0.4531 1 67 82 17 0.2266;
34.5 0.4531 1 66 72 17.25 0.2266;
35 0.4531 1 64 74 17.5 0.2266;
35.5 0.4531 1 63 69 17.75 0.2266;
36 0.9023 1 64 81 18 0.4512;
37 1.8047 1 64 75 18.5 0.9023];

 otherwise
  disp('Unknown Example tune.')

end