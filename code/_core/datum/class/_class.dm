//Basically a class system for mobs only.
/class/
	name = "Class"
	desc = "A class."
	id = null

	var/list/attributes = list()

	var/list/skills = list()

	var/starting_species = /species/human/ //For chargen only.