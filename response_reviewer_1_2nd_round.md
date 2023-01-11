In general, I do not understand why some of my concerns are addressed while others are purposefully ignored. Even minor issues, such as missing thousands separators, are ignored. I feel that my review was not respected, and the authors' changes to my review were not highlighted, causing me to spend a lot of time trying to find out if they had made changes. The major revision decision will remain until all my comments have been responded to by the authors.

----------------------------------//-----------------------------------

Reviewer #1: Summary


General Comments

Thank you for providing me with an enjoyable review experience. The authors clearly have a good capacity to construct and organize their work on a professional level. Generally, I am satisfied with the paper, but I still have some concerns that I hope the authors will address.

---> We thank the reviewer for the kinds words.

Detailed Comments

- What concerns me the most are the paper's contributions. In some ways, the paper is like an extended work from C to JavaScript. There are only a few new atom candidates being researched that are specific to JavaScript. Given this concern, I believe it is necessary to reorder the RQs in order to boost the work's contributions. RQ3 should be the first RQ to uncover the prevalence of atom candidates in real-world js programming. There would be no need for this study to be done if these atom candidates were infrequently observed in the real world. Based on this discovery, the other experiments could be continued.

---> We have re-organized the studies as suggested by the reviewer. The repository mining study now comes first and is presented as a motivating study for the remaining studies, highlighting their relevance. Besides the re-ordering of the sections, changes have been applied to multiple parts of the paper. 


- Pages 1-2: The research's conclusions and findings, which are summarized in the abstract, are too detailed and somewhat tedious. I would suggest that the authors revisit the answers to the three RQs and rewrite the back half of the abstract.

---> We have cut about 85 words from the abstract, specifically from the part about the contributions. We avoided cutting more because the paper presents the results of four different studies and the abstract to a certain extent reflects that. 


- Page 6: At the beginning of section 3, I expect a figure introducing the entire workflow. Given that the paper includes several experiments, it would be helpful to use a figure to create a broad overview of the paper.

*Make the workflow.* 


- Page 11: As stated by the authors on this page,  for the second experiment, they only use ten of the atom candidates that were used in the first experiment. Table 2 shows that 14 atom candidates were not studied in the second experiment. Can the authors explain how the atom candidate was chosen for the second experiment?

---> In the second experiment, we have tackled the nine atoms that have been validated for the C language in the original paper by Gopstein et al. (2017). In addition, we have studied a single atom that is specific to JavaScript programs, Automated Semicolon Insertion. The explain this in the beginning of Section 6. The reason for analyzing a smaller number of atoms is to attempt to increase the number of participants, since a large number of tasks in a study usually results in subjects not participating or dropping out of the study. This strategy was successful, as can be seen by the considerably larger number of participants in the Latin Square Study, twice as large as that of the repeated measures study. We emphasize that the two experiments were designed and conducted independently, by two independent groups without knowledge about the other. This explains why some atom candidates are in one study and not the other. 


- Page 25: It seems that developers need more time to submit the correct answer using the obfuscated versions of two atom candidates than the clean versions. Is there a rationale behind this?

---> This could only be observed with statistical significance for three of the atoms, after p-value correction. Effect sizes are also mostly very small and they are not affected by sample sizes, differently from the p-values. This combination of results makes it difficult to formulate hypotheses beyond the obvious: that obfuscated snippets are slightly more confusing than the cleaned ones, with few exceptions. 


- Page 34: I do not think it is a good idea to answer all of the RQs on one page. Since the experiments involve so many details, it is difficult for readers to recall all of them when reading these answers. I would suggest treating RQs as separate sections, with the answers to RQ serving as a summary of the section. They could have a look at the following paper:
Li, H., Shang, W. & Hassan, A.E. Which log level should developers choose for a new logging statement?. Empir Software Eng 22, 1684-1716 (2017).


---> We thank the reviewer for the comment. We have restructured the sections of the paper so that each study is wholly contained in a single section, both the methodology and the results. This addresses a comment from another review but we believe it improves the cohesiveness of the sections. As for the summaries of the responses, we would prefer to keep it in a single place, though, for ease of reference. The goal is to enable readers to have a high-level overview of the results in a single place. 

Minor issues:

- Page 6: the analyzed code patternson -> the analyzed code patterns on

---> Fixed. Thanks.

- Page 13: pilot.Undergraduate -> pilot. Undergraduate

---> Fixed. Thanks. 

- Thousand separators are missing in numbers.

---> Fixed. Thanks. We gave a pass through the entire paper but only found numbers requiring this correction in Section 4 (the MSR study). Please let us know if we have missed any others. 

- I would suggest rounding the decimals to the same number of decimal places.

---> We have partially incorporated this suggestion. We focused mainly on the tables, where we believe the uniformity matters more for presentation and interpretation purposes. For p-values, we kept the four decimal places because it is relevant to be precise, as some p-values are very small. For all the other numbers where decimal places matter, we used two. In the text itself, we did not change the number of decimal places because we do not think much is lost. For example, for a p-value of 0.007, we prefer to use 0.007 instead of saying 0.0070 just to preserve uniformity.   

- Page 25: Seven atom candidates are mentioned in the text, but the table lists eight candidates.

---> Fixed. Thanks. 
