var/global/list/obj/structure/interactive/plant/all_plants = list()

/obj/structure/interactive/plant
	name = "plant"
	desc = "A plant grows here."
	icon = 'icons/obj/structure/botany.dmi'
	icon_state = "spawn"
	id = null

	var/growth = 0 //Increases by growth_speed every 10 seconds.
	var/growth_min = 0 //This is set AFTER harvesting.
	var/growth_max = 100 //The growth value when this plant is considered grown, but has no produce grown on it.
	var/growth_produce_max = 120 //The growth value when this plant is considered grown, and has produce on it.

	//Stats
	var/potency = 20 //How much chemicals?
	var/yield = 1
	var/growth_speed = 5 //How much to add to growth every plant tick

	var/rest_stats_after_harvest = TRUE
	var/delete_after_harvest = FALSE

	mouse_opacity = 2

/obj/structure/interactive/plant/New(var/desired_loc)
	all_plants += src
	return ..()

/obj/structure/interactive/plant/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/plant/Destroy()
	all_plants -= src
	return ..()

/obj/structure/interactive/plant/proc/on_life()
	growth += FLOOR(growth_speed * (rand(75,125)/100), 1)
	update_sprite()
	return TRUE

/obj/structure/interactive/plant/update_icon()

	var/plant_type/associated_plant = all_plant_types[id]

	name = "[associated_plant.name] plant"

	if(growth >= growth_produce_max)
		icon_state = "[id]_grown"
	else
		icon_state = "[id]_[FLOOR((min(growth,growth_max)/growth_max)*associated_plant.icon_count, 1)]"

/obj/structure/interactive/plant/proc/harvest(var/mob/living/advanced/caller)

	if(growth < growth_produce_max)
		caller.to_chat(span("notice","\The [src.name] is not ready to be harvested!"))
		return TRUE

	var/plant_type/associated_plant = all_plant_types[id]

	var/turf/caller_turf = get_turf(caller)

	if(!caller_turf)
		return FALSE


	if(potency <= 0 || yield <= 0)
		caller.to_chat(span("notice","You fail to harvest anything from \the [src.name]!"))
		return TRUE
	else

		var/move_direction = get_dir(src,caller)

		var/animation_offset_x = 0
		var/animation_offset_y = 0

		if(move_direction & NORTH)
			animation_offset_y -= 32

		if(move_direction & SOUTH)
			animation_offset_y += 32

		if(move_direction & EAST)
			animation_offset_x -= 32

		if(move_direction & WEST)
			animation_offset_x += 32

		for(var/i=1,i<=yield,i++)
			var/obj/item/container/food/plant/P = new(caller_turf)
			P.pixel_x = animation_offset_x
			P.pixel_y = animation_offset_y
			P.name = associated_plant.name
			P.desc = associated_plant.desc
			P.icon = associated_plant.harvest_icon
			P.icon_state = associated_plant.id
			P.potency = potency
			P.yield = yield
			P.growth_speed = growth_speed
			INITIALIZE(P)
			GENERATE(P)
			for(var/r_id in associated_plant.reagents)
				var/r_value = associated_plant.reagents[r_id] * potency
				P.reagents.add_reagent(r_id,r_value,TNULL,FALSE,FALSE)
			P.reagents.update_container(FALSE)
			P.original_volume = P.reagents.volume_current
			animate(P,pixel_x = rand(-16,16),pixel_y = rand(-16,16),time=5)

		caller.to_chat(span("notice","You harvest [yield] [associated_plant.name]\s from \the [src.name]."))

	growth = growth_min

	if(delete_after_harvest)
		qdel(src)
	else if(rest_stats_after_harvest)
		potency = initial(potency)
		yield = initial(yield)
		icon = initial(icon)
		icon_state = initial(icon_state)
		update_sprite()

	return TRUE

/obj/structure/interactive/plant/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!is_advanced(caller))
		return ..()

	harvest(caller)

	return TRUE