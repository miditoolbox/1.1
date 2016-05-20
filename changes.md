# Changes from 1.0 to 1.1

The main purpose of release 1.1 was to make the MIDI toolbox functional again. The original release utilised mex files in Matlab to read and write MIDI files, which needed to be compiled before use. These were soon obsolete since Operating Systems and Matlab evolved. Between 2006 and 2016, there was a fix for this, called "no mex extension", which bypassed the problematic mex-based read/write functions within the toolbox. However, this fix did not handle tempo change information properly and was inconvenient for the users, since the fix needed to be installed separately.

We made the update relying on the work carried out by [Music Dynamics Lab](http://musicdynamicslab.uconn.edu/home/) run by Ed Large, who have used the same original source (Ken Schutte) for reading MIDi files as we did in our earlier fix. Thank you Ed and the wonderful [GrFNN Toolbox](http://musicdynamicslab.uconn.edu/home/multimedia/grfnn-toolbox/)    

## New functions in 1.1

* `tempocurve` - Tempo in bpm

## Updated functions in 1.1

* `gettempo` - Gets the mean tempo
* `kkcc` - Added alternative key profiles (Temperley, Albrecht and Shanahan)
* `writemidi` - Convenience function that uses `writeNMatToSmf`
* `nmat2midi` - Convenience function that uses `writeNMatToSmf`
* `refstat` - Few new profiles (key-finding)

## REMOVED functions in 1.1

* `playmidi`  - Removed as obsolete (OS dependent)
* `nmat2mft`  - Removed as obsolete
* `midi2nmat`  - Removed as obsolete (OS dependent)
* `mftxt2nmat` - Removed as obsolete
* `nmat2midi` - Removed as obsolete
* `setmidiplayer`  - Removed as obsolete (OS dependent)

20-05-2016 09:39:46 TE