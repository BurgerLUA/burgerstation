/obj/item/container/food/plant
	name = "plant"
	desc = "For vegans."
	desc_extended = "The trick to not spending money is that there's food pretty much everywhere if you're not afraid of poisoning."

	icon = 'icons/obj/item/consumable/food/plants.dmi'
	icon_state = "burger"

	consume_verb = "eat"

	var/plant_type/plant_type

	var/growth_min = 0
	var/growth_max = 100
	var/growth_produce_max = 200

	var/potency = 20
	var/yield = 1
	var/growth_speed = 5

	var/delete_after_harvest = TRUE
	var/can_slice = FALSE
	var/sliced = FALSE

	drop_sound = 'sound/items/drop/herb.ogg'

	scale_sprite = TRUE

/obj/item/container/food/plant/Finalize()
	if(plant_type && SSbotany.all_plant_types[plant_type])
		var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]
		typical_volume = associated_plant.typical_volume
	else
		log_error("Warning: [src.get_debug_name()] didn't have a valid plant type.")
	return ..()

/obj/item/container/food/plant/Initialize()


	if(!sliced && can_slice)
		health = /health/obj/item/misc/

	if(sliced)
		icon = 'icons/obj/item/consumable/food/sliced.dmi'
		scale_sprite = FALSE
		pixel_height = 1
		pixel_height_offset = -1

	return ..()

/obj/item/container/food/plant/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return health && !sliced && can_slice

/obj/item/container/food/plant/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(!sliced && can_slice && ((damage_table[BLADE] && !damage_table[BLUNT]) || damage_table[BLADE] > damage_table[BLUNT])) //Cut
		var/original_volume = reagents.volume_current
		var/turf/T = get_turf(src)
		var/slices_to_create = CEILING(original_volume/5,1)
		for(var/i=1,i<=slices_to_create,i++)
			var/obj/item/container/food/plant/S = new(T)
			S.growth_min = growth_min
			S.growth_max = growth_max
			S.growth_produce_max = growth_produce_max
			S.potency = FLOOR(potency/5,1)
			S.yield = FLOOR(yield/5,1)
			S.growth_speed = growth_speed
			S.delete_after_harvest = delete_after_harvest
			S.sliced = TRUE
			S.icon_state = icon_state
			S.plant_type = plant_type
			INITIALIZE(S)
			if(S.reagents) src.reagents.transfer_reagents_to(S.reagents,5)
			FINALIZE(S)
			animate(S,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=5)
		attacker.visible_message(span("notice","\The [attacker.name] slices \the [src.name]."),span("notice","You slice \the [src.name]."))
		qdel(src)

	return ..()

/obj/item/container/food/plant/save_item_data(var/save_inventory = TRUE)
	. = ..()

	SAVEVAR("icon_state")

	SAVEPATH("plant_type")

	SAVEVAR("sliced")
	SAVEVAR("can_slice")

	SAVEVAR("growth_min")
	SAVEVAR("growth_max")
	SAVEVAR("growth_produce_max")

	SAVEVAR("potency")
	SAVEVAR("yield")
	SAVEVAR("growth_speed")

	SAVEVAR("delete_after_harvest")

	return .

/obj/item/container/food/plant/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()

	LOADVAR("icon_state")

	LOADPATH("plant_type")

	LOADVAR("sliced")
	LOADVAR("can_slice")

	LOADVAR("growth_min")
	LOADVAR("growth_max")
	LOADVAR("growth_produce_max")

	LOADVAR("potency")
	LOADVAR("yield")
	LOADVAR("growth_speed")

	LOADVAR("delete_after_harvest")

	return .

/obj/item/container/food/plant/nitrogen_flower
	name = "nitrogen flower"
	icon_state = "nitrogen_flower"

/obj/item/container/food/plant/nitrogen_flower/Generate()
	reagents.add_reagent(/reagent/nitrogen,10)
	return ..()

/obj/item/container/food/plant/oxygen_fruit
	name = "oxygen fruit"
	icon_state = "oxygen_fruit"

/obj/item/container/food/plant/oxygen_fruit/Generate()
	reagents.add_reagent(/reagent/oxygen,10)
	return ..()

/obj/item/container/food/plant/wheat
	name = "wheat"
	icon_state = "wheat"

/obj/item/container/food/plant/wheat/Generate()
	reagents.add_reagent(/reagent/nutrition/wheat_grain,10)
	return ..()

/obj/item/container/food/plant/sugarcane
	name = "sugarcane"
	icon_state = "sugarcane"

/obj/item/container/food/plant/sugarcane/Generate()
	reagents.add_reagent(/reagent/nutrition/sugar/cane,10)
	return ..()