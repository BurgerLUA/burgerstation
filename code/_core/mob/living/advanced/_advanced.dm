/mob/living/advanced

	name = "lost soul"

	var/datum/species/mob_species = /datum/species/human/
	var/datum/outfit/mob_outfit = /datum/outfit/new_character/

	var/list/obj/item/organ/organs
	var/list/obj/item/organ/labeled_organs

	var/obj/item/automatic_left
	var/obj/item/automatic_right

	icon = 'icons/invisible.dmi'
	icon_state = "0"

	gender = MALE

	var/starting_class = "default"

	var/list/atom/tracked_overlays = list()


/mob/living/advanced/on_life_client()
	..()
	if(attack_flags & ATTACK_HELD_RIGHT)
		do_automatic_left()
	if(attack_flags & ATTACK_HELD_LEFT)
		do_automatic_right()

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

	var/class/C = all_classes[starting_class]

	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.Initialize(A.level_to_xp(C.attributes[A.id]))
		attributes[A.id] = A

/mob/living/advanced/initialize_skills()

	var/class/C = all_classes[starting_class]


	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.Initialize(S.level_to_xp(C.skills[S.id]))
		skills[S.id] = S

/mob/living/advanced/Initialize()

	if(!client || client.userdata.loaded_data["tutorial"])
		add_species_organs()
		add_species_colors()
		add_species_buttons()
		add_clothes(mob_outfit)
		update_icon()
	else
		client.userdata.apply_data_to_mob(src)

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
		if(I.add_worn_object(C,FALSE))
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

	update_organ_icons()
	update_inventory_icons()

	. = ..()

/mob/living/advanced/proc/update_organ_icons()
	for(var/obj/item/organ/O in organs)

		O.update_icon()

		if(is_tail(O))
			var/obj/overlay/behind_overlay = new /obj/overlay
			behind_overlay.layer = LAYER_MOB_TAIL_BEHIND
			behind_overlay.icon = O.icon
			behind_overlay.icon_state = "tail_behind"
			behind_overlay.color = O.color

			var/obj/overlay/front_overlay = new /obj/overlay
			front_overlay.layer = LAYER_MOB_TAIL_FRONT
			front_overlay.icon = O.icon
			front_overlay.icon_state = "tail_front"
			front_overlay.color = O.color

			overlays += front_overlay
			overlays += behind_overlay
			continue

		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.icon = O.icon
		spawned_overlay.icon_state = O.icon_state
		spawned_overlay.color = O.color
		overlays += spawned_overlay

/mob/living/advanced/proc/update_inventory_icons()
	for(var/obj/inventory/I in inventory)
		if(!I.should_draw)
			continue
		for(var/obj/item/C in I.worn_objects)
			if(C.loc != I)
				continue

			C.update_icon()
			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = C.worn_layer
			spawned_overlay.icon = C.icon
			spawned_overlay.color = C.color

			if(C.slot_icons)
				spawned_overlay.icon_state = "[C.icon_state_worn]_[I.id]"
			else
				spawned_overlay.icon_state = C.icon_state_worn

			overlays += spawned_overlay
		for(var/obj/item/I2 in I.held_objects)
			if(I2.loc != I)
				continue

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


/mob/living/advanced/proc/add_species_colors()
	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			var/obj/item/organ/hair/H = O
			H.color = mob_species.hair_color_default
			H.hairstyle = mob_species.hair_style_default
		else if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			O.color = mob_species.eye_color_default
		else
			O.color = mob_species.skin_color_default

		O.update_icon()

/mob/living/advanced/proc/change_skin_color(var/new_color)

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			continue
		else if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			continue
		else
			O.color = new_color
			O.update_icon()

	update_icon()

/mob/living/advanced/proc/change_eye_color(var/new_color)

	for(var/obj/item/organ/O in organs)
		if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			O.color = new_color
			O.update_icon()

	update_icon()

/mob/living/advanced/proc/change_hair_color(var/new_color)

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			O.color = new_color
			O.update_icon()

	update_icon()

/mob/living/advanced/proc/update_gender(var/new_gender)
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/do_move(var/turf/new_loc,var/movement_override = 0)
	. = ..()
	if(.)
		add_attribute_xp(ATTRIBUTE_AGILITY,1)
		return TRUE
	else
		return FALSE