/obj/item/container/medicine/bandage
	name = "bandages"
	icon_state = "brutepack"
	treatment_time = 10
	heal_brute = 10

/obj/item/container/medicine/bandage/advanced
	name = "bicaridine soaked bandages"

/obj/item/container/medicine/bandage/advanced/on_spawn()
	reagents.add_reagent("bicaridine",50)
	return ..()

/obj/item/container/medicine/ointment
	name = "ointment"
	icon_state = "ointment"
	treatment_time = 30
	heal_burn = 10

/obj/item/container/medicine/ointment
	name = "kelotane infused ointment"

/obj/item/container/medicine/ointment/advanced/on_spawn()
	reagents.add_reagent("kelotane",50)
	return ..()

/obj/item/container/medicine/trauma_kit
	name = "trauma kit"
	icon_state = "traumakit"
	treatment_time = 50
	heal_brute = 50

/obj/item/container/medicine/burn_kit
	name = "burn kit"
	icon_state = "burnkit"
	treatment_time = 50
	heal_burn = 50



