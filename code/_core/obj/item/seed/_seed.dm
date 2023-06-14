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
	var/yield_max = 1
	var/yield_percent = 100
	var/growth_speed = 0.05 //Per decisecond.

	var/delete_after_harvest = TRUE

	value = 0

/obj/item/seed/Finalize()

	var/plant_type/P = SSbotany.all_plant_types[plant_type]

	if(!P)
		log_error("Warning: [src.get_debug_name()] didn't have a valid plant type ([plant_type]).")
		qdel(src)
		return ..()

	name = "[P.name] seed packet"
	desc_extended = P.desc
	icon = P.seed_icon
	icon_state = P.seed_icon_state

	return ..()

/obj/item/seed/get_base_value()
	var/plant_type/P = SSbotany.all_plant_types[plant_type]
	. = (P.value * potency) * yield_max * (yield_percent/100)
	. *= (0.1 + growth_speed)
	if(!delete_after_harvest)
		. *= 3
	. += growth_min
	. += max(0,100-growth_max)*0.25
	. += max(0,200-growth_produce_max)*0.25
	. = CEILING(.,5)

/obj/item/seed/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE

	SAVEVAR("icon_state")

	SAVEPATH("plant_type")

	SAVEVAR("growth_min")
	SAVEVAR("growth_max")
	SAVEVAR("growth_produce_max")

	SAVEVAR("potency")
	SAVEVAR("yield_max")
	SAVEVAR("yield_percent")
	SAVEVAR("growth_speed")

	SAVEVAR("delete_after_harvest")


/obj/item/seed/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE

	LOADVAR("icon_state")

	LOADPATH("plant_type")

	LOADVAR("growth_min")
	LOADVAR("growth_max")
	LOADVAR("growth_produce_max")

	LOADVAR("potency")
	LOADVAR("yield_max")
	LOADVAR("yield_percent")
	LOADVAR("growth_speed")

	LOADVAR("delete_after_harvest")


/obj/item/seed/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_turf(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/turf/T = object
		var/plant_type/P = SSbotany.all_plant_types[plant_type]
		if(!P.allowed_turfs[T.type])
			caller.to_chat(span("warning","You can't plant \the [src.name] on \the [T.name]."))
			return TRUE
		var/obj/structure/interactive/plant/PL = new(T)
		PL.plant_type = plant_type
		PL.growth_min = growth_min
		PL.growth_max = growth_max
		PL.growth_produce_max = growth_produce_max
		PL.potency = potency
		PL.yield_max = yield_max
		PL.yield_percent = yield_percent
		PL.growth_speed = growth_speed
		PL.delete_after_harvest = delete_after_harvest
		INITIALIZE(PL)
		FINALIZE(PL)
		if(!PL.dead && !PL.qdeleting)
			PL.set_active(TRUE)
		caller.visible_message(span("notice","\The [caller.name] plants \the [src.name] in \the [T.name], creating a [PL.name]."),span("notice","You plant \the [src.name] in \the [T.name], creating \a [PL.name]."))
		qdel(src)
		return TRUE

	return ..()


