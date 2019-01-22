data = open("servizi.txt", "r")
dictionary = {}
dictionary["FACEBOOK"] = 0
dictionary["DRIVE"] = 0
dictionary["WHATSAPP"] = 0
dictionary["NO"] = 0
dictionary["NOTE"] = 0
dictionary["TELEGRAM"] = 0
dictionary["DROPBOX"] = 0
dictionary["TUTORED"] = 0
dictionary["STUDOCU"] = 0
dictionary["YOUTUBE"] = 0
dictionary["SKUOLA"] = 0
dictionary["PIAZZA"] = 0
dictionary["KHAN"] = 0
dictionary["YOUMATH"] = 0
dictionary["MEGA"] = 0
dictionary["DOCSITY"] = 0
dictionary["MOODLE"] = 0
dictionary["UNIWHERE"] = 0
dictionary["SOCIALNOTES.EU"] = 0
dictionary["ACADEMIA.EDU"] = 0

keys = dictionary.keys()

for riga in data:
	lista = riga.upper().strip().split(" ")
	for parola in lista :
		val = parola.strip().replace(",", "")
		if(val in keys):
			dictionary[val] += 1

sorted_dict = sorted(dictionary)

for elem in sorted_dict:
	print(elem + ": " + str(dictionary[elem]))
