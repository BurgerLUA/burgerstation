/mob/living/advanced
	var/datum/species/mob_species = /datum/species/human/
	var/datum/outfit/mob_outfit = /datum/outfit/assistant/

	var/list/obj/item/organ/organs
	var/list/obj/item/organ/labeled_organs

	//var/list/obj/item/clothing/clothing

	icon = 'icons/invisible.dmi'
	icon_state = "0"

	gender = FEMALE

/mob/living/advanced/New()
	organs = list()
	inventory = list()
	labeled_organs = list()
	if(mob_outfit)
		mob_outfit = new mob_outfit
	if(mob_species)
		mob_species = new mob_species
	..()

/mob/living/advanced/initialize_attributes()
	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.experience = A.level_to_xp(mob_species.attribute_defaults[A.id])
		attributes[A.id] = A

/mob/living/advanced/initialize_skills()
	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.experience = S.level_to_xp(mob_species.skill_defaults[S.id])
		skills[S.id] = S

/mob/living/advanced/Initialize()
	add_species_organs()
	sync_skin_color()
	add_species_buttons()
	add_clothes(mob_outfit)

	for(var/obj/inventory/I in inventory)
		if(I.click_flags == RIGHT_HAND)
			I.add_held_object(new /obj/item/weapon/melee/sword(src.loc))
			break

	update_icon()
	. = ..()

/mob/living/advanced/proc/add_clothes(var/datum/outfit/spawning_outfit)
	if(!spawning_outfit)
		return FALSE

	for(var/key in spawning_outfit.spawning_clothes)
		var/obj/item/clothing/C = new key(get_turf(src))
		add_worn_item(C)

	return TRUE
/mob/living/advanced/proc/add_worn_item(var/obj/item/clothing/C)
	for(var/obj/inventory/I in inventory)
		if(I.add_worn_object(C))
			update_icon()
			return TRUE

/mob/living/advanced/proc/remove_worn_item(var/obj/item/clothing/C)
	for(var/obj/inventory/I in inventory)
		if(I.remove_object(C))
			return TRUE

	return FALSE

/mob/living/advanced/update_icon()

	for(var/O in overlays)
		O = null
		del(O)
	overlays = list()

	for(var/obj/item/organ/O in organs)
		O.update_icon()
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.icon = O.icon
		spawned_overlay.icon_state = O.icon_state
		spawned_overlay.color = O.color
		overlays += spawned_overlay

	for(var/obj/inventory/I in inventory)
		if(!I.should_draw)
			continue
		for(var/obj/item/C in I.worn_objects)
			C.update_icon()
			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = C.worn_layer
			spawned_overlay.icon = C.icon
			spawned_overlay.color = C.color
			spawned_overlay.icon_state = C.icon_state_worn
			overlays += spawned_overlay
		for(var/obj/item/I2 in I.held_objects)
			I2.update_icon()
			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = LAYER_MOB_HELD
			spawned_overlay.icon = I2.icon
			spawned_overlay.color = I2.color
			if(I.item_slot == SLOT_HAND_LEFT)
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_left
			else
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_right

			overlays += spawned_overlay

	. = ..()

/mob/living/advanced/proc/sync_skin_color()
	for(var/obj/item/organ/O in organs)
		O.color = src.color
		O.update_icon()
