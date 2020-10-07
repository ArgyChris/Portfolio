# Case study: DNA sequence analysis

The purpose of this project was to analyse the output of DNA sequence instrument. The SequencingData 300718.dat file is an example of data from a sequencing instrument. Briefly, the sequencing operation proceeds in “cycles”, at each cycle a specific fluorescent dye is attached to the next DNA base in the sequence, and a camera measures the intensity at the frequency characteristic of each of the 4 dyes. In principle, there should only be a signal in the channel corresponding to the next base in the sequence.

## Information about the data

1. Row 4: Is the true sequence of bases (known in this case)
2. Rows 6-9: Are the predicted intensities for 70 cycles of sequencing, in each of the 4 channels. The increase in intensity is due to a (planned) increase in the illumination
3. Rows 11-14: Are the measured intensities

### Prerequisites

The code requires the script and the dataset (SequencingData 300718.dat) located in the same folder. Additionally, some important pre-installed modules are required in order for the code to run. 

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

## Question 1

There are different ways to analyze the data and address the first question. The main assumption that I
made here, is that for each cycle in the measurement phase the nucleotide that has the highest intensity is
the winner, and therefore is registered as the measurement for that DNA base. Therefore, I measured the
match on the translated intensities. Another assumption that I made, was that the cycles are independent
from each other. The first method of assessment is via visual comparison of the values of intensities from
the two sequences in each individual cycle. Going through the different cycles, I noticed that the reading
are the same for both cases, the observation and the prediction. However, this is a very simple case with
few bases, in real life the amount of data is in the order of billions bases so the visual inspection is not
efficient. In fact, we can use quantitative measures to compute the similarity. The simplest measure of
which is the Hamming distance, this measure compares two sequences and computes the number of positions
at which the corresponding elements are different. This is a simple way to quantitavely examine if differences
exist and their quantity. To do so, I first normalized the intensities to the range 1.0-0.0, then I found the
maximum for each cycle, and finally I compared the sequences using the measure. According to the results,
the match is perfect. Figure 1 shows the result. In the real case scenario, Hamming distance is limited
by the assumption that the sequences are equal in size. Also, the measure does not consider what kind of
differences are encountered, we can have cases where measurements are missing, are substituted, or deleted.
Thus, more advanced algorithms, like alignment could be used.

## Question 2

Even though the match, after translating the intensity to nucleotides, is perfect there are differences
between the two sequences. So, for this part I disregard my main assumption. In the cycles of the observed
sequence I noticed that the read is very noisy, where you can have cases were the maximum values are not the
same for the observation and the prediction. For example, for the 22th cycle both sequences get maximum
intensity at Cytosine (C), however in the prediction the intensity is 213, while for the observation is 183. At
the same time, there is noise from the Thymine (T) nucleotide giving an intensity of 48. Furthermore, for the
same DNA base, the remaining intensities are negative, which is might be caused by the image analysis step.
It is a common practice in image processing to subtract the average local background from the intensity in
order to correct for the noise, therefore if the value is low then we can have negative responses in a specific
channel. Additionally, I noticed a form of drift effect in the readings as we go through the sequencing cycles
(n to n+1). More precisely, if there is a change in the observed nucleotide that gives the highest intensity,
the second highest intensity response will be given by the nucleotide that was winning in a previous cycle.
For example, for the 22th cycle the second highest intensity is 48 which is given by T, and at the same
time for the 21th cycle the maximum intensity was given by T. Therefore, I made the hypothesis that this
effect is might be caused by a delay in the binding of the fluorescent nucleotide. Thus, as we go through
the cycles some strands that constitute the cluster are behind in the reading phase, contributing overall to
the deviation from the prediction intensity and the increase in the noise. Finally, I can conclude that my
assumption about the independence of the cycles does not hold.

## Question 3

For this question I tried to analyze the drift effect. Previously, I have noticed a form of delay in the second
highest observed intensity when we have a change in the dominantly observed nucleotide. Here, I analyzed
the difference via computing the cross-correlation between the highest, and the rest of the of distributions
in the whole sequence. This measure is useful to compare signals with delays. Figure 3 shows that there is
a positive correlation of 0.17 between the highest and the second highest observed intensities along all the
sequences. The correlation drops to 0.05 and 0.0 for the third and fourth highest intensities, respectively.
Furthermore, I compared basic statistics (μ: mean intensity, σ standard deviation) in two cases:
1. I considered the second highest intensity only in cycles where we have change in the dominantly
observed nucleotide (e.g. 21th to 22th cycle)
2. I considered the second highest intensity only in cycles where we have a perseverance in the dominantly
observed nucleotide (e.g. 8th to 9th cycle).
From my analysis I found that there is significant difference (not statistical) between the first and the second
case (see Figure 3, μ1 = 0.25 vs. μ2 = 0.06). I can conclude that my hypothesis holds and I can quantify it,
so for this case study, as we sequence when there is a transition of the dominant observed nucleotide there
will be increased signal from the previously step.

## Question 4

For the last question I tried to analyze the whole sequencing process. From the description, the data,
and my research, I can infer the following on how the whole sequencing process works:
1. First, the DNA sequence is broken down in different number of segments. This is done to parallelize
the whole process and subsequently accelerate it.
2. The segment of a specific sequence is amplified forming a local cluster of identical sequences. The
reason for the amplification is that later in the process, we need many segments to achieve good optical
signal (illumination), and to be able to make the distinction between the different nucleotides.
3. The next steps constitutes the actual sequencing operation that proceeds in cycles until the whole
sequence is resolved:

(a) In each cycle free nucleotides are sequentially bind to the next DNA base according to the com-
plementarity laws: A binds to T, C binds to G, and vice versa. Each nucleotide is in turn binded

with a dye with specific physical properties. The actual sequence process is called sequencing by
synthesis. Only one fluoroscently tagged nucleotide is added at a time (t). The binding process
is restricting probably to synchronize the whole process and take advantage of the amplification.
(b) The residual free nucleotides that did not bind are washed away.

(c) Then, there is a laser that is scanning the optical field and excites the new binded nucleotides.
Each one emit photons at a characteristic frequency that is detected by a camera. As I showed
in the previous section, there might be a delay effect in the sequencing so we have detectable
intensities from previous steps(t-1).
(d) The process stops when there there is no sequence left, so we have no optical signal, or there is a
specific encountered stopping sequence.
4. Then, there is the image acquisition and analysis phase. In this step, the images are corrected for the
non-uniformities in the background, probably normalized and enhanced. The background correction
is performed locally and adaptively. We can have cases where the background noise is higher than
the intensity from the channel that corresponds to the non-binded nucleotides, so the final intensity
measurements are negative.
5. From the clean image there is the signal extraction process from the whole cluster. The process works
along the different channels that represent the different dyes. The intensities might be normalized and
compared.
6. Sequences originating from different clusters are cleaned, compared, and aligned with the aid of a
template DNA sequence, having a size in the order of Giga bases. This is done to stitch the available
sequenced segments obtained from step 1)-5).

7. The subsequent steps are performed on the fully reconstructed sequence, and statistics or measure-
ments that might be useful are: local deviations from the reference DNA sequence, the distribution of

nucleotides, focus on regions that encode important information, etc.


## Authors

* **Argyrios Christodoulidis** - [email](mailto:argyrios.christodoulidis@gmail.com)
