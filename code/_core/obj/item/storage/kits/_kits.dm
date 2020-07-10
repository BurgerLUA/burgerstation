/obj/item/storage/kit/
	name = "first aid kit"
	desc = "Carries medicine."
	desc_extended = "A basic first aid kit. Usually contains 4 sets of bandages, two tubes of ointment, a pill bottle filled with dylovene and an epinephrine syringe."
	icon = 'icons/obj/item/storage/kits.dmi'
	icon_state = "firstaid"

	is_container = TRUE

	size = SIZE_3
	container_max_size = SIZE_2
	dynamic_inventory_count = 8

/obj/item/storage/kit/New(var/desired_loc)
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,4)]"
	return .

/obj/item/storage/kit/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("icon_state")
	return .

/obj/item/storage/kit/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("icon_state")
	return .

/obj/item/storage/kit/filled/fill_inventory()
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/storage/pillbottle/dylovene_small(src)
	new /obj/item/container/syringe/epinephrine(src)
	return ..()


/obj/item/storage/kit/brute
	name = "brute first aid kit"
	desc_extended = "A first aid kit that focuses on healing brute injury. Usually contains a pill bottle filled with bicaridine, two sets of bandages, one set of trauma kits and four sets of styptic powder patches."
	icon_state = "brute"

/obj/item/storage/kit/brute/filled/fill_inventory()
	new /obj/item/storage/pillbottle/bicaridine_small(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/trauma_kit(src)
	new /obj/item/container/medicine/patch/brute(src)
	new /obj/item/container/medicine/patch/brute(src)
	new /obj/item/container/medicine/patch/brute(src)
	new /obj/item/container/medicine/patch/brute(src)
	return ..()

/obj/item/storage/kit/burn
	name = "burn first aid kit"
	desc_extended = "A first aid kit that focuses on healing burn injuries. Usually contains a pill bottle filled with kelotane, two tubes of ointment, one set of burn kits and four sets of silver sulfadiazine."
	icon_state = "burn"

/obj/item/storage/kit/burn/filled/fill_inventory()
	new /obj/item/storage/pillbottle/kelotane_small(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/container/medicine/burn_kit(src)
	new /obj/item/container/medicine/patch/burn(src)
	new /obj/item/container/medicine/patch/burn(src)
	new /obj/item/container/medicine/patch/burn(src)
	new /obj/item/container/medicine/patch/burn(src)
	return ..()


/obj/item/storage/kit/syndicate
	name = "combat medikit"
	desc = "I hope you've got insurance."
	desc_extended = "A combat medical kit for healing when under pressure. Usually contains five pill bottles, each filled with bicaridine, dylovene, kelotane, iron and epinephrine pills. Also contains two epinephrine syringes and a health analyzer."
	icon_state = "tactical"

/obj/item/storage/kit/syndicate/filled/fill_inventory()
	new /obj/item/storage/pillbottle/bicaridine(src)
	new /obj/item/storage/pillbottle/dylovene(src)
	new /obj/item/storage/pillbottle/kelotane(src)
	new /obj/item/storage/pillbottle/iron(src)
	new /obj/item/storage/pillbottle/omnizine(src)
	new /obj/item/container/syringe/epinephrine(src)
	new /obj/item/container/syringe/epinephrine(src)
	new /obj/item/analyzer/health(src)
	return ..()