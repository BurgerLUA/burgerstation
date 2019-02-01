var/global/list/hair_types = list()
var/global/list/hair_names = list()
var/global/list/hair_icons = list()
var/global/list/hair_icon_references = list()

/datum/subsystem/hair/
	name = "Hair Subsystem"
	desc = "Yes, there is a fucking subsystem dedicated to hair."
	priority = SS_ORDER_HAIR

/datum/subsystem/hair/on_life()
	for(var/v in subtypesof(/hair/))
		var/hair/H = new v
		hair_types[H.id] = H
		var/icon/I = new /icon('icons/mob/living/advanced/hair/hair.dmi',H.icon_state)
		hair_icons[H.id] = I
		hair_icon_references[H.id] = "\icon[I]"
		hair_names[H.id] = H.name

	return FALSE