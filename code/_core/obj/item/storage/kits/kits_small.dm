/obj/item/storage/kit/small
	name = "personal first aid kit"
	desc = "Carries medicine."
	desc_extended = "A basic first aid kit, now portable."
	icon = 'icons/obj/item/storage/kits.dmi'
	icon_state = "firstaid-mini"

	is_container = TRUE

	size = SIZE_2
	container_max_size = SIZE_1
	dynamic_inventory_count = 4

	value = 10

/obj/item/storage/kit/small/filled/fill_inventory()
	new/obj/item/container/healing/bandage(src)
	new/obj/item/container/healing/ointment(src)
	new/obj/item/storage/pillbottle/dylovene_small(src)
	new/obj/item/storage/pillbottle/consumer/painkillers(src)
	. = ..()



/obj/item/storage/kit/small/brute
	name = "personal brute first aid kit"
	desc_extended = "A first aid kit that focuses on healing brute injury."
	icon_state = "brute-mini"

/obj/item/storage/kit/small/brute/filled/fill_inventory()
	new/obj/item/container/healing/trauma_kit(src)
	new/obj/item/container/healing/patch/brute(src)
	new/obj/item/storage/pillbottle/bicaridine_small(src)
	new/obj/item/container/healing/bone_gel(src)
	. = ..()

/obj/item/storage/kit/small/burn
	name = "personal burn first aid kit"
	desc_extended = "A first aid kit that focuses on healing burn injury."
	icon_state = "burn-mini"

/obj/item/storage/kit/small/burn/filled/fill_inventory()
	new/obj/item/container/healing/burn_kit(src)
	new/obj/item/container/healing/patch/burn(src)
	new/obj/item/storage/pillbottle/kelotane_small(src)
	//TODO: Sunscreen
	. = ..()

/obj/item/storage/kit/small/toxin
	name = "personal toxin first aid kit"
	desc_extended = "A first aid kit that focuses on healing toxin injury."
	icon_state = "toxin-mini"

/obj/item/storage/kit/small/toxin/filled/fill_inventory()
	new /obj/item/container/syringe/hypodermic(src)
	new /obj/item/container/simple/beaker/bottle/dylovene(src)
	new /obj/item/container/simple/beaker/bottle/charcoal(src)
	new /obj/item/container/simple/beaker/bottle/calomel(src)
	. = ..()

/obj/item/storage/kit/small/rad
	name = "personal radiation first aid kit"
	desc_extended = "A first aid kit that focuses on healing radiation injury."
	icon_state = "rad-mini"

/obj/item/storage/kit/small/rad/filled/fill_inventory()
	new /obj/item/container/blood_pack/full/rad_be_gone(src)
	new /obj/item/storage/pillbottle/potassium_iodide_small(src)
	new /obj/item/container/syringe/medipen/dylovene(src)
	new /obj/item/container/simple/alcohol/vodka(src)
	. = ..()


/obj/item/storage/kit/small/advanced
	name = "personal advanced first aid kit"
	desc_extended = "A first aid kit that focuses on healing advanced general injury."
	icon_state = "purple-mini"

/obj/item/storage/kit/small/advanced/filled/fill_inventory()
	new/obj/item/container/healing/trauma_kit/advanced(src)
	new/obj/item/container/healing/burn_kit/advanced(src)
	new/obj/item/storage/pillbottle/dylovene_small(src)
	new/obj/item/storage/pillbottle/iron_small(src)
	. = ..()


/obj/item/storage/kit/small/oxy
	name = "personal oxy first aid kit"
	desc_extended = "A first aid kit that focuses on healing suffocation related injury."
	icon_state = "oxy-mini"

/obj/item/storage/kit/small/oxy/filled/fill_inventory()
	new /obj/item/container/blood_pack/full/o_negative(src)
	new /obj/item/container/blood_pack/full/o_negative(src)
	new /obj/item/container/syringe/medipen/epinephrine(src)
	new /obj/item/storage/pillbottle/iron_small(src)
	. = ..()

/obj/item/storage/kit/small/syndicate
	name = "combat hypospray kit"
	desc_extended = "A first aid kit that contains a combat hypospray and some hypospray vials of basic healing chemicals."
	icon_state = "tactical-mini"

	size = SIZE_2
	container_max_size = SIZE_2

	container_whitelist = list(
		/obj/item/container/syringe/hypospray/combat,
		/obj/item/container/simple/beaker
	)

/obj/item/storage/kit/small/syndicate/filled/fill_inventory()
	new /obj/item/container/syringe/hypospray/combat(src)
	new /obj/item/container/simple/beaker/bottle/hypospray/brute_mix(src)
	new /obj/item/container/simple/beaker/bottle/hypospray/burn_mix(src)
	new /obj/item/container/simple/beaker/bottle/hypospray/toxin_mix(src)
	. = ..()