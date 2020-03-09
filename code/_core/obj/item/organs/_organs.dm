/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."
	id = null

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null
	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage/organic.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	//health_max = 10
	var/break_threshold = 0 //0 Means it doesn't break. Other values means it breaks.

	var/attach_flag //The organ type that it wishes to attach to. Use FLAG_ORGAN_ flags.
	var/obj/item/organ/attached_organ //The organ that it is attached to.
	var/list/obj/item/organ/attached_organs //The organs that are attached to it.
	var/attach_method = 0 //0 Means it's attached to it. 1 means inside it. TODO: Flags.

	var/style

	color = "#FFFFFF"

	no_held_draw = TRUE

	var/enable_skin = TRUE
	var/enable_glow = FALSE
	var/enable_detail = FALSE
	var/enable_wounds = FALSE

	reagents = /reagent_container/limb

	var/hud_id

	var/can_be_targeted = FALSE

	var/target_bounds_x_min = 0
	var/target_bounds_x_max = 0

	var/target_bounds_y_min = 0
	var/target_bounds_y_max = 0

	var/list/visual_wounds = list(
		BRUTE = 0,
		BURN = 0

	)

	var/base_miss_chance = 0

	health_base = 200

	health = /health/obj/item/organ

	value = 100

	var/damage_layer = LAYER_MOB_INJURY

/obj/item/organ/Destroy()
	attached_organ = null
	attached_organs.Cut()
	return ..()

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src
	return TRUE

/obj/item/organ/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(src.loc && !isturf(src.loc))
		return src.loc.get_miss_chance(attacker,weapon,target) + base_miss_chance

	return ..()

/* HEALTH TODO: FIX THIS
/obj/item/organ/get_examine_text(var/mob/examiner)
	. = ..()
	for(var/wound/W in wounds)
		W.update_name()
		. += span("notice",W.name)

	return .
*/

/obj/item/organ/help(var/atom/caller,var/atom/object,var/list/params)

	/*
	if(src.loc && is_advanced(src.loc))
		caller.visible_message(span("notice","\The [src.loc.name] touches \the [object.name] with their [src.name]."))
		return TRUE
	*/

	return ..()


/obj/item/organ/initialize_blends()

	if(enable_skin)
		add_blend("skin", desired_color = "#000000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_glow)
		add_blend("skin_glow", desired_icon = icon, desired_icon_state = "[icon_state]_glow", desired_color = "#000000", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_detail)
		add_blend("skin_detail", desired_icon = icon, desired_icon_state = "[icon_state]_color", desired_color = "#000000", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_wounds)
		for(var/damagetype in visual_wounds)
			add_blend("damage_[damagetype]", desired_icon = damage_icon, desired_icon_state = "none", desired_color = "#FFFFFF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY,desired_layer = damage_layer)


	return ..()

/obj/item/organ/New()
	. = ..()
	attached_organs = list()
	return .

/obj/item/organ/Initialize()
	initialize_blends()
	return ..()

/obj/item/organ/proc/unattach_from_parent(var/turf/T)

	if(inventories)
		for(var/v in inventories)
			var/obj/hud/inventory/I = v
			I.drop_all_objects(T)

	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,FALSE)
		src.force_move(T)

	update_icon()
	queue_delete(src,ITEM_DELETION_TIME_DROPPED)

/obj/item/organ/proc/unattach_children(var/turf/T)
	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

/obj/item/organ/proc/gib()
	var/turf/T = get_turf(src.loc)
	var/mob/living/advanced/A

	if(is_advanced(src.loc))
		A = src.loc
		A.remove_organ(src,FALSE)

	unattach_from_parent(T)
	unattach_children(T)

	if(A) //A might've gotten removed here
		A.update_icon()

	//new /obj/effect/gibs/random/(T,"#FF0000",color_secondary) TODO COLOR
	qdel(src)

/obj/item/organ/update_icon()

	var/is_attached_to = is_advanced(src.loc)
	if(!is_attached_to && has_dropped_icon)
		icon_state = "[initial(icon_state)]_inventory"
		if(has_dropped_icon_underlay)
			var/icon/I = new /icon(icon,icon_state)
			var/icon/U = new /icon(icon,"[icon_state]_underlay")
			I.Blend(U,ICON_UNDERLAY)
			icon = I

	return ..()

/obj/item/organ/do_impact_effect(var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/damage_dealt)

	. = ..()

	if(!DT.draw_blood)
		return .

	if(!attacker)
		return .

	var/turf/T = get_turf(src)

	if(!T)
		return .

	/*
	if(reagents)
		create_blood_effect(T,attacker,src,damage_dealt,reagents.color)
	*/

	//create_blood_effect(T,attacker,src,damage_dealt)

/*
/proc/create_blood_effect(var/turf/T,var/atom/attacker,var/atom/victim,var/damage_dealt,var/blood_color = "#FF0000")

	var/offset_x = (T.x - attacker.x)
	var/offset_y = (T.y - attacker.y)

	if(!offset_x && !offset_y)
		offset_x = pick(-1,1)
		offset_y = pick(-1,1)

	var/norm_offset = max(abs(offset_x),abs(offset_y),1)

	offset_x = (offset_x/norm_offset) * TILE_SIZE
	offset_y = (offset_y/norm_offset) * TILE_SIZE

	for(var/i=1,i<=clamp(round(damage_dealt/5),1,5),i++)
		new/obj/effect/temp/blood/drip(T,SECONDS_TO_DECISECONDS(60),blood_color,offset_x,offset_y)
*/

/obj/item/organ/proc/on_life()
	if(reagents)
		reagents.metabolize()
	return TRUE


obj/item/organ/proc/on_organ_remove(var/mob/living/advanced/old_owner)
	return TRUE

obj/item/organ/proc/on_organ_add(var/mob/living/advanced/old_owner)
	return TRUE


obj/item/organ/proc/get_damage_description()

	if(!health)
		return list()

	var/list/damage_desc = list()

	switch(health.damage[BRUTE])
		if(5 to 15)
			damage_desc += "bruised"
		if(15 to 25)
			damage_desc += "battered"
		if(25 to 50)
			damage_desc += "crushed"
		if(50 to INFINITY)
			damage_desc += "mangled"

	switch(health.damage[BURN])
		if(5 to 15)
			damage_desc += "blistered"
		if(15 to 25)
			damage_desc += "burned"
		if(25 to 50)
			damage_desc += "scorched"
		if(50 to INFINITY)
			damage_desc += "charred"

	/*
	if(health.damage[OXY])
		damage_desc += "pale"

	if(health.damage[TOX])
		damage_desc += "sickly"

	if(health.damage[FATIGUE])
		damage_desc += "limp"
	*/

	return damage_desc