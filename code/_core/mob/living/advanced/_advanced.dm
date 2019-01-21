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

	var/draw_inventory = TRUE
	var/list/obj/inventory/inventory //List of inventory items
	var/list/obj/item/worn_objects //List of worn items. For use in an easy read-only list.
	var/obj/inventory/left_hand
	var/obj/inventory/right_hand

/mob/living/advanced/New()
	organs = list()
	inventory = list()
	worn_objects = list()
	labeled_organs = list()
	if(mob_outfit)
		mob_outfit = new mob_outfit
	if(mob_species)
		mob_species = new mob_species
	..()

/mob/living/advanced/on_stunned()
	if(left_hand)
		left_hand.drop_held_objects(src.loc)

	if(right_hand)
		right_hand.drop_held_objects(src.loc)

/mob/living/advanced/do_step(var/turf/new_loc, var/movement_override = 0)

	. = ..()

	var/movement_delay = get_movement_delay()

	if(left_hand)
		left_hand.do_drag(.,movement_override ? movement_override : movement_delay)

	if(right_hand)
		right_hand.do_drag(.,movement_override ? movement_override : movement_delay)

/mob/living/advanced/proc/toggle_inventory()
	draw_inventory = !draw_inventory
	for(var/v in inventory)
		var/obj/inventory/O = v
		if(!draw_inventory && !O.essential)
			O.invisibility = 101
		else
			O.invisibility = 0

	update_icon()

/mob/living/advanced/proc/drop_all_items()

	var/dropped_objects = list()

	for(var/v in inventory)
		var/obj/inventory/O = v
		for(var/obj/item/I in O.worn_objects)
			if(O.remove_object(I,src.loc))
				dropped_objects += I

		O.drop_held_objects(src.loc)

	return dropped_objects

/mob/living/advanced/proc/equip_objects_in_list(var/list/clothing_list)
	for(var/obj/item/clothing/C in clothing_list)
		C.quick_equip(src)

mob/living/advanced/Login()
	..()
	if(loc != null)
		restore_buttons()
		restore_inventory()
		restore_health_elements()
		restore_local_machines()

/mob/living/advanced/proc/restore_local_machines()
	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)

/mob/living/advanced/on_life()
	..()
	update_health_elemement_icons()
	return ..()

/mob/living/advanced/on_life_client()
	..()
	if(attack_flags & ATTACK_HELD_RIGHT)
		do_automatic_left()
	if(attack_flags & ATTACK_HELD_LEFT)
		do_automatic_right()

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
		add_clothes(mob_outfit)
		update_icon()
	else
		client.userdata.apply_data_to_mob(src)

	add_species_buttons()
	add_species_health_elements()
	update_health()

	..()

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

	icon = initial(icon)

	for(var/O in overlays)
		O = null
		del(O)
	overlays = list()

	update_organ_icons()
	update_inventory_icons()
	update_faction_icons()

	. = ..()

/mob/living/advanced/proc/update_faction_icons()
	for(var/v in factions)
		var/faction/F = all_factions[v]
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = F.icon
		spawned_overlay.icon_state = F.icon_state
		overlays += spawned_overlay

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

			//C.update_icon()
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
			if(I2.no_held_draw)
				continue

			//I2.update_icon()
			var/obj/overlay/spawned_overlay = new /obj/overlay
			spawned_overlay.layer = LAYER_MOB_HELD
			spawned_overlay.icon = I2.icon
			spawned_overlay.color = I2.color
			if(I.item_slot == SLOT_HAND_LEFT)
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_left
			else
				spawned_overlay.icon_state = I.reverse_draw ? I2.icon_state_worn : I2.icon_state_held_right

			overlays += spawned_overlay

/mob/living/advanced/proc/update_health_elemement_icons()
	for(var/k in health_elements)
		var/obj/health/H = health_elements[k]
		H.update_stats(src)
		H.update_icon()

/mob/living/advanced/proc/add_species_colors()
	change_color_skin(mob_species.color_skin_default,mob_species.color_secondary_default,mob_species.color_glow_default)
	change_color_eye(mob_species.eye_color_default)
	change_hair_style(mob_species.hair_style_default)
	change_color_hair(mob_species.color_hair_default)

/mob/living/advanced/proc/change_color_skin(var/new_color,var/update = TRUE)

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			continue
		else if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			continue
		else
			O.color_skin = new_color
			if(update) O.update_icon()

	if(update) update_icon()


/mob/living/advanced/proc/change_secondary_color(var/new_color, var/update = TRUE)

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			continue
		else if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			continue
		else
			O.color_secondary = new_color
			if(update) O.update_icon()

	if(update) update_icon()

/mob/living/advanced/proc/change_glow_color(var/new_color, var/update = TRUE)

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			continue
		else if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			continue
		else
			O.color_glow = new_color
			if(update) O.update_icon()

	if(update) update_icon()

/mob/living/advanced/proc/change_color_eye(var/new_color, var/update = TRUE)

	for(var/obj/item/organ/O in organs)
		if(O.id == BODY_EYE_RIGHT || O.id == BODY_EYE_LEFT)
			O.color_skin = new_color
			if(update) O.update_icon()

	if(update) update_icon()

/mob/living/advanced/proc/change_color_hair(var/new_color, var/update = TRUE)

	src << new_color

	for(var/obj/item/organ/O in organs)
		if(is_hair(O))
			O.color_skin = new_color
			if(update) O.update_icon()

	if(update) update_icon()

/mob/living/advanced/proc/change_hair_style(var/new_style, var/update = TRUE)
	var/obj/item/organ/hair/H = labeled_organs[BODY_HAIR_HEAD]
	if(H)
		H.style = new_style
		if(update) H.update_icon()

	if(update) update_icon()

/mob/living/advanced/proc/update_gender(var/new_gender)
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/proc/update_species()
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/can_sprint()
	if(stamina_current <= 5)
		return FALSE

	return ..()

/mob/living/advanced/do_move(var/turf/new_loc,var/movement_override = 0)
	. = ..()
	if(.)
		add_skill_xp(SKILL_ATHLETICS,1)
		stamina_current = max(0,stamina_current - 1)
		return .
	else
		return FALSE

/mob/living/advanced/proc/pickup(var/obj/item/I,var/left = 0)

	if(left_hand && right_hand)
		if(left)
			return left_hand.add_held_object(I)
		else
			return right_hand.add_held_object(I)
	else
		if(left_hand)
			return left_hand.add_held_object(I)
		else if(right_hand)
			return right_hand.add_held_object(I)

	return FALSE

