//Basically a class system for mobs only.
/class/
	var/name
	var/desc
	var/id

	var/list/attributes = list()

	var/list/skills = list()


	var/list/skill_descriptions = list()

	var/list/attribute_descriptions = list()


	var/starting_species = /datum/species/human/ //For chargen only.