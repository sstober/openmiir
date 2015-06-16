This directory contains information about import and preprocessing of the raw EEG.

* notebooks - one jupyter notebook per subject with all steps of the common preprocessing pipeline. Except for the initial conversion from raw Biosemi format and basic event processing, all steps can be customized.

* ica - per-subject ICA parameters for eye blink removal. ICA is computed during preprocessing and components that correlate with eye blinks are zeroed out. But the transformation is not applied to the raw data at that point. I.e., the raw data remains unchanged and the transformation can be optionally applied after loading a file using the ICA file without having to go through the expensive ICA computation again.
