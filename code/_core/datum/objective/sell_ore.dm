/objective/sell_ore
	name = "Sell Material"
	desc = "Sell a certain amount of material to cargo."

	credit_reward = 1000
	burgerbux_reward = 1
	points_reward = 5

	var/desired_quota = 50

/objective/sell_ore/get_description()
	return "Sell [desired_quota]u of ore or material (any type) to cargo."

/objective/sell_ore/on_object_sold(var/atom/movable/object)

	if(istype(object,/obj/item/material/))
		var/obj/item/material/M = object
		desired_quota -= M.material_multiplier * M.item_count_current
		check_completion()

	return ..()

/objective/sell_ore/check_completion()

	desired_quota = max(0,desired_quota)
	if(desired_quota == 0)
		return COMPLETED

	return ..()

/objective/sell_ore/setup()
	return TRUE