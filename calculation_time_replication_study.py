import pandas as pd
import numpy as np
import scipy.stats as stats

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