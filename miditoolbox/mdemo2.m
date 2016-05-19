function nmat=mdemo2(input2)
%    ==========================================================
%    EXAMPLE 2: MELODIC CONTOUR
%    ==========================================================
%
%    The second example involves calculating melodic contour from a
%    monophonic notematrix. Melodic contour describes the overall shape of
%    the melody. The contour representation of a melody is usually easier to
%    remember than exact interval information and several music
%    informational retrieval systems use contour to find specific melodies from
%    large music databases.
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    LOAD EXAMPLE MELODY
%    =================
%
	nmat=readmidi('laksin.mid');
%
%    PLOT MELODIC CONTOUR
%    =================
%
%    In this demonstration, the melodic contour is shown using different
%    degrees of resolution. The degree of resolution depends upon the 
%    value of the sampling step, expressed in MIDI beats. 
%    The larger the resolution, the more coarse the contour. 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
subplot(2,1,1)
	plotmelcontour(nmat,0.1,'abs',':r.'); hold on
	plotmelcontour(nmat,1,'abs','-bo'); hold off
	legend(['res. in beats=0.1'; 'res. in beats=1.0']);
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    PLOT CONTOUR SELF-SIMILARITY
%    =================
%
%    One application of the melodic contour is finding out whether the sequence
%    contains repeated melodic phrases. This can be done using an 
%    autocorrelation technique (Eerola et al., submitted). The autocorrelation 
%    function of a time series is obtained by correlating the series with a delayed 
%    copy of itself, using delay values ranging from -L to +L, where L denotes 
%    the total length of the time series. A time series is autocorrelated if it is 
%    possible to predict its value at a given point of time by knowing its value 
%    at other points of time. 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
subplot(2,1,2)
	plotmelcontour(nmat,.5,'g','ac');
%
%    See Manual for a closer explanation of the autocorrelation of the melodic contour.
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
