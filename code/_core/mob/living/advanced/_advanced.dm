/mob/living/advanced
	var/datum/species/mob_species = /datum/species/human/
	var/list/obj/item/organ/organs

/mob/living/advanced/New()

	organs = list()
	mob_species = new mob_species

	for(var/key in mob_species.spawning_organs)
		var/obj/item/organ/O = key
		organs += new O

	update_icon()

	. = ..()

/mob/living/advanced/update_icon()
	overlays = list()
	for(var/obj/item/organ/O in organs)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.icon = O.icon
		spawned_overlay.icon_state = O.icon_state
		overlays += spawned_overlay