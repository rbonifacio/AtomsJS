- Which atoms can be accepted as atoms? OK 
- The delta is the magnitude. However, it is not clear to me what it is. 
- For dispersion/whether subjects erred in the same manner, the data is already in the table. OK

- Mean time for correct responses and mean time for incorrect responses, independently of atoms. Wilcoxon rank sum test to check the difference. OK  --- 


import pandas as pd
import numpy as np
import scipy.stats as stats
import statsmodels.stats.contingency_tables as statsmodels
from statsmodels.stats.contingency_tables import Table2x2


atoms = pd.read_csv('results_JS_replication_study.csv')
atoms.dropna(thresh=10, inplace=True)
times = atoms.loc[:, 'Question 1 time':'Question 48 time']
correct = atoms.loc[:,'Question 1 correct':'Question 48 correct']
correct.columns = times.columns
correctTimesTemp = times.where(correct)
correctTimes = pd.Series(correctTimesTemp.values.flatten()).dropna()
incorrectTimesTemp = times.where(np.logical_not(correct))
incorrectTimes = pd.Series(incorrectTimesTemp.values.flatten()).dropna()
correctTimes = correctTimes[correctTimes.map(lambda t: type(t) != type('ok'))]
incorrectTimes = incorrectTimes[incorrectTimes.map(lambda t: type(t) != type('ok'))]
print(stats.ranksums(correctTimes, incorrectTimes))
print(np.mean(correctTimes), np.mean(incorrectTimes))
print(np.median(correctTimes), np.median(incorrectTimes))
print(np.std(correctTimes), np.std(incorrectTimes))


A primeira coisa que fui calcular foram os tempos médios para respostas corretas e incorretas (independente de serem versões obscurecidas ou clarificadas), devido a análise que o Gopstein faz no artigo dele sobre o trade-off entre corretude e tempo (será que quem acerta vai mais devagar?). No nosso trabalho, os resultados foram significativamente diferentes entre resultados corretos e incorretos, por questão: 
Mean time correct: 35.44412803398052s
Mean time incorrect: 44.50444720101791s
Wilcoxon Rank Sum test: (statistic=-5.042914598471609, pvalue=4.5849391631250766e-07)
Medians, respectively:
24.362499999999997 and 29.2825
Standard deviations: 38.427615862599204 and 62.48393041895574





- For which atom candidates did subjects get more wrong answers? Which version? Clarified or obfuscated? Measure number of right vs wrong answers. Is this directly observable in the results of Pedro's table or are there cases where there were many errors in both versions? ) OK


Data from Pedro's study:
https://docs.google.com/spreadsheets/d/1A7Y605WK1fttCUmG9I-I2aTG9C95PVSjBRa3KNUlYn4/edit#gid=2010615995

Groups of 6 per atom, odd obfuscated, even clear.


In [30]: topLevel = [x//6 for x in range(6, 150)]

In [31]: secondLevel = ["obfuscated" if ((x%6) <3) else "clear" for x in range(0, 144)]

In [32]: thirdLevel = [(x%3)+1 for x in range(0, 144)]

In [33]: temp = np.zeros((70, 144))

In [34]: atomResults = pd.DataFrame(temp)

In [35]: atomResults.columns=[topLevel, secondLevel, thirdLevel]

In [65]: atomResults.replace(0, np.nan, inplace=True)

In [43]: atomResults.loc[0, (3, 'obfuscated', 2)]

In [52]: def getSnippetId(questionNum:int) -> (int, str, int):
    ...:     topL = (questionNum+5) // 6
    ...:     secondL = "obfuscated" if (questionNum % 2) == 1 else "clear"
    ...:     thirdL = (((questionNum-1)%6)//2)+1
    ...:     return (topL, secondL, thirdL)

In [79]: atomsOfInterest = atoms.loc[:, 'Question 1 number':'Question 48 correct'].values

In [95]: def processAtomsOfInterest(theAtoms, results):
    ...:     numQuestions = 48
    ...:     j = 0
    ...:     while j < len(theAtoms):
    ...:         row = theAtoms[j]
    ...:         i = 0
    ...:         while i < numQuestions:
    ...:             results.loc[j, getSnippetId(row[i])] = row[i + numQuestions]
    ...:             i += 1
    ...:         j += 1

In [27]: processAtomsOfInterest(atomsOfInterest, atomResults)

In [116]: atomCounts = pd.DataFrame(np.zeros((24, 4)), columns=['obfuscated_ok', 'obfuscated_wrong', 'clear_ok', 'clear_wrong'])

In [116]: atomCounts.index=range(1,25)

In [175]: def countAtoms(atomData, counts):
     ...:      j = 0
     ...:      while j < len(atomData):
     ...:          row = atomData.loc[j]
     ...:          i = 1
     ...:          while i <= 24:
     ...:              obfuscatedD = row[(i, 'obfuscated')].dropna().values[0]
     ...:              clearD = row[(i, 'clear')].dropna().values[0]
     ...:              if obfuscatedD:
     ...:                  counts.loc[i, 'obfuscated_ok'] += 1
     ...:              else:
     ...:                  counts.loc[i, 'obfuscated_wrong'] += 1
     ...: 
     ...:              if clearD:
     ...:                  counts.loc[i, 'clear_ok'] += 1
     ...:              else:
     ...:                  counts.loc[i, 'clear_wrong'] += 1
     ...:              i += 1
     ...:          print('i', i)
     ...:          print('j', j)
     ...:          j += 1

In [175]: countAtoms(atomResults, atomCounts)
 
In [182]: def buildContingencyTable(aSeries):
     ...:     return [[aSeries.iloc[0], aSeries.iloc[1]], [aSeries.iloc[2], aSeries.iloc[3]
     ...: ]]

In [16]: def printOddsRatio(contingencyTable, label):
    ...:     ct = Table2x2(contingencyTable)
    ...:     print(label)
    ...:     print("Odds ratio: ", ct.oddsratio)
    ...:     print("p-value: ", ct.oddsratio_pvalue())
    ...:     print("Confidence interval at 95% confidence level:", ct.oddsratio_confint(alpha=0.05, method='normal'))
    ...:     print()

In [196]: def outputOddsRatios(counts):
     ...:     i = 1
     ...:     while i <= len(counts):
     ...:         row = atomCounts.loc[i]
     ...:         print(row)
     ...:         printOddsRatio(buildContingencyTable(row), 'Atom ' + str(i))
     ...:         i += 1
     ...: 
     ...: 
     ...: 

In [196]: def outputMcNemar(counts):
     ...:     i = 1
     ...:     while i <= len(counts):
     ...:         row = atomCounts.loc[i]
     ...:         print(row)
     ...:         print(statsmodels.mcnemar(buildContingencyTable(row), exact=True, correction=True), 'Atom ' + str(i))
     ...:         i += 1



#----- USING THIS ------
In [197]: outputOddsRatios(atomCounts)
obfuscated_ok       41.0
obfuscated_wrong    29.0
clear_ok            44.0
clear_wrong         26.0
Name: 1, dtype: float64
Atom 1
Odds ratio:  0.835423197492163
p-value:  0.6037935745424128
Confidence interval at 95% confidence level: (0.42360953930715606, 1.6475831022350158)

obfuscated_ok       47.0
obfuscated_wrong    23.0
clear_ok            53.0
clear_wrong         17.0
Name: 2, dtype: float64
Atom 2
Odds ratio:  0.6554552912223134
p-value:  0.26303669204037206
Confidence interval at 95% confidence level: (0.31281104213716515, 1.373422229139027)

obfuscated_ok        8.0
obfuscated_wrong    62.0
clear_ok            17.0
clear_wrong         53.0
Name: 3, dtype: float64
Atom 3
Odds ratio:  0.40227703984819735
p-value:  0.051575317001275565
Confidence interval at 95% confidence level: (0.16082295683428605, 1.0062420190158334)

obfuscated_ok       13.0
obfuscated_wrong    57.0
clear_ok            28.0
clear_wrong         42.0
Name: 4, dtype: float64
Atom 4
Odds ratio:  0.34210526315789475
p-value:  0.0062681528934906226
Confidence interval at 95% confidence level: (0.1585382958481899, 0.7382191820227559)

obfuscated_ok       59.0
obfuscated_wrong    11.0
clear_ok            61.0
clear_wrong          9.0
Name: 5, dtype: float64
Atom 5
Odds ratio:  0.7913561847988078
p-value:  0.629559012101714
Confidence interval at 95% confidence level: (0.3057865290686956, 2.0479797233927135)

obfuscated_ok       30.0
obfuscated_wrong    40.0
clear_ok            50.0
clear_wrong         20.0
Name: 6, dtype: float64
Atom 6 -- Omitted Curly Braces
Odds ratio:  0.3
p-value:  0.0007770778000168332
Confidence interval at 95% confidence level: (0.148658539012651, 0.605414264109921)

obfuscated_ok       60.0
obfuscated_wrong    10.0
clear_ok            62.0
clear_wrong          8.0
Name: 7, dtype: float64
Atom 7
Odds ratio:  0.7741935483870968
p-value:  0.6142136248739487
Confidence interval at 95% confidence level: (0.2861962929760461, 2.0942816698690403)

obfuscated_ok       52.0
obfuscated_wrong    18.0
clear_ok            47.0
clear_wrong         23.0
Name: 8, dtype: float64
Atom 8
Odds ratio:  1.41371158392435
p-value:  0.35401582139607535
Confidence interval at 95% confidence level: (0.6798180340261734, 2.9398755880091136)

obfuscated_ok        8.0
obfuscated_wrong    62.0
clear_ok            29.0
clear_wrong         41.0
Name: 9, dtype: float64
Atom 9 -- Comma Operator
Odds ratio:  0.18242491657397109
p-value:  0.00014211167040293146
Confidence interval at 95% confidence level: (0.07592998555169012, 0.43828337309988513)

obfuscated_ok       18.0
obfuscated_wrong    52.0
clear_ok            43.0
clear_wrong         27.0
Name: 10, dtype: float64
Atom 10 -- Assignment Expression
Odds ratio:  0.21735241502683364
p-value:  3.2862056163404736e-05
Confidence interval at 95% confidence level: (0.10575997847767318, 0.4466913949681837)

obfuscated_ok       33.0
obfuscated_wrong    37.0
clear_ok            28.0
clear_wrong         42.0
Name: 11, dtype: float64
Atom 11
Odds ratio:  1.337837837837838
p-value:  0.3945259504986107
Confidence interval at 95% confidence level: (0.6845885548402815, 2.6144317892784454)

obfuscated_ok       23.0
obfuscated_wrong    47.0
clear_ok            23.0
clear_wrong         47.0
Name: 12, dtype: float64
Atom 12
Odds ratio:  1.0
p-value:  1.0
Confidence interval at 95% confidence level: (0.4939400055252481, 2.0245373705590333)

obfuscated_ok       63.0
obfuscated_wrong     7.0
clear_ok            64.0
clear_wrong          6.0
Name: 13, dtype: float64
Atom 13
Odds ratio:  0.84375
p-value:  0.7710990554513015
Confidence interval at 95% confidence level: (0.26861916242004497, 2.650272810346889)

obfuscated_ok        9.0
obfuscated_wrong    61.0
clear_ok            36.0
clear_wrong         34.0
Name: 14, dtype: float64
Atom 14 -- (Change of) Literal Encoding 
Odds ratio:  0.13934426229508196
p-value:  4.521911663346013e-06
Confidence interval at 95% confidence level: (0.06001727612116941, 0.3235205708996162)

obfuscated_ok       35.0
obfuscated_wrong    35.0
clear_ok            51.0
clear_wrong         19.0
Name: 15, dtype: float64
Atom 15
Odds ratio:  0.37254901960784315
p-value:  0.006050215153651537
Confidence interval at 95% confidence level: (0.1840807488060275, 0.7539776587774312)

obfuscated_ok        5.0
obfuscated_wrong    65.0
clear_ok            27.0
clear_wrong         43.0
Name: 16, dtype: float64
Atom 16 -- Type Conversion (to String)
Odds ratio:  0.1225071225071225
p-value:  6.365609660871795e-05
Confidence interval at 95% confidence level: (0.04377619377718698, 0.3428346269975675)

obfuscated_ok       53.0
obfuscated_wrong    17.0
clear_ok            55.0
clear_wrong         15.0
Name: 17, dtype: float64
Atom 17
Odds ratio:  0.8502673796791443
p-value:  0.6874410379463549
Confidence interval at 95% confidence level: (0.3858184942161845, 1.8738205342259902)

obfuscated_ok       15.0
obfuscated_wrong    55.0
clear_ok            21.0
clear_wrong         49.0
Name: 18, dtype: float64
Atom 18
Odds ratio:  0.6363636363636364
p-value:  0.247684332133834
Confidence interval at 95% confidence level: (0.29572723666706496, 1.3693655080605909)

obfuscated_ok       51.0
obfuscated_wrong    19.0
clear_ok            42.0
clear_wrong         28.0
Name: 19, dtype: float64
Atom 19
Odds ratio:  1.7894736842105263
p-value:  0.10890711542702891
Confidence interval at 95% confidence level: (0.8785084014599138, 3.645060264831298)

obfuscated_ok       54.0
obfuscated_wrong    16.0
clear_ok            58.0
clear_wrong         12.0
Name: 20, dtype: float64
Atom 20
Odds ratio:  0.6982758620689655
p-value:  0.3993504287702212
Confidence interval at 95% confidence level: (0.3028991606301362, 1.6097409399676161)

obfuscated_ok       22.0
obfuscated_wrong    48.0
clear_ok            31.0
clear_wrong         39.0
Name: 21, dtype: float64
Atom 21
Odds ratio:  0.5766129032258065
p-value:  0.11819934831745503
Confidence interval at 95% confidence level: (0.2890143939717221, 1.1504009734512521)

obfuscated_ok       21.0
obfuscated_wrong    49.0
clear_ok            30.0
clear_wrong         40.0
Name: 22, dtype: float64
Atom 22
Odds ratio:  0.5714285714285714
p-value:  0.11542085806598201
Confidence interval at 95% confidence level: (0.2846973306449932, 1.146939493619874)

obfuscated_ok       15.0
obfuscated_wrong    55.0
clear_ok            28.0
clear_wrong         42.0
Name: 23, dtype: float64
Atom 23
Odds ratio:  0.4090909090909091
p-value:  0.01865380841767092
Confidence interval at 95% confidence level: (0.194264871000593, 0.8614803646116521)

obfuscated_ok       15.0
obfuscated_wrong    55.0
clear_ok            42.0
clear_wrong         28.0
Name: 24, dtype: float64
Atom 24 -- Object Destructuring
Odds ratio:  0.18181818181818182
p-value:  7.236548979447854e-06
Confidence interval at 95% confidence level: (0.0863399426669302, 0.382880162049623)

