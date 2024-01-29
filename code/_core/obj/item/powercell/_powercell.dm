/obj/item/powercell/
	name = "standard power cell"
	desc = "Do not STOMACH."
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 10000 megawatts."
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "cell_basic"

	var/charge_current = 0
	var/charge_max = CELL_SIZE_BASIC

	size = SIZE_1

	value = 10

	weight = 2
	has_quick_function = TRUE //allows batteries in the belt slots

/obj/item/powercell/quick(mob/caller,atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller

	return A.put_in_hands(src,params)

/obj/item/powercell/get_battery()
	return src

/obj/item/powercell/get_base_value()
	. = ..()
	. += CEILING(charge_max*0.0003,1)

/obj/item/powercell/get_value()
	. = ..()
	. += CEILING(charge_current*0.001,1)

/obj/item/powercell/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("charge_current")

/obj/item/powercell/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("charge_current")

/obj/item/powercell/Generate()
	charge_current = charge_max
	. = ..()
	update_sprite()



/obj/item/powercell/update_overlays()
	. = ..()
	var/charge_number = FLOOR(min(charge_current/charge_max,1) * 7, 1)
	var/image/I = new/image(initial(icon),"charge_[charge_number]")
	add_overlay(I)

/obj/item/powercell/advanced
	name = "advanced power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 25000 megawatts."
	icon_state = "cell_advanced"
	charge_max = CELL_SIZE_ADVANCED

	size = SIZE_1

	value = 15

	weight = 3

	rarity = RARITY_UNCOMMON

/obj/item/powercell/industrial
	name = "industrial power cell"
	desc = "r&d can i have a powercell plz i wont use it for stunprod promise"
	desc_extended = "A bulky power cell for use in recharging energy weaponry. This one has a rating of 50000 megawatts."
	icon_state = "cell_industrial"
	charge_max = CELL_SIZE_INDUSTRIAL

	size = SIZE_2

	rarity = RARITY_UNCOMMON


	value = 25

	weight = 5


/obj/item/powercell/bluespace
	name = "bluespace power cell"
	desc = "It's bluespace, I ain't gotta explain shit."
	desc_extended = "A highly advanced bluespace power cell fitted with a minuture bag of holding packed with an absurd amount of diodes."
	icon_state = "cell_bluespace"
	charge_max = CELL_SIZE_BLUESPACE

	size = SIZE_2

	value = 1000

	weight = 4

	value_burgerbux = 1

	rarity = RARITY_MYTHICAL

/obj/item/powercell/vehicle
	name = "mech-grade power cell"
	desc = "Do not swallow."
	desc_extended = "A massive mech-grade battery used commonly to power mechs and mech weapons as well as the systems inside the mech."
	icon_state = "cell_vehicle"
	charge_max = CELL_SIZE_VEHICLE

	size = SIZE_4

	value = 30

	weight = 10

/obj/item/powercell/tiny
	name = "device power cell"
	desc = "Do not swallow."
	desc_extended = "A tiny battery used commonly to power small devices."
	icon_state = "cell_tiny"
	charge_max = CELL_SIZE_TINY

	size = SIZE_0

	value = 10

	weight = 1


/obj/item/powercell/recharging
	name = "fusion power cell"
	desc = "Do not STOMACH."
	desc_extended = "A power cell for use in recharging energy weaponry. This one has a rating of 10000 megawatts, and self-charges"
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "cell_recharging"

	charge_max = CELL_SIZE_BASIC*0.5

	size = SIZE_2

	value = 1000

	weight = 6

	value_burgerbux = 1 //Citizens aren't supposed to have recharging power cells.

/obj/item/powercell/recharging/on_equip(atom/old_location,slient=FALSE)
	. = ..()
	var/obj/hud/inventory/new_location = loc
	if(new_location.click_flags && new_location.owner)
		var/mob/living/advanced/A = new_location.owner
		A.to_chat(span("danger","\The intense heat from \the [src.name] burns your hand and forces you to drop it!"))
		A.add_status_effect(STUN,30,30)
		if(is_organ(new_location.loc))
			var/obj/item/organ/O = new_location.loc
			O.health.adjust_loss_smart(burn=10)
		src.drop_item(get_turf(A))

/obj/item/powercell/recharging/PostInitialize()
	START_THINKING(src)
	return ..()

/obj/item/powercell/recharging/think()
	charge_current = min(charge_current + charge_max*0.001,charge_max)
	return ..()

/obj/item/powercell/get_examine_list(mob/caller)
	return ..() + div("notice","It has [charge_current] out of [charge_max] charge remaining.")



/obj/item/powercell/dummy
	name = "dummy power cell"
	desc = "For dummies."
	desc_extended = "You shouldn't see this."
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "cell_recharging"

	charge_max = 100

	size = SIZE_1

	value = 0

	weight = 0