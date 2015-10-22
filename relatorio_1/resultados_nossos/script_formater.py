import numpy as np

data_1 = np.loadtxt("Posicao1.txt");
data_2 = np.loadtxt("Posicao2.txt");
frequencies = []
microphone_1 = []
microphone_2 = []
microphone_3 = []
microphone_4 = []
microphone_5 = []
microphone_6 = []
microphone_7 = []
microphone_8 = []
microphone_9 = []
microphone_10 = []

for frequency in data_1:
	#print frequency[0]
	frequencies.append(frequency[0])
	microphone_1.append(frequency[1])
	microphone_2.append(frequency[3])
	microphone_3.append(frequency[5])
	microphone_4.append(frequency[7])
	microphone_5.append(frequency[9])
	#for microphone in frequency:

for frequency in data_2:
	#print frequency[0]
	microphone_6.append(frequency[1])
	microphone_7.append(frequency[3])
	microphone_8.append(frequency[5])
	microphone_9.append(frequency[7])
	microphone_10.append(frequency[9])
	#for microphone in frequency:

np.savetxt("frequencies.txt", frequencies)
np.savetxt("microphone_1.txt", microphone_1)
np.savetxt("microphone_2.txt", microphone_2)
np.savetxt("microphone_3.txt", microphone_3)
np.savetxt("microphone_4.txt", microphone_4)
np.savetxt("microphone_5.txt", microphone_5)
np.savetxt("microphone_6.txt", microphone_6)
np.savetxt("microphone_7.txt", microphone_7)
np.savetxt("microphone_8.txt", microphone_8)
np.savetxt("microphone_9.txt", microphone_9)
np.savetxt("microphone_10.txt", microphone_10)

		