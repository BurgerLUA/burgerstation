/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null
	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage_organs.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	health_max = 10
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

	reagents = /reagent_container/limb/

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

/obj/item/organ/destroy()
	attached_organ = null
	attached_organs.Cut()
	return ..()

/obj/item/organ/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(src.loc && !is_turf(src.loc))
		return src.loc.get_miss_chance(attacker,weapon,target) + base_miss_chance

	return ..()

/obj/item/organ/get_examine_text(var/mob/examiner)
	. = ..()
	for(var/wound/W in wounds)
		W.update_name()
		. += span("notice",W.name)

	return .

/obj/item/organ/initialize_blends()

	if(enable_skin)
		add_blend("skin", desired_color = "#FF0000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE)

	if(enable_glow)
		add_blend("skin_glow", desired_icon = icon, desired_icon_state = "[icon_state]_glow", desired_color = "#00FF00", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)

	if(enable_detail)
		add_blend("skin_detail", desired_icon = icon, desired_icon_state = "[icon_state]_color", desired_color = "#0000FF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE)

	if(enable_wounds)
		for(var/damagetype in visual_wounds)
			var/damage_value = visual_wounds[damagetype]
			add_blend("damage_[damagetype]", desired_icon = damage_icon, desired_icon_state = "[damage_value]", desired_color = "#FFFFFF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_MASK | ICON_BLEND_OVERLAY)

	return ..()

/obj/item/organ/New()
	..()
	attached_organs = list()
	wounds = list()
	initialize_blends()
	update_health()

/obj/item/organ/adjust_brute_loss(var/value)
	if(value > 0 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	if(is_player(src.loc) && value > 0)
		damage_soft[BRUTE] += value
	else
		damage[BRUTE] += value

	return value

/obj/item/organ/adjust_tox_loss(var/value)
	if(value > 0 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	if(is_player(src.loc) && value > 0)
		damage_soft[TOX] += value
	else
		damage[TOX] += value

	return value

/obj/item/organ/adjust_oxy_loss(var/value)
	if(value > 0 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	if(is_player(src.loc) && value > 0)
		damage_soft[OXY] += value
	else
		damage[OXY] += value

	return value

/obj/item/organ/adjust_burn_loss(var/value)
	if(value > 0 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.health_regen_delay = max(A.health_regen_delay,300)

	if(is_player(src.loc) && value > 0)
		damage_soft[BURN] += value
	else
		damage[BURN] += value

	return value

/obj/item/organ/adjust_fatigue_loss(var/value)
	if(!src.loc || !is_advanced(src.loc))
		return 0

	var/mob/living/advanced/A = src.loc

	return A.adjust_fatigue_loss(value)

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src

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
			A.remove_organ(src,FALSE,FALSE)
		src.force_move(T)

	update_icon()
	queue_delete(src,600)

/obj/item/organ/proc/unattach_children(var/turf/T)
	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

/obj/item/organ/proc/gib()
	var/turf/T = get_turf(src.loc)
	var/mob/living/advanced/A

	if(is_advanced(src.loc))
		A = src.loc
		A.remove_organ(src,TRUE,FALSE)

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

/obj/item/organ/update_health(var/damage_dealt,var/atom/attacker)

	. = ..()

	if(enable_wounds && src.loc && is_advanced(src.loc))

		var/should_update = FALSE
		var/mob/living/advanced/A = src.loc

		for(var/damage_type in visual_wounds)
			var/last_amount = visual_wounds[damage_type]
			var/current_amount = floor((get_loss(damage_type)/health_max)*5)

			if(last_amount != current_amount)
				change_blend("damage_[damage_type]", desired_icon_state = "[current_amount]")
				should_update = TRUE

		if(should_update)
			A.update_overlay(src)

	return .

/obj/item/organ/do_impact_effect(var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/damage_dealt)

	. = ..()

	if(!DT.draw_blood)
		return .

	if(!attacker)
		return .

	var/turf/T = get_turf(src)

	var/obj/effect/temp/impact/blood/B = new(T,SECONDS_TO_DECISECONDS(60),"#FF0000")
	B.transform.Scale(0.1,0.1)

	var/offset_x = (T.x - attacker.x)
	var/offset_y = (T.y - attacker.y)

	if(!offset_x && !offset_y)
		offset_x = rand(-1,1)

	var/total_offset = abs(offset_x) + abs(offset_y)

	if(total_offset)
		offset_x = offset_x/total_offset
		offset_y = offset_y/total_offset
		offset_x *= TILE_SIZE
		offset_y *= TILE_SIZE
	else
		offset_x = 0
		offset_y = 0

	animate(B,pixel_x = offset_x,pixel_y = offset_y, transform = null, time = 2)

	return .