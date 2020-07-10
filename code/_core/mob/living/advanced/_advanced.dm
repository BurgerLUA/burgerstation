#define DEFAULT_NAME "Your name here."

/mob/living/advanced

	name = DEFAULT_NAME
	var/real_name

	var/species = "human"

	var/list/obj/item/organ/organs
	var/list/obj/item/organ/labeled_organs

	var/sex = MALE
	gender = MALE

	var/draw_inventory = TRUE
	var/list/obj/hud/inventory/inventory //List of inventory items
	var/list/obj/item/worn_objects //List of worn items. For use in an easy read-only list.
	var/list/obj/item/held_objects //List of held items. For use in an easy read-only list.

	var/obj/hud/inventory/left_hand
	var/obj/hud/inventory/right_hand

	var/obj/item/left_item
	var/obj/item/right_item

	health_base = 200
	stamina_base = 100
	mana_base = 100

	var/automatic_ticks = 0

	var/obj/hud/inventory/active_inventory

	var/health_regen_delay = 0
	var/stamina_regen_delay = 0
	var/mana_regen_delay = 0

	var/mob/living/vehicle/driving

	var/quick_mode = null

	random_spawn_dir = FALSE

	has_footprints = TRUE

	var/slowdown_mul = 1

	var/has_hard_crit = FALSE

	var/list/overlays_assoc

	var/list/protection_heat = TARGETABLE_LIMBS_KV
	var/list/protection_cold = TARGETABLE_LIMBS_KV
	var/list/protection_pressure = TARGETABLE_LIMBS_KV

	var/list/known_wishgranters = list() //ID based.

	health = /health/mob/living/advanced

	//Read only values. Don't change these.
	var/capacity = 0
	var/max_capacity = 1

	attack_delay = 2
	attack_delay_max = 6

	var/list/tracked_hidden_organs
	var/tracked_hidden_clothing = 0x0

	value = 500

	stun_angle = -90

	var/cqc = ""

	var/list/known_cqc = list()

	mob_size = MOB_SIZE_HUMAN

	max_level = 100 //Max level for skills and attributes of the mob.

	movement_delay = DECISECONDS_TO_TICKS(2)

	var/handcuffed = FALSE
	var/handcuff_break_counter = 0
	var/obj/item/handcuffs/stored_handcuffs

	armor_base = list()

/mob/living/advanced/Destroy()

	remove_all_organs()
	remove_all_buttons()

	inventory.Cut()
	overlays_assoc.Cut()
	tracked_hidden_organs.Cut()

	held_objects = null
	worn_objects = null
	left_hand = null
	right_hand = null
	left_item = null
	right_item = null
	active_inventory = null
	driving = null

	QDEL_NULL(stored_handcuffs)

	return ..()

/mob/living/advanced/proc/update_clothes() //Avoid using?

	tracked_hidden_organs = list()

	for(var/obj/item/clothing/C in worn_objects)
		if(C.hidden_clothing)
			tracked_hidden_clothing |= C.hidden_clothing
		if(C.hidden_organs)
			tracked_hidden_organs |= C.hidden_organs

	var/do_organs = length(tracked_hidden_organs)
	var/do_clothing = tracked_hidden_clothing != 0x0

	for(var/k in overlays_assoc)
		var/image/overlay/O = overlays_assoc[k]
		var/obj/item/I = O.attached_object
		if(is_organ(I))
			var/obj/item/organ/OR = I
			show_overlay(k, (do_organs && tracked_hidden_organs[OR.id]) ? FALSE : TRUE)
		else if(is_clothing(I))
			var/obj/item/clothing/C = I
			show_overlay(k, (do_clothing && C.item_slot & tracked_hidden_clothing) ? FALSE : TRUE)

	return TRUE

/mob/living/advanced/update_eyes()

	. = ..()

	for(var/obj/item/organ/eye/E in labeled_organs)
		sight |= E.sight_mod
		vision |= E.vision_mod
		see_invisible = max(E.see_invisible,see_invisible)

	for(var/obj/item/clothing/glasses/G in worn_objects)
		sight |= G.sight_mod
		vision |= G.vision_mod
		see_invisible = max(G.see_invisible,see_invisible)

	return .

/mob/living/advanced/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(. || force) //Dan updating.
		if(left_hand && left_item && left_item.dan_mode)
			left_hand.update_held_icon(left_item)
		if(right_hand && right_item && right_item.dan_mode)
			right_hand.update_held_icon(right_item)

	return .

/mob/living/advanced/proc/update_slowdown_mul()

	if(qdeleting) //Bandaid fix.
		return FALSE

	capacity = 0

	var/slow_mul = 1

	for(var/obj/item/I in worn_objects)
		slow_mul *= I.slowdown_mul_worn
		capacity += I.weight

	for(var/obj/item/I in held_objects)
		if(is_inventory(I.loc))
			var/obj/hud/inventory/I2 = I.loc
			if(I2.click_flags & RIGHT_HAND || I2.click_flags & LEFT_HAND)
				slow_mul *= I.slowdown_mul_held

		capacity += I.weight

	max_capacity = 100 + get_attribute_power(ATTRIBUTE_ENDURANCE)*400

	var/carry_mod = 1 + (max(0,(capacity/max_capacity) - 0.5))**2

	if(ai)
		slowdown_mul = 1
	else
		slowdown_mul = clamp(slow_mul * carry_mod,0.75,4)

	return TRUE

/mob/living/advanced/New(loc,desired_client,desired_level_multiplier)

	real_name = name

	icon = 'icons/invisible.dmi'
	icon_state = "0"

	organs = list()
	inventory = list()
	held_objects = list()
	worn_objects = list()
	labeled_organs = list()
	overlays_assoc = list()
	tracked_hidden_organs = list()

	. = ..()

	return .

/mob/living/advanced/proc/drop_all_items(var/atom/drop_location = get_turf(src), var/exclude_soulbound=FALSE,var/exclude_containers=FALSE)

	var/dropped_objects = list()

	for(var/obj/hud/inventory/organs/O in inventory)
		if(exclude_containers && is_item(O.loc))
			var/obj/item/I = O.loc
			if(I.is_container)
				continue
		dropped_objects += O.drop_all_objects(drop_location,exclude_soulbound)

	return dropped_objects

/mob/living/advanced/proc/delete_all_items()
	for(var/v in inventory)
		var/obj/hud/inventory/O = v
		O.delete_all_objects()

/mob/living/advanced/proc/equip_objects_in_list(var/list/clothing_list)
	for(var/obj/item/clothing/C in clothing_list)
		C.quick_equip(src)

mob/living/advanced/Login()
	. = ..()
	restore_buttons()
	restore_inventory()
	restore_health_elements()
	restore_local_machines()
	update_health_element_icons(TRUE,TRUE,TRUE,TRUE)
	return .

/mob/living/advanced/proc/restore_local_machines()
	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)

/mob/living/advanced/proc/apply_mob_parts(var/teleport=TRUE,var/do_load=TRUE,var/update_blends=TRUE)
	add_species_languages()
	add_species_organs()
	add_species_colors()
	return TRUE

/mob/living/advanced/Initialize()

	add_overlay_tracked("handcuffs", desired_icon = 'icons/mob/living/advanced/overlays/handcuffs.dmi', desired_icon_state = "none")

	. = ..()

	apply_mob_parts(TRUE,TRUE,TRUE)

	setup_name()

	return .

/mob/living/advanced/PostInitialize()

	. = ..()

	if(client)
		update_health_element_icons(TRUE,TRUE,TRUE,TRUE)
		add_species_buttons()
		add_species_health_elements()

	update_slowdown_mul()

	update_clothes()

	return .


/mob/living/advanced/setup_name()

	if(name == DEFAULT_NAME) //Give a human name
		name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
		real_name = name
		return TRUE

	real_name = name

	return ..()

/mob/living/advanced/proc/equip_loadout(var/loadout_id,var/soul_bound=FALSE)

	var/loadout/spawning_outfit = all_loadouts[loadout_id]
	if(!spawning_outfit)
		return FALSE

	var/list/items_to_add = spawning_outfit.get_spawning_items()

	var/list/added_items = list()

	for(var/key in items_to_add)
		var/obj/item/I = new key(get_turf(src))
		if(istype(I))
			spawning_outfit.pre_add(src,I)
			INITIALIZE(I)
			GENERATE(I)
			if(spawning_outfit.on_add(src,I))
				added_items += I
		else
			log_error("Warning! Tried to spawn object [key] in equip_loadout(), but something went wrong!")

	spawning_outfit.post_add(src,added_items)

	return TRUE

/mob/living/advanced/proc/add_worn_item(var/obj/item/C)
	for(var/obj/hud/inventory/I in inventory)
		if(I.add_worn_object(C,FALSE))
			return TRUE

	return FALSE

/mob/living/advanced/proc/remove_worn_item(var/obj/item/C)
	for(var/obj/hud/inventory/I in inventory)
		if(I.remove_object(C))
			return TRUE

	return FALSE

/mob/living/advanced/proc/add_species_languages()

	known_languages.Cut()

	var/species/S = all_species[species]

	for(var/language in S.languages)
		known_languages[language] = TRUE

/mob/living/advanced/proc/add_species_colors()

	var/species/S = all_species[species]

	if(S.default_color_skin)
		change_organ_visual("skin", desired_color = S.default_color_skin)

	if(S.default_color_eye)
		change_organ_visual("eye", desired_color = S.default_color_eye)

	if(S.default_color_hair && S.default_icon_hair && S.default_icon_state_hair)
		change_organ_visual("hair_head", desired_icon = S.default_icon_hair, desired_icon_state = S.default_icon_state_hair, desired_color = S.default_color_hair, desired_layer = LAYER_MOB_HAIR_HEAD)
		change_organ_visual("hair_face", desired_color = S.default_color_hair, desired_layer = LAYER_MOB_HAIR_HEAD)

	if(S.default_color_detail)
		change_organ_visual("skin_detail", desired_color = S.default_color_detail)

	if(S.default_color_glow)
		change_organ_visual("skin_glow", desired_color = S.default_color_glow)

	if(S.default_blood_color)
		blood_color = S.default_blood_color

/mob/living/advanced/proc/change_organ_visual(var/desired_id, var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type,var/desired_layer,var/debug_message)
	for(var/obj/item/organ/O in organs)
		if(!length(O.additional_blends))
			continue
		if(O.additional_blends[desired_id])
			O.add_blend(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_layer, debug_message)

/mob/living/advanced/proc/update_gender()
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/proc/update_species()

	var/species/S = all_species[species]

	if(S.genderless)
		gender = NEUTER

	update_gender()

/mob/living/advanced/can_sprint()

	if(!health)
		return ..()

	if(health.stamina_current <= 0)
		return FALSE

	var/list/organs_to_check = list(
		BODY_FOOT_RIGHT,
		BODY_FOOT_LEFT,
		BODY_LEG_LEFT,
		BODY_LEG_RIGHT
	)

	for(var/k in organs_to_check)
		var/obj/item/organ/O = labeled_organs[k]
		if(O.health && O.health.health_current <= 0)
			return FALSE

	return ..()

/mob/living/advanced/proc/put_in_hands(var/obj/item/I,var/left = FALSE)

	if(left_hand && right_hand)
		if(left && left_hand.can_hold_object(I,FALSE))
			return left_hand.add_object(I)
		if(!left && right_hand.can_hold_object(I,FALSE))
			return right_hand.add_object(I)
	else
		if(left_hand)
			return left_hand.add_object(I)
		else if(right_hand)
			return right_hand.add_object(I)

	return FALSE

/mob/living/advanced/proc/get_held_left()
	if(left_hand)
		return left_hand.get_top_held_object()
	return null

/mob/living/advanced/proc/get_held_right()
	if(right_hand)
		return right_hand.get_top_held_object()
	return null