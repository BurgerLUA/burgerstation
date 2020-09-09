/obj/item/powercell/
	name = "standard power cell"
	desc = "Do not ingest."
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 10000 megawatts."
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "cell_basic"

	var/charge_current = 0
	var/charge_max = CELL_SIZE_BASIC

	size = SIZE_1

	value = 10

/obj/item/powercell/get_battery()
	return src

/obj/item/powercell/calculate_value()

	. = ..()
	. += CEILING(charge_current*0.01,1)
	. += CEILING(charge_max*0.003,1)
	return .

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
	var/charge_number = FLOOR(min(charge_current/charge_max,1) * 7, 1)
	var/desired_icon = "charge_[charge_number]"
	var/icon/I2 = new/icon(icon,desired_icon)

	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/powercell/advanced
	name = "advanced power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 25000 megawatts."
	icon_state = "cell_advanced"
	charge_max = CELL_SIZE_ADVANCED

	size = SIZE_1


	value = 15

/obj/item/powercell/industrial
	name = "industrial power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A bulky power cell for use in recharging energy weaponry. This one has a rating of 50000 megawatts."
	icon_state = "cell_industrial"
	charge_max = CELL_SIZE_INDUSTRIAL

	size = SIZE_2


	value = 25


/obj/item/powercell/bluespace
	name = "bluespace power cell"
	desc = "It's bluespace, I ain't gotta explain shit."
	desc_extended = "A highly advanced bluespace power cell fitted with a minuture bag of holding packed with an absurd amount of diodes."
	icon_state = "cell_bluespace"
	charge_max = CELL_SIZE_BLUESPACE

	size = SIZE_2

	value = 1000


/obj/item/powercell/vehicle
	name = "mech-grade power cell"
	desc = "Do not swallow."
	desc_extended = "A massive mech-grade battery used commonly to power mechs and mech weapons as well as the systems inside the mech."
	icon_state = "cell_vehicle"
	charge_max = CELL_SIZE_VEHICLE

	size = SIZE_4

	value = 30