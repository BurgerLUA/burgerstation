/mob/living/advanced
	var/datum/species/mob_species = /datum/species/human/
	var/datum/outfit/mob_outfit = /datum/outfit/assistant


	var/list/obj/item/organ/organs
	var/list/obj/item/clothing/clothing

	icon = 'icons/invisible.dmi'
	icon_state = "0"

/mob/living/advanced/New()

	organs = list()
	clothing = list()

	mob_outfit = new mob_outfit
	mob_species = new mob_species

	for(var/key in mob_species.spawning_organs)
		var/obj/item/organ/O = key
		organs += new O

	for(var/key in mob_outfit.spawning_clothes)
		var/obj/item/clothing/C = key
		clothing += new C

	. = ..()

/mob/living/advanced/Initialize()
	. = ..()
	update_icon()

/mob/living/advanced/update_icon()
	overlays = list()

	for(var/obj/item/organ/O in organs)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.icon = O.icon
		spawned_overlay.icon_state = O.icon_state
		overlays += spawned_overlay

	for(var/obj/item/clothing/C in clothing)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = C.worn_layer
		spawned_overlay.icon = C.worn_icon
		spawned_overlay.icon_state = C.worn_icon_state
		overlays += spawned_overlay