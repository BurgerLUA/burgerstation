/ai/cyborg
	distance_target_max = VIEW_RANGE


/ai/cyborg/do_attack(var/atom/target,var/left_click=FALSE)

	if(!owner || !target)
		return FALSE

	var/mob/living/simple/silicon/cyborg/C = owner

	if(!C.stored_melee_weapon || !C.stored_ranged_weapon)
		return ..()

	owner.move_dir = 0x0

	var/list/params = list(
		PARAM_ICON_X = 16,
		PARAM_ICON_Y = 16,
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	params["left"] = TRUE //Always a left click.

	if(get_dist(C,target) <= 1)
		C.stored_melee_weapon.click_on_object(C,target,null,null,params)
	else
		C.stored_ranged_weapon.click_on_object(C,target,null,null,params)

	return TRUE