function nmat=mdemo1(input2)
%    ==========================================================
%    EXAMPLE 1: VISUALIZING AND PLAYING MIDI DATA
%    ==========================================================
%    The first aim of this demonstration is to show how to read midi files into 
%    matlab and give some examples of how to visualize and listen to the resulting notematrix.
%    The second aim is to introduce simple manipulations that can be performed to the 
%    notematrix, ranging from transposition to elimination of certain parts of the notematrix. 
%    Finally, certain distributions of the example tune are visualized.
%
%    READ A MIDI FILE TO MATLAB (A FINNISH FOLK TUNE):
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end
%
	laksin=readmidi('laksin.mid');
%
%    PLOT THE FILE USING PIANOROLL NOTATION
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end
%
	pianoroll(laksin,'b');
%
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%    SYNTHESIZE MIDI FILE TO AUDIO AND PLAY THE RESULTING SIGNAL
%    =================
%
	playsound(settempo(laksin,120));
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%

%    ==========================================================
%    SIMPLE MANIPULATION OF A MIDI FILE (NMAT)
%    ==========================================================
%
%    HIGHLIGHT LONG DURATIONS IN THE PIANOROLL (DROPSHORTNOTES function)
%    =================
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	nmat2 = dropshortnotes(laksin,'beat',1);
	pianoroll(nmat2,'name','r','hold');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    SELECT EVENTS BETWEEN 8 AND 17 BEATS (ONSETWINDOW function)
%    =================
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	laksin_phrase = onsetwindow(laksin,8,17,'beat');
	pianoroll(laksin_phrase,'name','k','hold');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    HALVE THE DURATION OF THE NOTES IN THE SEGMENT (SCALE function)
%    =================
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	laksin_shortened = scale(laksin_phrase,'dur',.5);
	pianoroll(laksin_shortened,'name','y','hold');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    TRANSPOSE THE SEGMENT A MINOR THIRD DOWN (TRANS function)
%    =================
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	laksin_transposed = shift(laksin_shortened,'pitch',-4);
	pianoroll(laksin_transposed,'name','beat','m','hold');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    PLOT ONLY THE SELECTED SEGMENT (TRIM function)
%    =================
%
	pianoroll(trim(laksin_transposed),'name','beat','m');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
clf
clc
%

%    ==========================================================
%    PLOT FEW DISTRIBUTIONS OF THE EXAMPLE MELODY
%    ==========================================================
 
%    Pitch-class distributions
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
	plotdist(pcdist1(laksin),'g');
%
%    Interval distributions
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
	plotdist(ivdist1(laksin),'y');
%
%    Pitch-class transition distributions
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
	plotdist(pcdist2(laksin),'hot');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
clf
clc
%
%    ==========================================================
%    MANIPULATE POLYPHONIC MIDI FILE
%    ==========================================================
%
%    READ A NEW MIDI FILE TO MATLAB (A BACH EXAMPLE):
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	prelude=readmidi('wtcii01a.mid');
	prelude=onsetwindow(prelude,0,8,'beat');
	pianoroll(prelude,'num','beat','k','hold'); 
%

p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    QUANTIZE AND SELECT ONLY UPPER VOICE
%    =================
%
%    Quantize the prelude using sixteenth note resolution
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	prelude_edited = quantize(prelude, 1/16,1/16,1/16);
	pianoroll(prelude_edited,'num','m','hold'); 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    SELECT ONLY THE UPPER VOICE AND PLOT IT
%    =================
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	prelude_edited = extreme(prelude_edited,'high');
	pianoroll(prelude_edited,'num','g','hold'); 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
