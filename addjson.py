# -*- coding: utf-8 -*-

import json

nick = raw_input("Nimimerkki: ")
name = raw_input("Nimi: ")
loc = raw_input("Sijainti: ")
coming = raw_input("Tulossa? (0, 1, 2) ")
group = raw_input("Ryhmä: ")
wishes = raw_input("Paikkatoiveet: ")
place = raw_input("Paikka: ")
other = raw_input("Muuta: ")
showname = raw_input("Näytä nimi? (0, 1) ")
email = raw_input("Sähköposti: ")
phonenumber = raw_input("Puhelinnumero: ")
paid = raw_input("Maksanut? (0, 1) ")

f = open('participates.json', 'r')
foo = json.load(f)
foo["participates"].append(
	{
		"nick" : nick,
		"name" : name,
		"location" : loc,
		"coming" : int(coming),
		"group" : group,
		"wishes" : wishes,
		"place" : place,
		"other" : other,
		"showname" : int(showname),
		"email" : email,
		"phonenumber" : phonenumber,
		"paid" : int(paid)
	}
)
f.close()

with open('participates.json', 'w') as outfile:
  json.dump(foo, outfile)
  