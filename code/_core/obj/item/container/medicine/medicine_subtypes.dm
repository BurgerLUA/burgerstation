/obj/item/container/medicine/bandage
	name = "bandages"
	icon_state = "brutepack"
	treatment_time = 1
	heal_brute = 30
	heal_bleeding = TRUE
	item_count_current = 5
	item_count_max = 10

	value = 10

/obj/item/container/medicine/bandage/advanced
	name = "infused bandages (styptic powder)"

/obj/item/container/medicine/bandage/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/medicine/ointment
	name = "ointment"
	icon_state = "ointment"
	treatment_time = 1
	heal_burn = 30
	value = 10

/obj/item/container/medicine/ointment/advanced
	name = "infused ointment (silver sulfadiazine)"

/obj/item/container/medicine/ointment/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/medicine/trauma_kit
	name = "trauma kit"
	icon_state = "traumakit"
	treatment_time = 30
	heal_brute = 80
	heal_bleeding = TRUE
	item_count_current = 5
	item_count_max = 10

	value = 20

/obj/item/container/medicine/trauma_kit/advanced
	name = "infused trauma kit (styptic powder)"

/obj/item/container/medicine/trauma_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/medicine/burn_kit
	name = "burn kit"
	icon_state = "burnkit"
	treatment_time = 30
	heal_burn = 80
	item_count_current = 5
	item_count_max = 10

	value = 20

/obj/item/container/medicine/burn_kit/advanced
	name = "infused burn kit (silver sulfadiazine)"

/obj/item/container/medicine/burn_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/medicine/patch
	name = "medical patch"
	icon_state = "patch"
	treatment_time = 5
	heal_burn = 0
	heal_brute = 0
	item_count_current = 3
	item_count_max = 3

	value = 5

/obj/item/container/medicine/patch/brute
	name = "brute patch (Styptic Powder)"
	icon_state = "patch_brute"

/obj/item/container/medicine/patch/brute/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,60)
	return ..()

/obj/item/container/medicine/patch/burn
	name = "burn patch (Silver Sulfadiazine)"
	icon_state = "patch_burn"

/obj/item/container/medicine/patch/burn/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,60)
	return ..()