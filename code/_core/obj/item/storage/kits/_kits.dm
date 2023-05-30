/obj/item/storage/kit/
	name = "first aid kit"
	desc = "Carries medicine."
	desc_extended = "A basic first aid kit."
	icon = 'icons/obj/item/storage/kits.dmi'
	icon_state = "firstaid"

	is_container = TRUE

	size = SIZE_3
	container_max_size = SIZE_2
	dynamic_inventory_count = 8

	value = 10

/obj/item/storage/kit/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("icon_state")

/obj/item/storage/kit/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("icon_state")

/obj/item/storage/kit/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/storage/pillbottle/dylovene_small(src)
	new /obj/item/storage/pillbottle/consumer/painkillers(src)
	new /obj/item/container/syringe/medipen/epinephrine(src)
	. = ..()


/obj/item/storage/kit/brute
	name = "brute first aid kit"
	desc_extended = "A first aid kit that focuses on healing brute injury."
	icon_state = "brute"

/obj/item/storage/kit/brute/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/storage/pillbottle/bicaridine_small(src)
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/trauma_kit(src)
	new /obj/item/container/healing/patch/brute(src)
	new /obj/item/container/healing/patch/brute(src)
	new /obj/item/container/healing/patch/brute(src)
	new /obj/item/container/healing/bone_gel(src)
	. = ..()

/obj/item/storage/kit/burn
	name = "burn first aid kit"
	desc_extended = "A first aid kit that focuses on healing burn injuries."
	icon_state = "burn"

/obj/item/storage/kit/burn/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/storage/pillbottle/kelotane_small(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/container/healing/burn_kit(src)
	new /obj/item/container/healing/patch/burn(src)
	new /obj/item/container/healing/patch/burn(src)
	new /obj/item/container/healing/patch/burn(src)
	//TODO: Add sunscreen
	. = ..()

/obj/item/storage/kit/toxin
	name = "toxin first aid kit"
	desc_extended = "A first aid kit that focuses on healing toxin based injuries."
	icon_state = "toxin"

/obj/item/storage/kit/toxin/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/container/syringe/hypodermic(src)
	new /obj/item/container/simple/beaker/bottle/dylovene(src)
	new /obj/item/container/simple/beaker/bottle/dylovene(src)
	new /obj/item/container/simple/beaker/bottle/calomel(src)
	new /obj/item/container/simple/beaker/bottle/calomel(src)
	new /obj/item/container/simple/beaker/bottle/antihol(src)
	new /obj/item/container/simple/beaker/bottle/charcoal(src)
	new /obj/item/container/simple/beaker/bottle/epinephrine(src)
	. = ..()


/obj/item/storage/kit/oxy
	name = "oxy first aid kit"
	desc_extended = "A first aid kit that focuses on healing suffocation and blood loss based injuries."
	icon_state = "oxy"

/obj/item/storage/kit/oxy/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/container/blood_pack/full/o_negative(src)
	new /obj/item/container/blood_pack/full/o_negative(src)
	new /obj/item/container/blood_pack/full/o_negative(src)
	new /obj/item/container/syringe/medipen/epinephrine(src)
	new /obj/item/container/syringe/medipen/epinephrine(src)
	new /obj/item/storage/pillbottle/iron_small(src)
	. = ..()

/obj/item/storage/kit/syndicate
	name = "deluxe first aid kit"
	desc = "I hope you've got insurance."
	desc_extended = "A combat medical kit for combat operatives. Contains hard to obtain medication that is generally superior than basic medication, as well as an autosyringe and a special first aid analyzer."
	icon_state = "tactical"

/obj/item/storage/kit/syndicate/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/analyzer/health/syndicate(src)
	new /obj/item/container/syringe/hypodermic/auto(src)
	new /obj/item/container/simple/beaker/bottle/medium/brute_mix(src)
	new /obj/item/container/simple/beaker/bottle/medium/burn_mix(src)
	new /obj/item/container/simple/beaker/bottle/medium/toxin_mix(src)
	new /obj/item/container/simple/beaker/bottle/medium/death_mix(src)
	new /obj/item/container/simple/beaker/bottle/medium/rad_mix(src)
	new /obj/item/container/simple/beaker/bottle/medium/combat_mix(src)
	. = ..()

/obj/item/storage/kit/ai3
	name = "AI-3"
	desc = "Ya like cheese?"
	desc_extended = "A basic Slavic-made AI-3 infantry first aid kit."
	icon_state = "ai3"

	is_container = TRUE

	size = SIZE_2
	container_max_size = SIZE_1
	max_inventory_x = 5
	dynamic_inventory_count = 10

/obj/item/storage/kit/ai3/filled/fill_inventory()
	new /obj/item/container/syringe/medipen/bicaridine(src)
	new /obj/item/container/syringe/medipen/bicaridine(src)
	new /obj/item/container/syringe/medipen/kelotane(src)
	new /obj/item/container/syringe/medipen/kelotane(src)
	new /obj/item/container/syringe/medipen/dylovene(src)
	new /obj/item/container/syringe/medipen/dylovene(src)
	new /obj/item/container/syringe/medipen/dexaline(src)
	new /obj/item/container/syringe/medipen/dexaline(src)
	new /obj/item/container/syringe/medipen/iron(src)
	new /obj/item/container/syringe/medipen/epinephrine(src)
	. = ..()


/obj/item/storage/kit/advanced
	name = "advanced first aid kit"
	desc = "I hope you've got insurance."
	desc_extended = "A first aid kit for healing when under pressure."
	icon_state = "purple"

/obj/item/storage/kit/advanced/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/container/healing/trauma_kit/advanced(src)
	new /obj/item/container/healing/burn_kit/advanced(src)
	new /obj/item/container/spray/synthflesh(src)
	new /obj/item/storage/pillbottle/dylovene_small(src)
	new /obj/item/storage/pillbottle/iron_small(src)
	new /obj/item/container/blood_pack/full/rad_be_gone(src)
	new /obj/item/container/healing/bone_gel(src)
	. = ..()


/obj/item/storage/kit/rad
	name = "radiation first aid kit"
	desc = "For those overly radical moments."
	desc_extended = "A first aid kit that focuses on healing radiation related injuries."
	icon_state = "rad"

/obj/item/storage/kit/rad/filled/fill_inventory()
	icon_state = "[initial(icon_state)][rand(1,4)]"
	new /obj/item/container/blood_pack/full/rad_be_gone(src)
	new /obj/item/container/blood_pack/full/rad_be_gone(src)
	new /obj/item/storage/pillbottle/potassium_iodide_small(src)
	new /obj/item/storage/pillbottle/space_prussian_blue_small(src)
	new /obj/item/container/syringe/medipen/dylovene(src)
	new /obj/item/container/syringe/medipen/dylovene(src)
	new /obj/item/container/simple/alcohol/vodka(src)
	new /obj/item/container/simple/beaker/shot(src)
	. = ..()
