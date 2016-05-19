function nmat = mdemo8(input2)
%    ==========================================================
%    EXAMPLE 8: MELODIC SIMILARITY
%    ==========================================================
%    The meldistance function provides a versatile method for making comparisons between
%    melodies. Although pairs of melodies can be tested for degree of similarity, 
%    the function is often more usefully applied to melodic collections.
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    LOAD A COLLECTION OF FINNISH FOLK TUNES
%    =================
%
    load finfolktunes.mat % we get two variables, nm and names
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    EXAMPLE OF PAIR-WISE DISTANCE
%    =================
%    Calculate the distance between the first and 
%    second melodies in our collection using a contour representation and 
%    the taxi-cab distance measure.
%
    meldistance(nm{1},nm{2},'contour','taxi')
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    BUILD A RANKED LIST OF SIMILARITY TO A GIVEN MELODY
%    =================
%    MELDISTANCE can also be used to provide a ranked list of the three melodies which
%    begin most similarly to a given melody. First we load an example.
%
    laksin=reftune('laksin');
    l2 = trim(onsetwindow(laksin,-1,8,'beat'));
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    Next we use meldistance to generate a list of distance comparisons between 
%    laksin and each of the 50 melodies in our collection. BRACE YOURSELF!
%
    for i=1:length(nm)
        sim_ratings(i)=meldistance(l2,trim(onsetwindow(nm{i},-1,8)),'contour','taxi');
    end
%
    sim_ratings =[1:50; sim_ratings]';
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%   This list is then sorted by ranking and the three entries with lowest 
%    pair-wise distance selected
%
sorted=sortrows(sim_ratings,2);
ranked=sorted(1:3,:)
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    Plot the first 8 beats Laksin followed by the 
%    three top rated melodies
%
subplot(4,1,1)
	plotmelcontour(trim(onsetwindow(laksin,0,8)),.5,'abs',':kp'); m=axis; minim=m(3); xlabel(''); 
	text(.5,minim+2,'Läksin Minä Kesäyönä');
subplot(4,1,2)
	plotmelcontour(trim(onsetwindow(nm{ranked(1,1)},0,8))); m=axis; minim=m(3); xlabel('');
	text(.5,minim+2,[name(ranked(1,1),:) lyric(ranked(1,1),:)]);
subplot(4,1,3)
	plotmelcontour(trim(onsetwindow(nm{ranked(2,1)},0,8))); m=axis; minim=m(3); xlabel('');
	text(.5,minim+2,[name(ranked(2,1),:) lyric(ranked(2,1),:)]); 
subplot(4,1,4)
	plotmelcontour(trim(onsetwindow(nm{ranked(3,1)},0,8))); m=axis; minim=m(3);
	text(.5,minim+2,[name(ranked(3,1),:) lyric(ranked(3,1),:)]); 
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%

%    BUILD RANKED LIST USING A STATISTICAL REPRESENTATION
%    =================
%    We can also build a ranked list of similarity using a statistical 
%    distribution rather than contour.
%    we use meldistance to generate a list of distance comparisons between 
%    laksin and each of the 50 melodies in our collection. BRACE YOURSELF!
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
clear sim_ratings sorted ranked;
%
    for i=1:length(nm)
        sim_ratings(i)=meldistance(l2,trim(onsetwindow(nm{i},-1,8)),'pcdist1','taxi');
    end
    sim_ratings =[1:50; sim_ratings]';
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    This list is then sorted by ranking and the three entries with lowest 
%    pair-wise distance selected
%
sorted=sortrows(sim_ratings,2);
ranked=sorted(1:3,:)
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    Plot the first 8 beats Laksin followed by the 
%    three top rated melodies
%
subplot(4,1,1)
plotmelcontour(trim(onsetwindow(laksin,-1,8)))
title('laksin')
subplot(4,1,2)
plotmelcontour(trim(onsetwindow(nm{ranked(1,1)},-1,8)))
subplot(4,1,3)
plotmelcontour(trim(onsetwindow(nm{ranked(2,1)},-1,8)))
subplot(4,1,4)
plotmelcontour(trim(onsetwindow(nm{ranked(3,1)},-1,8)))
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    The contours of these melodies are not so similar, but how about 
%    their pitch-class distributions?
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
subplot(4,1,1)
plotdist(pcdist1((trim(onsetwindow(laksin,-1,8))))); ylabel('')
title('laksin')
subplot(4,1,2)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(1,1)},-1,8)))))
subplot(4,1,3)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(2,1)},-1,8))))); ylabel('')
subplot(4,1,4)
plotdist(pcdist1((trim(onsetwindow(nm{ranked(3,1)},-1,8))))); ylabel('')
%
%    It appears that all of the chosen melodies are in the same key and
%    contain very similar pitch content.
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 