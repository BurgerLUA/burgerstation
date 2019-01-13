/datum/species/
	var/name = "BLANK SPECIES"
	var/desc = "OH MY GOD"

	var/eye_color_default = "#FF0000"
	var/skin_color_default = "#0000FF"
	var/hair_color_default = "#00FF00"
	var/hair_style_default = "bald"

	var/list/obj/item/organ/spawning_organs_male = list()

	var/list/obj/item/organ/spawning_organs_female = list()

	var/list/obj/button/spawning_buttons = list()

#define ATTRIBUTE_STRENGTH "strength"
#define ATTRIBUTE_VITALITY "vitality"
#define ATTRIBUTE_FORTITUDE "fortitude"

#define ATTRIBUTE_INTELLIGENCE "intelligence"
#define ATTRIBUTE_RESOLVE "resolve"
#define ATTRIBUTE_WILLPOWER "willpower"

#define ATTRIBUTE_AGILITY "agility"
#define ATTRIBUTE_ENDURANCE "endurance"
#define ATTRIBUTE_LUCK "luck"
