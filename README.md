# AniWorld-Sub-Dub-Merger
A little script to megre the Sub and Dub of an episode downloaded using Aniworld Downloader
## Prerequisites
mkvmerger from the mkvtoolnix package
## Usage
Place the file next to the Episodes you want to merge.\
The input agruments are first the "File Prefix" a.e. the Anime Name. Then the number of seasons in the folder, then the language in the filename and lastly if you want to delete the original file.\
For example:\
The two files are Named "SPY x FAMILY - S03E001 - (German Dub).mp4" and "SPY x FAMILY - S03E001 - (German Sub).mp4" and you want to clear the old files.
Then you would run ``` ./sdmerger.sh "SPY x FAMILY" 3 "German" 1 ```\
