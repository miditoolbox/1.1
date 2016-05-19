function nmat=mdemo7(input2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% EXAMPLE 7: CREATING SEQUENCES
% The Toolbox may be used to create melodies and chord sequences that 
% can, in turn, be saved as MIDI or synthesized audio files. For example, 
% to recreate the chord context version of the well-known probe-tone sequences 
% (Krumhansl & Kessler, 1982), use CREATENMAT function.
%
%
%    CREATE A PROBE-TONE SEQUENCE
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
IV = createnmat([65 69 72],0.5); 
IV = setvalues(IV,'onset',0);
V = shift(IV,'pitch',2); 
V = shift(V,'onset',0.75,'sec');
I = shift(V,'pitch',-7); 
I = shift(I,'onset',0.75,'sec');
probe = createnmat(61,0.5); 
probe = shift(probe,'onset', 3, 'sec');
sequence = [IV; V; I; probe];
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    CREATE A PIANOROLL OF THE SEQUENCE
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	pianoroll(sequence)
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    SYNTHESIZE THE SEQUENCE
%    =================
%    To synthesize the sequence using Shepard tones, which de-emphasize 
%    pitch height and underline pitch-class, use the NMAT2SND function. The 
%    following creates the probe sequence as a CD-quality audio file using the 
%    Shepard tones:
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	signal = nmat2snd(sequence,'shepard',44100); % 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    PLOT THE AUDIO SIGNAL
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	plot(signal) % create a plot of the signal
	l=length(signal);
	ylabel('Amplitude'); xlabel('Time (in s)') % labels
	set(gca,'XTick',(0:22050:l))
	set(gca,'XTickLabel',(0:22050:l)/44100) % in seconds
%
%    PLAY THE SIGNAL
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	soundsc(signal,44100); % play the synthesized sequence
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    ==========================================================
%    AUDITORY DEMONSTRATIONS
%    ==========================================================
%
%    SHEPARD ILLUSION
%    =================
%    Shepard tones are ambiguous in terms of their pitch height although their 
%    pitch-class or pitch chroma can be discerned. When 12 chromatic tones are 
%    played in ascending order over and over again, an illusion of a continuous 
%    ascending pitch sequence will form although the point at which the sequence 
%    starts over is not perceived. 
%
%   To demonstrate this so-called Shepard illusion (Shepard, 1964), where a scale 
%   consisting of semitones is played over four octaves using Shepard tones, type:
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	playsound(createnmat(48:96,.5),'shepard');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%

%    TRITONE PARADOX
%    =================
%    Hearing pairs of tones in succession will form a perception of an 
%    ascending or a descending interval. When tritone intervals (e.g., C-F#) 
%    are played using Shepard tones, the direction of the interval is ambiguous. 
%    Sometimes listeners hear certain tritones as ascending and sometimes
%    descending. More information on the tritone paradox, see Deutsch (1991) 
%    or Repp (1994).
%    To listen to the tritone paradox, type:
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	playsound(reftune('tritone'),'shepard');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    INTERLEAVED MELODIES
%    =================
%    Perception of interleaved melodies provides another example of melody creation. 
%    In interleaved melodies, successive notes of the two different melodies are 
%    interleaved so that the first note of the first melody is followed by the first note 
%    of second melody, followed by the second note of the first melody followed by 
%    the second note of the second melody and so on. Using these kinds of melodies 
%    in perceptual experiments, Dowling (1973; and later Hartmann & Johnson, 1991) 
%    has observed that listeners’ ability to recognize the melodies is highly sensitive to 
%    the pitch overlap of the two melodies. When the melodies are transposed so that 
%    their mean pitches are different, recognition scores increase. 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
d1 = reftune('dowling1',0.4);
d2 = reftune('dowling2',0.4);
%
d2=shift(d2,'onset',+.2,'sec'); % introduce a delay (0.2 sec)
d2=shift(d2,'dur',-.2,'sec'); % shorten the notes
d1=shift(d1,'dur',-.2,'sec'); % shorten the notes
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
playsound([d1; d2]); pause % 0 semitone difference
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
playsound([d1;shift(d2,'pitch',-3)]); pause % 3 semitones difference
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
playsound([d1;shift(d2,'pitch',6)]); pause % 6 semitones difference
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
playsound([d1;shift(d2,'pitch',-9)]); % 9 semitones difference
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
