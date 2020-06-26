/obj/item/storage/kit/
	name = "first aid kit"
	desc = "Carries medicine."
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "firstaid"

	is_container = TRUE

	size = SIZE_3
	container_max_size = SIZE_2
	dynamic_inventory_count = 8

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
	icon_state = "syndicate"

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