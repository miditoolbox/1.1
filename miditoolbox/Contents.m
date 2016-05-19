% MIDItoolbox
% Version 1.1 18-May-2016
% 
% A more detailed documentation of each function is available using the
% help command. For instance, type help tempocurve.
%
% A complete documentation is available online.
%			http://github/miditoolbox/
%
%CONVERSION FUNCTIONS
% dir2coll       - Converts a directory of MIDI files to cellmatrix structure
% hz2midi        - Convert frequencies to MIDI numbers
% keyname        - Convert keys (24) to key names (text)
% midi2hz        - Convert MIDI note numbers to frequencies (Herz)
% notename       - Convert MIDI numbers to American pitch spelling (text)
% readmidi       - Reads a MIDI file to a notematrix (updated)
% writemidi      - Writes a MIDI file from a notematrix (updated)
% tempocurve     - Extra tempo of each note in BPM (new)
%
%GENERATION FUNCTIONS
% createnmat     - Create a notematrix from the input arguments
% nmat2snd       - Synthesize NMAT using simple synthesis
% playsound      - Play and synthesize NMAT using simple synthesis
% reftune        - Obtain a 'reference' or example tune
%  
%FILTER FUNCTIONS
% dropmidich     - Note events that are not on channel CH
% dropshortnotes - Returns note events that are shorter than THRESHOLD
% elim           - Eliminate short MIDI tracks
% extreme        - Returns extreme pitches (high/low) of a polyphonic NMAT
% getmidich      - Note events on channel CH
% ismonophonic   - Returns 1 if the sequence is monophonic
% mchannels      - Midi channels that are used in NMAT
% movewindow     - Runs a selected function within a defined time window
% onsetwindow    - Events with mintime <= onsettime <= maxtime
% perchannel     - Create output for each available channel
% quantize       - Quantize note onsets and durations of NMAT
% scale          - Scales note data in given dimension (time, onsets, or duration)
% setvalues      - Sets the chosen notematrix value for every event
% shift          - Shifts note data in given dimension (onset, duration, or pitch)
% transpose2c    - Transposes NMAT to C major/C minor
% trim           - Removal of leading silence (trim)
%
%META FUNCTIONS
% analyzecoll    - Analyzes all NMAT in the COLLECTION
% analyzedir     - Analyzes all MIDI files in the directory
% filtercoll     - Filter COLLECTION according to filter function
%  
%PLOTTING FUNCTIONS
% pianoroll      - Plots the NMAT as a "pianoroll" notation
% plotdist       - Plots pitch-class-, interval- or duration-distributions or transitions
% plothierarchy  - Plots the metrical hierarchy of NMAT
% plotmelcontour - Plots the contour of NMAT using STEP resolution
%
%STATISTICAL FUNCTIONS
% durdist1       - Distribution of note durations
% durdist2       - Duration transitions (duration pairs)
% entropy        - Entropy of a distribution
% ivdirdist1     - Distribution of interval directions
% ivdist1        - Distribution of intervals
% ivdist2        - Interval transitions (interval pairs)
% ivsizedist1    - Distribution of interval sizes
% nnotes         - Number of notes in NMAT
% pcdist1        - Distribution of pitch-classes
% pcdist2        - Pitch-class transitions (dyads)
% refstat        - Reference statistics (key profiles, Essen collection, etc.)
%  
%KEY-FINDING FUNCTIONS
% keymode        - Estimates the keymode (1=major, 2=minor) based on KK key
% keysom         - Projection of PC distribution on a SOM (Toiviainen & Krumhansl, 2003)
% keysomanim     - Animation using the KEYSOM function
% kkcc           - Correlation of the PC distribution to existing profiles (updated)
% kkkey          - Returns the key of NMAT according to the Krumhansl-Kessler algorithm
% maxkkcc        - Maximal correlation of the PC distr. with 24 K & K profiles
% tonality       - Krumhansl & Kessler key profiles values (major/minor)
% 
%CONTOUR FUNCTIONS
% melcontour     - Contour vector
% combcontour    - Builds the Quinn (1999) representation of melodic contour
%
%SEGMENTATION FUNCTIONS
% segmentgestalt - Segmentation algorithm by Tenney & Polansky (1980)
% segmentprob    - Probabilistic estimation of segment boundaries
% boundary       - Local Boundary Detection Model by Cambouropoulos (1997)
%
%MELODIC FUNCTIONS
% ambitus        - Melodic range in semitones
% complebm       - Expectancy-based model of melodic complexity (Eerola & North, 2000)
% compltrans     - Melodic originality measure (Simonton, 1984)
% gradus         - Degree of melodiousness (Euler, 1739)
% melaccent      - Melodic accent (Thomassen, 1982)
% melattraction  - Melodic attraction (Lerdahl, 1996)
% meteraccent    - Measure of phenomenal accent synchrony (Eerola, 2006)
% mobility       - Melodic motion as a mobility (Hippel, 2000)
% narmour        - Implication-realization principles by Narmour (1990)
% tessitura      - Melodic tessitura based on deviation from median pitch height (Hippel, 2000)
% meldistance    - Measurement of distance between two NMATs
%  
%METER-RELATED FUNCTIONS
% concur         - Calculates the proportion of concurrent onsets in NMAT
% duraccent      - Returns duration accent of the events (Parncutt, 1994)
% gettempo       - Get tempo (in BPM) updated
% meter          - Autocorrelation-based estimate of meter (Toiviainen & Eerola, 2006)
% metrichierarchy- Metrical hierarchy (Lerdahl & Jackendoff, 1983)
% notedensity    - Notes per beat or second
% nPVI           - Measure of durational variability of events (Grabe & Low, 2002)
% onsetacorr     - Autocorrelation function of onset times
% onsetdist      - Distribution of onset times within a measure
% settempo       - Set tempo (in BPM)
%  
%DEMOS
% mididemo       - Run through 8 MIDI Toolbox demos
%
% Part of the MIDI Toolbox 1.1, Copyright 2016, University of Jyvaskyla, Finland