## About MIDI toolbox

## History

The current version of the MIDI Toolbox is 1.1 (release in May 2016). The previous version (1.01) was released 23rd Jan 2006. Originally the MIDI toolbox was released 18.5.2004.

## Update

At the time of the release of the MIDI toolbox 1.0 in May 2004, we never thought this small collection of functions for meant for analyses inspired by models of music cognition would be used by hundreds of scholarly studies ranging from neuroscience to ethnomusicology. Ironically, we have not really embraced the tool ourselves, since we only have a couple of publications that actually use the tool (Toiviainen & Eerola, 2006; Eerola et al., 2006). Other toolboxes, such as MIR Toolbox (Lartillot & Toiviainen, 2007) and Motion Capture toolbox (Burger & Toiviainen, 2013), became more important in our research.

The main purpose of release MIDI toolbox 1.1 was to make the MIDI toolbox functional again. The original release in 2004 utilised mex files in Matlab to read and write MIDI files. These compiled run files were soon obsolete since they were specific to different operating systems and Matlab versions. In 2006 this problem of reading MIDI files became all too frequent a complaint and we created a simple fix for the problem. This extension bypassed the problematic mex-based read/write functions within the toolbox. However, it did not handle tempo change information properly and was inconvenient for the users, since it needed to be installed separately.

The version 1.1 finally sorts outs this issue by relying on the work carried out by Music Dynamics Lab (http://musicdynamicslab.uconn.edu/) run by Ed Large, who have used the same original source (Ken Schutte) for reading MIDi files as we did in our earlier fix. This also fixes the tempo change issues in reading MIDI files. We also added the possibility of looking at tempo curve (the relative duration of the onsets in BPM), updated few functions, and removed all the obsolete functions. We also switched to github for a more transparent and easy sharing of the code.

## Manual

The documentation provides a description of the Toolbox (Chapter 1), installation and system requirements (Chapter 2). Basic issues are explained in Chapter 3. Chapter 4 demonstrates the Toolbox functions using various examples and Chapter 5 constitutes the function reference section.

Go to MidiToolbox User's Manual [pdf file](https://github.com/miditoolbox/1.1/documentation/MIDItoolbox1.1_manual.pdf).

### Citation

#### APA format:

    Toiviainen, P., & Eerola, T. (2016). MIDI Toolbox 1.1. URL: https://github.com/miditoolbox/1.1

#### Bibtext format:

    @misc{miditoolbox2016,
        Author = {Toiviainen, P. and Eerola, T.},
        Date-Modified = {2016-05-18 09:15:01 +0000},
        Howpublished = {https://github.com/miditoolbox/1.1},
        Journal = {GitHub repository},
        Publisher = {GitHub},
        Title = {MIDI toolbox 1.1},
        Year = {2016}}


## Toolbox is free for academic use

MIDI toolbox is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License. See readme.md for full details.

## Installation

Unpack the MIDI Toolbox file package you have downloaded. To use the toolbox, you need a version of the Matlab software (see [www.mathworks.com](www.mathworks.com)). Thirdly, the MIDI toolbox needs to be defined in the Matlab path variable. Under the File menu, select Set Path. Under the Path menu, select Add to Path. Write here the name of the directory where this toolbox has been installed. Then click OK. Finally, under the File menu, select Save Path, and then Exit.
