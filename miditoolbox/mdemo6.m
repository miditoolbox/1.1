function nmat=mdemo6(input2)
%    ==========================================================
%    ANALYZING MIDI COLLECTIONS
%    ==========================================================
%    All functions in the MIDI Toolbox can be used in the analysis of large music collections. 
%    These collections can be in the form of MIDI files stored in hard disk or more compactly, 
%    as notematrices of MIDI files that have been stored as Matlab cell matrix structures.
%
%    LOAD A COLLECTION OF FINNISH FOLK TUNES
%    =================
%    In this example, we have a small sample (N=50) of Finnish Folk songs, from the 
%    Digital Collection of Finnish Folk Songs (Eerola & Toiviainen, 2004). 
%    First, we load all songs saved in a Matlab cell matrix:
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
load finfolktunes.mat % we get two variables, nm and names
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
%    Use ANALYZECOLL function to investigate properties of the collection
%    =================
%    Next we can investigate any property of the collection with a single command (ANALYZECOLL). 
%    For example, the following commands can be used to calculate the pitch-class profile 
%    of all songs in the collection (all songs have been transposed into C-major/c-minor).
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
	pcd = analyzecoll(nm,'pcdist1'); % 50 x 12 matrix
	meanpcd = mean(pcd,1); % collapsed into 12-comp. vector
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
subplot(2,1,1)
%
	plotdist(meanpcd,'b'); title('PC distr. in Finnish Folk tunes'); xlabel('');
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
% COMPARISON AND REFERENCE STATISTICS
%    =================
%    Compare with pitch-class distribution of the Finnish songs to the typical pitch-class
%    distribution in European folk songs (the Essen collection, 6000+ tunes, is used in comparison).
%    In order to compare the resulting distribution to a suitable existing reference distribution, 
%    one can use the REFSTAT function in the Toolbox.
%
subplot(2,1,2)
	plotdist(refstat('pcdist1essen'),'k'); title('PC distr. in Essen folk song collection')
%
p = input('Strike any key to continue or ''q'' to quit demo: ','s'); if strcmp(p,'q'); nmat=[]; return; end 
%
clf
