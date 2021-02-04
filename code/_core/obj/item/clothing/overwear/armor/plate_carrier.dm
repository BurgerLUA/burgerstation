/obj/item/clothing/overwear/armor/plate_carrier
	name = "plate carrier"
	desc = "Standard armor for the soldiering kind."
	desc_extended = "A plate carrier system. Requires an armor plate to useable."
	icon = 'icons/obj/item/clothing/suit/plate_carrier.dmi'

	protected_limbs = list(BODY_TORSO)

	dyeable = TRUE

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER
	)

	value = 50

	var/list/obj/item/armor_plate/installed_plate_carriers = list()

	size = SIZE_3

/obj/item/clothing/overwear/armor/plate_carrier/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVELISTATOM("installed_plate_carriers")
	return .

/obj/item/clothing/overwear/armor/plate_carrier/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADLISTATOM("installed_plate_carriers")
	return .

/obj/item/clothing/overwear/armor/plate_carrier/get_defense_rating()

	. = ..()

	var/power_mul = length(installed_plate_carriers) > 1 ? 0.25 + ((1/length(installed_plate_carriers))*0.75) : 1

	for(var/k in installed_plate_carriers)
		var/obj/item/armor_plate/P = k
		for(var/damagetype in P.armor_base)
			.[damagetype] += P.armor_base[damagetype] > 0 ? P.armor_base[damagetype] * power_mul : P.armor_base[damagetype]

	return .

/obj/item/clothing/overwear/armor/plate_carrier/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/armor_plate/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(length(installed_plate_carriers) >= 2)
			if(ismob(caller))
				var/mob/M = caller
				M.to_chat(span("notice","You can't fit any more plate carriers inside \the [src.name]!"))
			return TRUE
		var/obj/item/armor_plate/P = object
		P.drop_item(src)
		installed_plate_carriers += P
		if(is_advanced(caller))
			var/mob/living/advanced/A = caller
			A.update_items()
		return TRUE

	return ..()

/obj/item/clothing/overwear/armor/plate_carrier/click_self(var/mob/caller)

	if(is_advanced(caller) && length(installed_plate_carriers))
		INTERACT_CHECK
		INTERACT_DELAY(1)
		var/mob/living/advanced/A = caller
		var/obj/item/armor_plate/P = input(A,"What armor plates do you wish to remove?","Plate Carrier Removal") as null|anything in installed_plate_carriers
		if(P && P in installed_plate_carriers)
			A.visible_message(span("notice","\The [caller.name] removes \the [P.name] from \the [src.name]."),span("notice","You remove \the [P.name] from \the [src.name]."))
			P.drop_item(get_turf(src))
			installed_plate_carriers -= P
			A.put_in_hands(P) //This calls update_slowdown_mul
			//A.update_slowdown_mul()
		return TRUE

	return ..()

/obj/item/clothing/overwear/armor/plate_carrier/black
	color = COLOR_BLACK

/obj/item/clothing/overwear/armor/plate_carrier/pocket
	name = "tactical plate carrier"
	desc = "Can carry forks, spoons, and knives too."
	desc_extended = "A plate carrier system. Requires an armor plate to useable."
	icon = 'icons/obj/item/clothing/suit/plate_carrier_pouched.dmi'

	dyeable = TRUE

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = -10
	)

	value = 70

	is_container = TRUE

	dynamic_inventory_count = 4
	container_max_size = SIZE_2

/obj/item/clothing/overwear/armor/plate_carrier/pocket/black
	color = COLOR_BLACK

/obj/item/clothing/overwear/armor/plate_carrier/pocket/black/medium/Generate()
	var/obj/item/armor_plate/medium/M = new(src)
	INITIALIZE(M)
	GENERATE(M)
	FINALIZE(M)
	installed_plate_carriers += M
	return ..()
