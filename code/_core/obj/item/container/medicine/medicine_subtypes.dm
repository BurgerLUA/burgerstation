/obj/item/container/medicine/bandage
	name = "bandages"
	icon_state = "brutepack"
	treatment_time = 5
	heal_brute = 25
	heal_bleeding = TRUE

	value = 1

/obj/item/container/medicine/bandage/advanced
	name = "bicaridine soaked bandages"

/obj/item/container/medicine/bandage/advanced/on_spawn()
	reagents.add_reagent("bicaridine",50)
	return ..()

/obj/item/container/medicine/ointment
	name = "ointment"
	icon_state = "ointment"
	treatment_time = 1
	heal_burn = 25

	value = 1

/obj/item/container/medicine/ointment/advanced
	name = "kelotane infused ointment"

/obj/item/container/medicine/ointment/advanced/on_spawn()
	reagents.add_reagent("kelotane",50)
	return ..()

/obj/item/container/medicine/trauma_kit
	name = "trauma kit"
	icon_state = "traumakit"
	treatment_time = 10
	heal_brute = 50
	heal_bleeding = TRUE

	value = 3

/obj/item/container/medicine/trauma_kit/advanced
	name = "bicaridine infused trauma kit"

/obj/item/container/medicine/trauma_kit/advanced/on_spawn()
	reagents.add_reagent("bicaridine",50)
	return ..()

/obj/item/container/medicine/burn_kit
	name = "burn kit"
	icon_state = "burnkit"
	treatment_time = 10
	heal_burn = 50

	value = 3

/obj/item/container/medicine/burn_kit/advanced
	name = "kelotane infused burn kit"

/obj/item/container/medicine/burn_kit/advanced/on_spawn()
	reagents.add_reagent("kelotane",50)
	return ..()

/obj/item/container/medicine/patch
	name = "medical patch"
	icon_state = "patch"
	treatment_time = 5
	item_count_current = 3
	item_count_max = 3

	value = 1

/obj/item/container/medicine/patch/brute
	name = "brute patch (Styptic Powder)"
	icon_state = "patch_brute"

/obj/item/container/medicine/patch/brute/on_spawn()
	reagents.add_reagent("styptic_powder",30)

/obj/item/container/medicine/patch/burn
	name = "burn patch (Silver Sulfadiazine)"
	icon_state = "patch_burn"

/obj/item/container/medicine/patch/burn/on_spawn()
	reagents.add_reagent("silver_sulfadiazine",30)