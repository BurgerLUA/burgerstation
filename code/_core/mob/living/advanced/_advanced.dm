/mob/living/advanced

	name = "lost soul"

	var/species/mob_species = /species/human/

	var/list/obj/item/organ/organs
	var/list/obj/item/organ/labeled_organs

	var/obj/item/automatic_left
	var/obj/item/automatic_right

	icon = 'icons/invisible.dmi'
	icon_state = "0"

	var/sex = MALE
	gender = MALE

	var/list/atom/tracked_overlays = list()

	var/draw_inventory = TRUE
	var/list/obj/inventory/inventory //List of inventory items
	var/list/obj/item/worn_objects //List of worn items. For use in an easy read-only list.
	var/obj/inventory/left_hand
	var/obj/inventory/right_hand

	var/is_typing = FALSE
	var/talk_duration = 0
	var/talk_type = 0

	var/life_ticks = 0

/mob/living/advanced/proc/do_type(var/type_type)
	talk_type = type_type
	talk_duration = SECONDS_TO_DECISECONDS(6)
	update_icon()

/mob/living/advanced/proc/start_typing()
	is_typing = TRUE
	update_icon()

/mob/living/advanced/proc/end_typing()
	is_typing = FALSE
	update_icon()

/mob/living/advanced/New(loc,desired_client)
	organs = list()
	inventory = list()
	worn_objects = list()
	labeled_organs = list()
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
	if(talk_duration)
		talk_duration = max(0,talk_duration-1)
		if(talk_duration <= 0)
			talk_type = 0
			update_icon()

	if(move_delay <= 0 && ( adjust_mana(mana_regeneration) || adjust_stamina(stamina_regeneration) ))
		update_health_elemement_icons()

	if(life_ticks >= 10*4)
		for(var/obj/item/organ/O in organs)
			for(var/wound/W in O.wounds)
				W.on_life()
		life_ticks = 0
	else
		life_ticks += 1

	return ..()

/mob/living/advanced/on_life_client()
	..()
	if(attack_flags & ATTACK_HELD_RIGHT)
		if(!do_automatic_left())
			attack_flags &= ~ATTACK_HELD_RIGHT

	if(attack_flags & ATTACK_HELD_LEFT)
		if(!do_automatic_right())
			attack_flags &= ~ATTACK_HELD_LEFT

/mob/living/advanced/Initialize()
	src << "Initializing character.."

	if(!client || client.userdata.loaded_data["tutorial"])
		add_species_organs()
		add_species_colors()
		update_icon()
	else
		client.userdata.apply_data_to_mob(src)

	add_species_buttons()
	add_species_health_elements()
	..()
	update_health_elemement_icons()

/mob/living/advanced/proc/adjust_mana(var/adjust_value)
	var/old_value = mana_current
	var/new_value = clamp(mana_current + adjust_value,0,mana_max)

	if(old_value != new_value)
		mana_current = new_value
		return TRUE

	return FALSE

/mob/living/advanced/proc/adjust_stamina(var/adjust_value)
	var/old_value = stamina_current
	var/new_value = clamp(stamina_current + adjust_value,0,stamina_max)

	if(old_value != new_value)
		stamina_current = new_value
		return TRUE

	return FALSE

/mob/living/advanced/proc/add_outfit(var/outfit_id)

	var/outfit/spawning_outfit = all_outfits[outfit_id]

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
		qdel(O)
	overlays = list()

	update_organ_icons()
	update_inventory_icons()
	update_faction_icons()
	update_talking_icons()
	. = ..()

/mob/living/advanced/proc/update_talking_icons()
	if(is_typing || talk_type)
		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = LAYER_EFFECT
		spawned_overlay.icon = 'icons/mob/living/advanced/overlays/talk.dmi'
		if(is_typing)
			spawned_overlay.icon_state = "talking"
		else
			spawned_overlay.icon_state = talk_type

		overlays += spawned_overlay

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
			behind_overlay.initial_icon = O.icon
			behind_overlay.initial_icon_state = "tail_behind"
			behind_overlay.color = O.color
			behind_overlay.additional_blends = O.additional_blends
			behind_overlay.update_icon()

			var/obj/overlay/front_overlay = new /obj/overlay
			front_overlay.layer = LAYER_MOB_TAIL_FRONT
			front_overlay.initial_icon = O.icon
			front_overlay.initial_icon_state = "tail_front"
			front_overlay.color = O.color
			front_overlay.additional_blends = O.additional_blends
			front_overlay.update_icon()

			overlays += front_overlay
			overlays += behind_overlay
			continue

		var/obj/overlay/spawned_overlay = new /obj/overlay
		spawned_overlay.layer = O.worn_layer
		spawned_overlay.initial_icon = O.icon
		spawned_overlay.initial_icon_state = O.icon_state
		spawned_overlay.color = O.color
		spawned_overlay.additional_blends = O.additional_blends
		spawned_overlay.update_icon()
		overlays += spawned_overlay

/mob/living/advanced/proc/update_inventory_icons()
	for(var/obj/inventory/I in inventory)
		if(!I.should_draw)
			continue
		for(var/obj/item/C in I.worn_objects)
			if(C.loc != I)
				continue

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

/mob/living/advanced/proc/add_species_colors()

	if(mob_species.default_color_skin)
		change_organ_visual("skin", desired_color = mob_species.default_color_skin)

	if(mob_species.default_color_eye)
		change_organ_visual("eye", desired_color = mob_species.default_color_eye)

	if(mob_species.default_color_hair && mob_species.default_icon_hair && mob_species.default_icon_state_hair)
		change_organ_visual("hair_head", desired_icon = mob_species.default_icon_hair, desired_icon_state = mob_species.default_icon_state_hair, desired_color = mob_species.default_color_hair)


	/*
	if(mob_species.default_color_detail)
		change_organ_visual("skin_detail", desired_color = mob_species.default_color_detail)

	if(mob_species.default_color_glow)
		change_organ_visual("skin_glow", desired_color = mob_species.default_color_glow)


	*/

	update_icon_organs()
	update_icon()

/mob/living/advanced/proc/change_organ_visual(var/desired_id, var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type)
	for(var/obj/item/organ/O in organs)
		if(!length(O.additional_blends))
			continue
		O.change_blend(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type)

/mob/living/advanced/proc/update_icon_organs()
	for(var/obj/item/organ/O in organs)
		O.update_icon()

/mob/living/advanced/proc/update_gender(var/new_gender)
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/proc/update_species()

	if(mob_species.genderless)
		gender = NEUTER

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

/mob/living/advanced/proc/get_held_left()
	if(left_hand)
		return left_hand.get_top_held_object()
	return null

/mob/living/advanced/proc/get_held_right()
	if(right_hand)
		return right_hand.get_top_held_object()
	return null