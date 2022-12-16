## An Investigation of Confusing Code Patterns in JavaScript

### Authors: Adriano Torres, Caio Oliveira, Márcio Okimoto, Diego Marcílio, Pedro Queiroga, Fernando Castor, Rodrigo Bonifácio, Edna Dias Canedo, Márcio Ribeiro, Eduardo Monteiro

### Abstract

Evolving software is particularly challenging when the code has been poorly written or uses confusing idioms and language constructs, which might increase maintenance efforts and impose a significant cognitive load on developers. Previous research has investigated possible sources of confusion in programs, including the impact of small code patterns (hereafter atoms of confusion) that contribute to misunderstanding the source code. Although researchers have explored atoms of confusion in code written in C, C++, and Java, different languages have different features, developer communities, and development cultures. This justifies the exploration of other languages to verify whether they also exhibit confusion-inducing patterns. In this paper we investigate the impact of atoms of confusion on understanding JavaScript code---a dynamically typed language whose popularity is growing in the most diverse application domains. In this paper we report the results of a mixed-methods research comprising two experiments, a set of interviews with practitioners, and a mining software repository (MSR) effort. The results of both experiments suggest that two code patterns that have been previously observed to confuse C programmers also confuse JavaScript programmers: the comma operator and assignments being used as values. In addition, some code patterns, such as omitted curly braces and change of literal encoding, have caused confusion in participants in one of the experiments. We discover that some JavaScript-specific elements, such as automatic semicolon insertion and object destructuring, also have the potential to cause confusion. For all these cases effect sizes were either medium or high. The interviews we conducted indicate other constructs and idioms that merit investigation in the future. Finally, our MSR effort reveals that the examined code patterns are frequent and used intensively in 72 popular open-source JavaScript projects: four atom candidates appear in 90\% of them and two of them occur more than once for every 100 lines of code.

### Replication Package Data


#### Repeated Measures Experiment
  * [Atoms](https://docs.google.com/spreadsheets/d/1A7Y605WK1fttCUmG9I-I2aTG9C95PVSjBRa3KNUlYn4/edit?usp=sharing)
  * Datasets
  * Analysis
  
### Latin Square Experiment
  * [Atoms](https://github.com/rbonifacio/AtomsJS/blob/main/package/s02/atoms.pdf)
  * [Dataset](https://github.com/rbonifacio/AtomsJS/blob/main/package/s02/survey-results.csv)
  * [R Script for Analysis](https://github.com/rbonifacio/AtomsJS/blob/main/package/s02/analysis.Rmd)
  
### Survey Study

  * [Atoms](https://github.com/rbonifacio/AtomsJS/blob/main/package/s03/atoms.pdf)
  * [Dataset](https://github.com/rbonifacio/AtomsJS/blob/main/package/s03/dataset.csv)
  * [Transcriptions](https://github.com/rbonifacio/AtomsJS/blob/main/package/s03/transcriptions)
  * [R Script for Analysis](https://github.com/rbonifacio/AtomsJS/blob/main/package/s03/analysis.Rmd)

### Prevalence  Study

   * [CodeQL queries](https://github.com/rbonifacio/AtomsJS/tree/main/package/s04/queries)
   * [Results](https://github.com/rbonifacio/AtomsJS/blob/main/package/s04/dataset.csv) 
   * [R Sript for Analysis](https://github.com/rbonifacio/AtomsJS/blob/main/package/s04/analysis.Rmd)