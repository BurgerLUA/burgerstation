/mob/living/advanced

	name = "lost soul"

	var/species/mob_species = /species/human/

	var/list/obj/item/organ/organs
	var/list/obj/item/organ/labeled_organs

	var/obj/item/automatic_left
	var/obj/item/automatic_right

	/*
	icon = 'icons/invisible.dmi'
	icon_state = "0"
	*/

	var/sex = MALE
	gender = MALE

	var/list/atom/tracked_overlays = list()

	var/draw_inventory = TRUE
	var/list/obj/hud/inventory/inventory //List of inventory items
	var/list/obj/item/worn_objects //List of worn items. For use in an easy read-only list.
	var/list/obj/item/held_objects

	var/obj/hud/click_and_drag/click_and_drag_icon

	var/obj/hud/inventory/left_hand
	var/obj/hud/inventory/right_hand

	var/is_typing = FALSE

	health_base = 100
	stamina_base = 100
	mana_base = 100

	var/talk_duration = 0
	var/talk_type = 0

	var/automatic_ticks = 0

	var/chargen = FALSE //In the chargen area
	var/appearance_changed = FALSE
	var/job_changed = FALSE
	var/clothing_changed = FALSE
	var/underwear_added = FALSE
	var/used_mirror = FALSE
	var/found_job = FALSE

	var/obj/hud/inventory/active_inventory

	var/health_regen_delay = 0
	var/stamina_regen_delay = 0
	var/mana_regen_delay = 0

	var/obj/vehicle/driving

	var/quick_mode = null

	stun_angle = 90

	random_spawn_dir = FALSE

	has_footsteps = TRUE
	has_footprints = TRUE

	var/slowdown_mul = 1

	var/has_hard_crit = FALSE

	var/list/overlays_assoc

	var/list/protection_heat = TARGETABLE_LIMBS_KV

	var/list/protection_cold = TARGETABLE_LIMBS_KV

	var/list/protection_pressure = TARGETABLE_LIMBS_KV

/mob/living/advanced/proc/update_slowdown_mul()

	for(var/obj/item/I in worn_objects)
		slowdown_mul *= I.slowdown_mul_worn

	for(var/obj/item/I in held_objects)
		slowdown_mul *= I.slowdown_mul_held

	slowdown_mul = Clamp(slowdown_mul,0.5,4)

/mob/living/advanced/destroy()
	inventory.Cut()
	held_objects = null
	worn_objects = null
	left_hand = null
	right_hand = null
	active_inventory = null
	driving = null
	return ..()

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

/mob/living/advanced/New(loc,desired_client,desired_level_multiplier)
	icon = 'icons/invisible.dmi'
	icon_state = "0"
	organs = list()
	inventory = list()
	held_objects = list()
	worn_objects = list()
	labeled_organs = list()
	overlays_assoc = list()

	if(mob_species)
		mob_species = new mob_species

	..()

	click_and_drag_icon	= new(src)

/mob/living/advanced/Logout()
	..()
	if(chargen)
		qdel(src)

/mob/living/advanced/on_stunned()

	if(left_hand)
		left_hand.drop_held_objects(src.loc)

	if(right_hand)
		right_hand.drop_held_objects(src.loc)

	return ..()

/mob/living/advanced/proc/drop_all_items(var/exclude_soulbound=FALSE,var/exclude_containers=FALSE)

	var/dropped_objects = list()

	for(var/v in inventory)
		var/obj/hud/inventory/O = v
		if(is_item(O.loc))
			var/obj/item/I = O.loc
			if(I.is_container)
				continue

		dropped_objects += O.drop_all_objects(get_turf(src))

	return dropped_objects

/mob/living/advanced/proc/delete_all_items()
	for(var/v in inventory)
		var/obj/hud/inventory/O = v
		O.delete_all_objects()

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

/mob/living/advanced/adjust_brute_loss(var/value)
	var/obj/item/organ/torso = labeled_organs[BODY_TORSO]
	return torso.adjust_brute_loss(value)

/mob/living/advanced/adjust_tox_loss(var/value)
	var/obj/item/organ/torso = labeled_organs[BODY_TORSO]
	return torso.adjust_tox_loss(value)

/mob/living/advanced/adjust_oxy_loss(var/value)
	var/obj/item/organ/torso = labeled_organs[BODY_TORSO]
	return torso.adjust_oxy_loss(value)

/mob/living/advanced/adjust_burn_loss(var/value)
	var/obj/item/organ/torso = labeled_organs[BODY_TORSO]
	return torso.adjust_burn_loss(value)

/mob/living/advanced/on_life_client()

	..()

	if(automatic_ticks != 0)
		automatic_ticks = Clamp(automatic_ticks - 1,0,5)
	else

		var/set_tick = FALSE

		if(attack_flags & ATTACK_HELD_RIGHT)
			if(!do_automatic_left())
				attack_flags &= ~ATTACK_HELD_RIGHT
			else
				set_tick = TRUE

		if(attack_flags & ATTACK_HELD_LEFT)
			if(!do_automatic_right())
				attack_flags &= ~ATTACK_HELD_LEFT
			else
				set_tick = TRUE

		if(set_tick)
			automatic_ticks = 5


/mob/living/advanced/Initialize()

	if(!client || client.savedata.loaded_data["tutorial"])
		add_species_organs()
		add_species_colors()
		update_icon()
	else
		client.savedata.apply_data_to_mob(src)

	if(client)
		add_species_buttons()
		add_species_health_elements()

	. = ..()

	if(client)
		update_health_element_icons(TRUE,TRUE,TRUE)

	update_all_blends()

	return

/mob/living/advanced/proc/perform_sexchange(var/desired_sex,var/keep_clothes,var/chargen)

	if(sex == desired_sex)
		return FALSE

	sex = desired_sex
	gender = desired_sex

	var/list/kept_clothes = list()

	if(!keep_clothes)
		for(var/obj/hud/inventory/I in inventory)
			I.remove_all_objects()
	else
		for(var/obj/hud/inventory/I in inventory)
			kept_clothes += I.drop_all_objects()

	remove_all_organs()
	add_species_organs()
	add_species_colors()
	update_icon()
	update_health_element_icons(TRUE,TRUE,TRUE)

	if(chargen)
		show_hud(FALSE,FLAGS_HUD_ALL,speed=0)
		show_hud(TRUE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=3)
	else
		show_inventory(TRUE,FLAGS_HUD_WORN,FLAGS_HUD_SPECIAL,0.1)
		for(var/obj/hud/button/hide_show_inventory/B in buttons)
			B.update_icon()

	handle_hairstyle_chargen(sex == MALE ? 2 : 16,"#000000")
	handle_beardstyle_chargen(1,"#000000")
	//Blends are updated in the above two procs

	if(keep_clothes)
		for(var/obj/item/I in kept_clothes)
			add_worn_item(I)
	else
		if(sex == MALE)
			add_outfit("new_male",TRUE)
		else
			add_outfit("new_female",TRUE)

	return TRUE

/mob/living/advanced/proc/heal_all_organs(var/brute,var/burn,var/tox,var/oxy) //TODO: FIX THIS, IT'S BROKEN.

	var/list/damaged_organs = list()

	var/total_brute = 0
	var/total_burn = 0
	var/total_tox = 0
	var/total_oxy = 0

	for(var/organ_id in labeled_organs)

		var/obj/item/organ/O = labeled_organs[organ_id]

		var/brute_loss = O.get_brute_loss()
		var/burn_loss = O.get_burn_loss()
		var/tox_loss = O.get_tox_loss()
		var/oxy_loss = O.get_oxy_loss()

		damaged_organs[organ_id] = list()

		if(brute_loss)
			damaged_organs[organ_id][BRUTE] = brute_loss

		if(burn_loss)
			damaged_organs[organ_id][BURN] = burn_loss

		if(tox_loss)
			damaged_organs[organ_id][TOX] = tox_loss

		if(oxy_loss)
			damaged_organs[organ_id][OXY] = oxy_loss

		total_brute += brute_loss
		total_burn += burn_loss
		total_tox += tox_loss
		total_oxy += oxy_loss

	var/total_healed = 0

	for(var/organ_id in damaged_organs)
		var/obj/item/organ/O = labeled_organs[organ_id]
		if(damaged_organs[organ_id][BRUTE] && total_brute > 0 && brute > 0)
			var/heal_amount = (damaged_organs[organ_id][BRUTE] / total_brute) * brute
			O.adjust_brute_loss(-heal_amount)
			total_healed += heal_amount
		if(damaged_organs[organ_id][BURN]  && total_burn > 0 && burn > 0)
			var/heal_amount = (damaged_organs[organ_id][BURN] / total_burn) * burn
			O.adjust_burn_loss(-heal_amount)
			total_healed += heal_amount
		if(damaged_organs[organ_id][TOX]  && total_tox > 0 && tox > 0)
			var/heal_amount = (damaged_organs[organ_id][TOX] / total_tox) * tox
			O.adjust_tox_loss(-heal_amount)
			total_healed += heal_amount
		if(damaged_organs[organ_id][OXY]  && total_oxy > 0 && oxy > 0)
			var/heal_amount = (damaged_organs[organ_id][OXY] / total_oxy) * oxy
			O.adjust_oxy_loss(-heal_amount)
			total_healed += heal_amount
		O.update_health()

	update_health(-total_healed,src,do_update = FALSE)

	return total_healed

/mob/living/advanced/proc/add_outfit(var/outfit_id,var/soul_bound=FALSE)

	var/outfit/spawning_outfit = all_outfits[outfit_id]

	if(!spawning_outfit)
		return FALSE

	for(var/key in spawning_outfit.spawning_clothes)
		var/obj/item/clothing/C = new key(get_turf(src))
		add_worn_item(C)
		if(soul_bound)
			C.soul_bound = TRUE

	return TRUE

/mob/living/advanced/proc/add_worn_item(var/obj/item/clothing/C)
	for(var/obj/hud/inventory/I in inventory)
		if(I.add_worn_object(C,FALSE))
			return TRUE

	return FALSE

/mob/living/advanced/proc/remove_worn_item(var/obj/item/clothing/C)
	for(var/obj/hud/inventory/I in inventory)
		if(I.remove_object(C))
			return TRUE

	return FALSE

/mob/living/advanced/proc/add_species_colors()

	if(mob_species.default_color_skin)
		change_organ_visual("skin", desired_color = mob_species.default_color_skin)

	if(mob_species.default_color_eye)
		change_organ_visual("eye", desired_color = mob_species.default_color_eye)

	if(mob_species.default_color_hair && mob_species.default_icon_hair && mob_species.default_icon_state_hair)
		change_organ_visual("hair_head", desired_icon = mob_species.default_icon_hair, desired_icon_state = mob_species.default_icon_state_hair, desired_color = mob_species.default_color_hair)
		change_organ_visual("hair_face", desired_color = mob_species.default_color_hair)

	if(mob_species.default_color_detail)
		change_organ_visual("skin_detail", desired_color = mob_species.default_color_detail)

	if(mob_species.default_color_glow)
		change_organ_visual("skin_glow", desired_color = mob_species.default_color_glow)

/mob/living/advanced/proc/change_organ_visual(var/desired_id, var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type,var/desired_layer,var/debug_message)
	for(var/obj/item/organ/O in organs)
		if(!length(O.additional_blends))
			continue
		O.change_blend(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_layer, debug_message)

/mob/living/advanced/proc/update_gender()
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/proc/update_species()

	if(mob_species.genderless)
		gender = NEUTER

	update_gender()

/mob/living/advanced/can_sprint()
	if(stamina_current <= 0)
		return FALSE

	return ..()

/* OLD MOVEMENT
/mob/living/advanced/do_move(var/turf/new_loc,var/movement_override = 0)
	. = ..()
	if(.)
		add_skill_xp(SKILL_ATHLETICS,1)
		stamina_current = max(0,stamina_current - 1)
		return .
	else
		return FALSE
*/

/mob/living/advanced/proc/pickup(var/obj/item/I,var/left = FALSE)

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