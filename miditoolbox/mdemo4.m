function nmat=mdemo4(input2)
%    ==========================================================
%    EXAMPLE 4: METER-FINDING
%    ==========================================================
%    One way of visualizing the possible meter of a notematrix is to display its note onset 
%    distribution in terms of the beat structure. This can be accomplished using the onsetdist 
%    function. Let us plot the onset distribution of the Bach’s Prelude using a resolution of four beats:
%
%    LOAD EXAMPLE MELODY
%    =================
%
	nmat=readmidi('laksin.mid');
%
%    INVESTIGATE THE ONSET DISTRIBUTION STRUCTURE
%    =================
%    of the tune using ONSETDIST function
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	onsetdist(nmat,3,1);
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    EXAMINE THE PROBABLE METER (beats in measure) (METER function)
%    =================
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	bestmeter=meter(nmat)
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%

%    DECONSTRUCT THE METER FUNCTION 
%    =================
%    This is done by showing the results of the autocorrelation 
%    of the onset structure:
%
	onsetacorr(nmat,4,1);
	text(2.93,0.64,'\bfPossible meter'); text(2.93,0.58,'\bf\downarrow');
%
%    The highest peak in the autocorrelation structure
%    is taken as the plausible meter candidate 
%    (note that the first two beats are ignored).
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    INVESTIGATE METRICAL HIERARCHY
%    =================
%    Plot Lerdahl & Jackendoff -type of metrical grid under the notation.
%    This operation uses PLOTHIERARCHY function that utilizes 
%    METRICHIERARCHY and METER functions.
%
subplot(2,1,1)
	pianoroll(nmat,'num','r','hold')
%
subplot(2,1,2)
	plothierarchy(nmat,'beat')
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
