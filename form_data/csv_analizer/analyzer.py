data = open("results.csv", "r")
dictionary = {}

for riga in data:
	lista_dati = riga.strip().split(",")
	facolta = lista_dati[1].upper().strip().replace("'"," ").replace("’", " ").replace('"', "").replace("\\", "")
	if(facolta in dictionary):
		dictionary[facolta] += 1
	else:
		dictionary[facolta] = 1 

sorted_dict = sorted(dictionary)

for elem in sorted_dict:
	print(elem + ": " + str(dictionary[elem]))
