![OpenMIIR: a public domain dataset of EEG recordings for music imagery information retrieval](https://raw.githubusercontent.com/sstober/openmiir/master/logo/OpenMIIR-logo_transparent_728x265.png)

Music imagery information retrieval (MIIR) systems may one day be able to recognize a song just as we think of it.
As a step towards such technology, we are presenting a public domain dataset of electroencephalography (EEG) recordings taken during music perception and imagination.
We acquired this data during an ongoing study that so far comprised 10 subjects listening to and imagining 12 short music fragments - each 7s-16s long - taken from well-known pieces. 
These stimuli were selected from different genres and systematically span several musical dimensions such as meter, tempo and the presence of lyrics.
This way, various retrieval and classification scenarios can be addressed.
The dataset is primarily aimed to enable music information retrieval researchers interested in these new MIIR challenges to easily test and adapt their existing approaches for music analysis like fingerprinting, beat tracking or tempo estimation on this new kind of data.
We also hope that the OpenMIIR dataset will facilitate a stronger interdisciplinary collaboration between music information retrieval researchers and neuroscientists.


## Obtaining the Raw EEG Data

This git repository does not contain the raw EEG data, which is around 700 MB per subject adding up to several gigabytes in total. There are currently two ways to obtain the data:

1. download via http from one of the sites listed below:
	- [University of Potsdam](http://www.ling.uni-potsdam.de/mlcog/OpenMIIR-RawEEG_v1/)
	- [University of Western Ontario](<http://bmi.ssc.uwo.ca/OpenMIIR-RawEEG_v1/>)

2. download via bittorrent tracked by [academic torrents](<http://academictorrents.com/details/c18c04a9f18ff7d133421012978c4a92f57f6b9c>)

We strongly encorage the second approach as it allows for distributed sharing.


## Data Processing

In order to enable everybody to work with this data, we decided to share it in a format that does not require any commercial software for loading and processing. Specifically, the raw EEG is saved in the FIF file format used by [MNE](<http://martinos.org/mne/>) and [MNE-Python](<http://martinos.org/mne/stable/mne-python.html>). 

This data format can, for instance, also be easily converted into the MAT format used by Matlab, which allows importing into EEGLab. A description on how to do this can be found [in the wiki](<https://github.com/sstober/openmiir/wiki/How-to-import-the-raw-EEG-data-into-EEGLab>).

For further processing, we provide custom dataset implementations and deep learning pipelines for [pylearn2](<https://github.com/lisa-lab/pylearn2>) within the [deepthought](<https://github.com/sstober/deepthought>) project. 


## More Information

A first presentation about this dataset was given at [NEMISIG 2015](<http://jimi.ithaca.edu/nemisig/>) and can be downloaded [here](<http://bib.sebastianstober.de/2015-01-31_NEMISIG.pdf>).
Furthermore, there is information about [labs using this dataset](<https://github.com/sstober/openmiir/wiki/Labs-using-this-Dataset>) and [related publications](<https://github.com/sstober/openmiir/wiki/Related-Publications>) in the [repository wiki](<https://github.com/sstober/openmiir/wiki>). Please contact us, if you would like to be added.


## Contributing

You are openly invited to contribute to this dataset. There are several possibilities to do this:

- add more subjects by running the experiment yourself
- host an http download mirror or seed the dataset torrent to provide download bandwidth
- run your own experiments on the dataset and share your results
- ...

If you want to contribute, please contact us.


## License and Citations

OpenMIIR is released under the [Open Data Commons Public Domain Dedication and Licence (PDDL)](<http://opendatacommons.org/licenses/pddl/1-0/>), which means that you can freely use it without any restrictions.

If you use the OpenMIIR dataset in published research work, we would appreciate if you would cite this article: 
Sebastian Stober, Avital Sternin, Adrian M. Owen and Jessica A. Grahn: **"Towards Music Imagery Information Retrieval: Introducing the OpenMIIR Dataset of EEG Recordings from Music Perception and Imagination."** In: Proceedings of the 16th International Society for Music Information Retrieval Conference (ISMIR’15), pages 763-769, 2015. 


## Acknowledgments

This dataset is a result of ongoing joint work between the [Owen Lab](<http://www.owenlab.uwo.ca/>) and the [Music and Neuroscience Lab](<http://www.jessicagrahn.com/>) at the [Brain and Mind Institute](<http://www.uwo.ca/bmi/>) of the [University of Western Ontario](<http://www.uwo.ca/>).
It has been supported by a fellowship within the Postdoc-Program of the German Academic Exchange Service (DAAD), the Canada Excellence Research Chairs (CERC) Program, an National Sciences and Engineering Research Council (NSERC) Discovery Grant and an Ontario Early Researcher Award.


## Contact

Sebastian Stober \<sstober AT uni-potsdam DOT de\>  
Machine Learning in Cognitive Science Lab  
Research Focus Cognitive Sciences  
University of Potsdam, Germany  


[http://www.owenlab.uwo.ca/](<http://www.owenlab.uwo.ca/>)  
[http://www.jessicagrahn.com/](<http://www.jessicagrahn.com/>)  
[http://www.uni-potsdam.de/mlcog/](<http://www.uni-potsdam.de/mlcog/>)  