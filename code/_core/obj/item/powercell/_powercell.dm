/obj/item/powercell/
	name = "basic power cell"
	desc = "Please do not lick."
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 10000 megawatts."
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "cell_basic"

	var/charge_current = 0
	var/charge_max = CELL_SIZE_BASIC

	size = SIZE_1
	weight = WEIGHT_2

	value = 5

/obj/item/powercell/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("charge_current")
	return .

/obj/item/powercell/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("charge_current")
	return .

/obj/item/powercell/Generate()
	charge_current = charge_max
	. = ..()
	update_sprite()
	return .

/obj/item/powercell/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)
	var/charge_number = FLOOR((charge_current/charge_max) * 7, 1)
	var/desired_icon = "charge_[charge_number]"
	var/icon/I2 = new/icon(icon,desired_icon)

	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/powercell/click_on_object(var/atom/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(get_dist(caller,object) > 1)
		return FALSE

	if(is_laser_gun(object) && is_living(caller))
		var/obj/item/weapon/ranged/energy/L = object
		var/mob/living/L2 = caller
		var/amount_to_restore = min(charge_current,L.charge_max - L.charge_current)

		if(L.charge_max == L.charge_current)
			L2.to_chat(span("notice","\The [L.name] is already at full capacity!"))
			return TRUE

		if(charge_current <= 0)
			L2.to_chat(span("notice","\The [src.name] has no charge left!"))
			return TRUE

		L.charge_current += amount_to_restore
		charge_current -= amount_to_restore
		update_sprite()
		L.update_sprite()
		L2.to_chat(span("notice","You recharge \the [object.name] with \the [src.name] [L.charge_current] / [L.charge_max]."))

		return TRUE

	return ..()

/obj/item/powercell/advanced
	name = "advanced power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 25000 megawatts."
	icon_state = "cell_advanced"
	charge_max = CELL_SIZE_ADVANCED

	size = SIZE_2
	weight = WEIGHT_3

	value = 15

/obj/item/powercell/industrial
	name = "industrial power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A bulky power cell for use in recharging energy weaponry. This one has a rating of 50000 megawatts."
	icon_state = "cell_industrial"
	charge_max = CELL_SIZE_INDUSTRIAL

	size = SIZE_3
	weight = WEIGHT_4

	value = 25