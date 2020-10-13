# Case study: DNA sequence analysis

The purpose of this project was to analyse the output of DNA sequence instrument. The SequencingData 300718.dat file is an example of data from a sequencing instrument. Briefly, the sequencing operation proceeds in “cycles”, at each cycle a specific fluorescent dye is attached to the next DNA base in the sequence, and a camera measures the intensity at the frequency characteristic of each of the 4 dyes. In principle, there should only be a signal in the channel corresponding to the next base in the sequence.

## Information about the data

1. Row 4: Is the true sequence of bases (known in this case)
2. Rows 6-9: Are the predicted intensities for 70 cycles of sequencing, in each of the 4 channels. The increase in intensity is due to a (planned) increase in the illumination
3. Rows 11-14: Are the measured intensities

### Prerequisites

The code requires the script (Case_Study.ipynb) and the dataset (SequencingData 300718.dat) located in the same folder. Additionally, some important pre-installed modules are required in order for the code to run. 

Install the following libraries:

```
$sudo pip install numpy
$sudo pip install pandas
```

## Questions

1. Is there a good match between the observation and the prediction?
2. If not, could the difference be characterised between them?
3. Could the quantitative value of this effect be estimated?
4. The intensity values come from a “cluster” of identical strands of DNA: in theory the sequencing process should operate identically on each strand in the cluster. Could anything be infered about how the sequencing process is actually working?

## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
