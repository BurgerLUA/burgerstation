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
	var/obj/hud/inventory/holster
	var/obj/hud/inventory/face

	var/obj/item/left_item
	var/obj/item/right_item
	var/obj/item/holster_item

	var/list/obj/hud/button/slot/slot_buttons = list()

	health_base = 100
	stamina_base = 100
	mana_base = 100

	var/automatic_ticks = 0

	var/obj/hud/inventory/active_inventory

	var/mob/living/vehicle/driving

	random_spawn_dir = FALSE

	has_footprints = TRUE

	var/move_delay_multiplier = 1

	var/has_hard_crit = FALSE

	var/list/overlays_assoc

	var/list/protection_heat = TARGETABLE_LIMBS_KV
	var/list/protection_cold = TARGETABLE_LIMBS_KV
	var/list/protection_pressure = TARGETABLE_LIMBS_KV

	health = /health/mob/living/advanced

	var/list/tracked_hidden_organs
	var/tracked_hidden_clothing = 0x0

	value = 500

	stun_angle = -90

	var/cqc = ""

	var/list/known_cqc = list()

	size = SIZE_HUMAN

	max_level = 100 //Base max level for skills and attributes of the mob.

	death_threshold = -50

	var/handcuffed = FALSE
	var/handcuff_break_counter = 0
	var/obj/item/handcuffs/stored_handcuffs

	armor_base = list()

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		ION = 0,
		PAIN = 0,
		SANITY = 0
	)

	enable_security_hud = TRUE
	enable_medical_hud = TRUE

	var/list/using_inventories = list() //A list of /obj/items with inventories this mob is using.

	var/list/inventory_defers = list() //A list of inventory defer buttons.
	var/evasion_rating = 0

	var/mood // On a scale of 0 to 200, with 100 being normal. Stabilizes to 100.
	var/last_mood_gain = 0

/mob/living/advanced/Destroy()

	remove_all_organs()
	remove_all_buttons()

	inventory_defers?.Cut()

	overlays_assoc?.Cut()
	tracked_hidden_organs?.Cut()
	slot_buttons?.Cut()

	held_objects = null
	worn_objects = null
	left_hand = null
	right_hand = null
	holster = null
	left_item = null
	right_item = null
	holster_item = null
	active_inventory = null
	driving = null

	for(var/k in using_inventories)
		var/obj/item/I = k
		I.close_inventory(src)

	using_inventories?.Cut()

	QDEL_NULL(stored_handcuffs)

	return ..()

/mob/living/advanced/Finalize()

	var/species/S = SPECIES(species)
	if(!(blood_type in S.valid_blood_types))
		blood_type = S.generate_blood_type()

	. = ..()

	update_items(force=TRUE)

/mob/living/advanced/on_crush()
	if(driving)
		return FALSE
	drop_all_items(get_turf(src))
	return ..()

/mob/living/advanced/proc/update_clothes()

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

	for(var/obj/item/organ/eye/E in organs)
		sight |= E.sight_mod
		vision |= E.vision_mod
		see_invisible = max(E.see_invisible,see_invisible)
		see_in_dark = max(see_in_dark,E.see_in_dark)

	for(var/obj/item/clothing/glasses/G in worn_objects)
		sight |= G.sight_mod
		vision |= G.vision_mod
		see_invisible = max(G.see_invisible,see_invisible)
		see_in_dark = max(see_in_dark,G.see_in_dark)

/mob/living/advanced/set_dir(var/desired_dir,var/force=FALSE)

	if(driving)
		desired_dir = driving.dir

	if(!force && grabbing_hand)
		return FALSE

	. = ..()

	if(. || force) //Dan updating.
		if(left_hand && left_item && left_item.dan_mode)
			left_hand.update_held_icon(left_item)
		if(right_hand && right_item && right_item.dan_mode)
			right_hand.update_held_icon(right_item)
		if(holster && holster_item && holster_item.dan_mode)
			holster.update_held_icon(holster_item)

/mob/living/advanced/proc/update_items(var/force=FALSE,var/should_update_speed=TRUE,var/should_update_eyes=TRUE,var/should_update_protection=TRUE,var/should_update_clothes=TRUE) //Sent when an item needs to update.

	if(qdeleting) //Bandaid fix.
		return FALSE

	if(!force && !finalized)
		return FALSE //Don't want to call this too much during initializations.

	if(should_update_speed) //Weight too.
		update_speed()
	if(should_update_eyes)
		update_eyes()
	if(should_update_protection)
		update_protection()
	if(should_update_clothes)
		update_clothes()

	return TRUE

/mob/living/advanced/proc/update_speed()

	var/total_weight = 0
	var/max_weight = 50 + get_attribute_power(ATTRIBUTE_ENDURANCE)*450

	. = 1 //The lower the value, the faster you are.

	for(var/obj/item/clothing/C in worn_objects)
		. -= C.speed_bonus
		total_weight += C.weight

	. *= 1 + (total_weight/max_weight)

	. = FLOOR(max(0.25,.),0.01)

	move_delay_multiplier = .

	//Evasion stuff
	evasion_rating = max(0,0.5 - total_weight/max_weight)*100*(0.25 + get_skill_power(SKILL_EVASION,0,1,2)*0.75)
	if(ckey_last) //Player controlled
		evasion_rating = clamp(evasion_rating,0,75)
	else
		evasion_rating = clamp(evasion_rating*0.25,0,25)

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

/mob/living/advanced/proc/drop_all_items(var/atom/drop_location = get_turf(src), var/exclude_soulbound=FALSE,var/exclude_containers=TRUE)

	. = list()

	for(var/obj/hud/inventory/organs/O in inventory)
		if(exclude_containers && is_item(O.loc))
			var/obj/item/I = O.loc
			if(I.is_container)
				continue
		. += O.drop_objects(drop_location,exclude_soulbound)

	return .

/mob/living/advanced/proc/delete_all_items()
	for(var/v in inventory)
		var/obj/hud/inventory/O = v
		O.delete_objects()

/mob/living/advanced/proc/equip_objects_in_list(var/list/clothing_list)
	for(var/k in clothing_list)
		var/obj/item/clothing/C = k
		C.quick_equip(src,silent=TRUE)

mob/living/advanced/Login()
	. = ..()
	restore_buttons()
	restore_inventory()
	restore_health_elements()
	restore_local_machines()
	update_health_element_icons(TRUE,TRUE,TRUE)

/mob/living/advanced/proc/restore_local_machines()
	for(var/k in local_machines)
		var/obj/structure/interactive/localmachine/L = k
		L.update_for_mob(src)

/mob/living/advanced/proc/apply_mob_parts(var/teleport=TRUE,var/do_load=TRUE,var/update_blends=TRUE)
	add_species_languages()
	add_species_organs()
	add_species_colors()
	return TRUE

/mob/living/advanced/Initialize()

	add_overlay_tracked("handcuffs", desired_icon = 'icons/mob/living/advanced/overlays/handcuffs.dmi', desired_icon_state = "none", desired_layer = 100)

	var/species/S = SPECIES(species)
	if(S && S.health)
		health = S.health

	. = ..()

	if(client)
		add_slot_buttons()

	apply_mob_parts(TRUE,TRUE,TRUE)

	if(client)
		add_species_buttons()

/mob/living/advanced/PostInitialize()

	. = ..()

	if(client)
		update_health_element_icons(TRUE,TRUE,TRUE)
		add_species_health_elements()

/mob/living/advanced/Finalize()
	. = ..()
	update_items()

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
			FINALIZE(I)
			if(spawning_outfit.on_add(src,I))
				added_items += I
		else
			log_error("Warning! Tried to spawn object [key] in equip_loadout(), but something went wrong!")

	spawning_outfit.post_add(src,added_items)

	return TRUE

/* UNUSED
/mob/living/advanced/proc/add_worn_item(var/obj/item/C,var/slient=FALSE)
	for(var/k in inventory)
		var/obj/hud/inventory/I = k
		if(I.add_object(C,FALSE,silent=FALSE))
			return TRUE

	return FALSE

/mob/living/advanced/proc/remove_worn_item(var/obj/item/C)
	for(var/k in inventory)
		var/obj/hud/inventory/I = k
		if(I.remove_object(C))
			return TRUE

	return FALSE
*/

/mob/living/advanced/proc/add_species_languages()

	known_languages.Cut()

	var/species/S = SPECIES(species)

	for(var/language in S.languages)
		known_languages[language] = TRUE

/mob/living/advanced/proc/add_species_colors()

	var/species/S = SPECIES(species)

	if(S.default_color_skin)
		change_organ_visual("skin", desired_color = S.default_color_skin)

	if(S.default_color_eye)
		change_organ_visual("eye", desired_color = S.default_color_eye)

	if(S.default_color_hair && S.default_icon_hair && S.default_icon_state_hair)
		change_organ_visual("hair_head", desired_icon = S.default_icon_hair, desired_icon_state = S.default_icon_state_hair, desired_color = S.default_color_hair, desired_layer = LAYER_MOB_HAIR_HEAD)
		change_organ_visual("hair_face", desired_icon = S.default_icon_hair_face, desired_icon_state = S.default_icon_state_hair_face, desired_color = S.default_color_hair, desired_layer = LAYER_MOB_HAIR_HEAD)

	if(S.default_color_detail)
		change_organ_visual("skin_detail", desired_color = S.default_color_detail)

	if(S.default_color_glow)
		change_organ_visual("skin_glow", desired_color = S.default_color_glow)

/mob/living/advanced/proc/change_organ_visual(var/desired_id, var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type,var/desired_layer,var/debug_message)
	for(var/k in organs)
		var/obj/item/organ/O = k
		if(!length(O.additional_blends))
			continue
		if(O.additional_blends[desired_id])
			O.add_blend(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_layer, debug_message)

/mob/living/advanced/proc/update_gender()
	remove_all_organs()
	add_species_organs()
	add_species_colors()

/mob/living/advanced/proc/update_species()

	var/species/S = SPECIES(species)

	if(S.genderless)
		gender = NEUTER

	update_gender()

/mob/living/advanced/can_sprint()

	if(health?.stamina_current <= 0 || has_status_effect(STAMCRIT))
		return FALSE

	var/list/organs_to_check = list(
		BODY_FOOT_RIGHT,
		BODY_FOOT_LEFT,
		BODY_LEG_LEFT,
		BODY_LEG_RIGHT
	)

	for(var/k in organs_to_check)
		var/obj/item/organ/O = labeled_organs[k]
		if(!O || !O.health || O.health.health_current <= 0)
			return FALSE

	return ..()

/mob/living/advanced/proc/put_in_hands(var/obj/item/I,var/left = FALSE,var/silent=FALSE)

	if(left_hand && right_hand)
		if(left)
			if(left_hand.can_slot_object(I,FALSE))
				return left_hand.add_object(I,silent=silent)
			else if(right_hand.can_slot_object(I,FALSE))
				return right_hand.add_object(I,silent=silent)
		else
			if(right_hand.can_slot_object(I,FALSE))
				return right_hand.add_object(I,silent=silent)
			else if(left_hand.can_slot_object(I,FALSE))
				return left_hand.add_object(I,silent=silent)
	else
		if(left_hand)
			return left_hand.add_object(I,silent=silent)
		else if(right_hand)
			return right_hand.add_object(I,silent=silent)

	return FALSE

/mob/living/advanced/proc/get_held_left()
	if(left_hand)
		return left_hand.get_top_object()
	return null

/mob/living/advanced/proc/get_held_right()
	if(right_hand)
		return right_hand.get_top_object()
	return null

/mob/living/advanced/mod_speech(var/text)
	var/species/S = SPECIES(species)
	if(!S)
		return text
	text = S.mod_speech(src,text)
	return ..()

/mob/living/advanced/do_explosion_damage(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)
	for(var/i=1,i<=5,i++)
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = src.get_object_to_damage(owner,source,params,FALSE,TRUE)
		var/damagetype/D = all_damage_types[/damagetype/explosion/]
		D.process_damage(source,src,source,object_to_damage,owner,magnitude*(1/5))
	return TRUE

/mob/living/advanced/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	. = ..()

	for(var/k in organs)
		var/obj/item/organ/O = k
		O.act_emp(owner,source,epicenter,magnitude,desired_loyalty)
