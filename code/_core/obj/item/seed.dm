/obj/item/seed
	name = "seed packet"
	desc = "Seed pun here."
	desc_extended = "A packet of seeds that can be planted on soil to grow plants."

	icon = 'icons/obj/item/seed.dmi'
	icon_state = "seed"

	var/plant_type/plant_type

	var/growth_min = 0
	var/growth_max = 100
	var/growth_produce_max = 200

	var/potency = 20
	var/yield = 1
	var/growth_speed = 5

	var/delete_after_harvest = TRUE


/obj/item/seed/save_item_data(var/save_inventory = TRUE)
	. = ..()

	SAVEVAR("icon_state")

	SAVEPATH("plant_type")

	SAVEVAR("growth_min")
	SAVEVAR("growth_max")
	SAVEVAR("growth_produce_max")

	SAVEVAR("potency")
	SAVEVAR("yield")
	SAVEVAR("growth_speed")

	SAVEVAR("delete_after_harvest")

	return .

/obj/item/seed/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()

	LOADVAR("icon_state")

	LOADPATH("plant_type")

	LOADVAR("growth_min")
	LOADVAR("growth_max")
	LOADVAR("growth_produce_max")

	LOADVAR("potency")
	LOADVAR("yield")
	LOADVAR("growth_speed")

	LOADVAR("delete_after_harvest")

	return .