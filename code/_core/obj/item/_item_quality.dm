// https://www.desmos.com/calculator/yipyhzzbmk
/obj/item/proc/get_quality_mod()
	if(quality == -1)
		return 1
	var/q_mod = min(quality/100,2)
	return max(0.25,min(cos( (q_mod-1) * 90)**min(1,1 - q_mod),2))

/obj/item/proc/get_damage_icon_number(var/desired_quality = quality)
	if(quality == -1)
		return 0
	return FLOOR(clamp( (100 - quality) / (100/5),0,5 ),1)

/obj/item/proc/can_adjust_quality()

	if(quality == -1)
		return FALSE

	return TRUE

/obj/item/proc/adjust_quality(var/quality_to_add = 0,var/force=FALSE)
	set_quality(quality + quality_to_add,force)
	return TRUE

/obj/item/proc/set_quality(var/quality_to_set=100,var/force=FALSE)

	if(!force && !can_adjust_quality())
		return FALSE

	var/original_quality = quality
	var/original_damage_num = get_damage_icon_number()

	quality = clamp(FLOOR(quality_to_set, 0.01), 0, quality_max)

	if(original_quality > 0 && quality <= 0)
		visible_message(span("danger","\The [src.name] breaks!"))

	var/desired_damage_num = get_damage_icon_number()
	if(original_damage_num != desired_damage_num)
		update_sprite()
		update_quality_overlay(desired_damage_num)

	value = get_base_value()

	return TRUE

/obj/item/proc/adjust_quality_max(var/quality_to_add = 0,var/force=FALSE)
	set_quality_max(quality_max + quality_to_add,force)
	return TRUE

/obj/item/proc/set_quality_max(var/quality_to_set=100,var/force=FALSE)

	if(!force && !can_adjust_quality())
		return FALSE

	quality_max = clamp(quality_to_set,0,200)

	set_quality(quality,force=TRUE) //This will update it.

	return TRUE

/obj/item/proc/update_quality_overlay(var/desired_damage_num = get_damage_icon_number())

	if(!enable_torn_overlay && !enable_damage_overlay)
		return FALSE

	var/desired_icon_state = desired_damage_num ? "[desired_damage_num]" : null
	if(enable_damage_overlay)
		add_blend(
			"damage_overlay_noise",
			desired_icon_state = desired_icon_state,
			desired_should_save = FALSE
		)
	if(enable_torn_overlay)
		add_blend(
			"damage_overlay",
			desired_icon_state = desired_icon_state,
			desired_should_save=FALSE
		)

	return TRUE
