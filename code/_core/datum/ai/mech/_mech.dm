/ai/mech/
	distance_target_min = 3
	distance_target_max = VIEW_RANGE

/ai/mech/do_attack(var/atom/target,var/left_click=FALSE)

	if(!istype(owner,/mob/living/vehicle/))
		return ..()

	var/mob/living/vehicle/V = owner

	var/list/params = list(
		PARAM_ICON_X = num2text(pick(target_distribution_x)),
		PARAM_ICON_Y = num2text(pick(target_distribution_y)),
		"left" = left_click,
		"right" = !left_click,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	var/desired_dir = get_dir(V,target)
	if(!(desired_dir & V.dir))
		V.set_dir(desired_dir)

	if(!length(V.equipment))
		return FALSE

	var/obj/item/I

	if(length(V.equipment) >= 2 && !left_click)
		I = V.equipment[2]
	else
		I = V.equipment[1]

	return I.click_on_object(V,target,null,null,params)