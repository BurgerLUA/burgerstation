/obj/structure/interactive/plant
	name = "plant"
	desc = "A plant grows here."
	//Icon stand and icon is generated.
	icon = 'icons/obj/markers/plant.dmi'
	icon_state = null


	var/plant_type/plant_type

	var/growth = 0 //Increases by growth_speed every second.
	var/growth_min = 0 //This is set AFTER harvesting.
	var/growth_max = 100 //The growth value when this plant is considered grown, but has no produce grown on it.
	var/growth_produce_max = 200 //The growth value when this plant is considered grown, and has produce on it.

	//Stats
	var/potency = 20 //How much chemicals?
	var/yield = 1
	var/growth_speed = 5 //How much to add to growth every second

	var/delete_after_harvest = TRUE

	mouse_opacity = 2

/obj/structure/interactive/plant/New(var/desired_loc)
	SSbotany.all_plants += src
	return ..()

/obj/structure/interactive/plant/Finalize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/plant/Destroy()
	SSbotany.all_plants -= src
	return ..()

/obj/structure/interactive/plant/proc/on_life()

	var/real_growth_speed = growth_speed*TICKS_TO_SECONDS(SSbotany.tick_rate)

	growth += FLOOR(real_growth_speed * (rand(75,125)/100), 1)
	update_sprite()
	return TRUE

/obj/structure/interactive/plant/update_icon()

	var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]

	name = "[associated_plant.name]"

	icon = associated_plant.plant_icon

	if(growth >= growth_produce_max)
		if(associated_plant.plant_icon_state_override)
			icon_state ="[associated_plant.plant_icon_state_override]-harvest"
		else
			icon_state = "[associated_plant.plant_icon_state]-harvest"
	else
		icon_state = "[associated_plant.plant_icon_state]-grow[max(1,CEILING((min(growth,growth_max)/growth_max)*associated_plant.plant_icon_count, 1))]"

	desc = "Icon state: [icon_state]"

/obj/structure/interactive/plant/proc/harvest(var/mob/living/advanced/caller)

	if(growth < growth_produce_max)
		caller.to_chat(span("warning","\The [src.name] is not ready to be harvested!"))
		return TRUE

	var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]

	var/turf/caller_turf = get_turf(caller)

	if(!caller_turf)
		return FALSE


	if(potency <= 0 || yield <= 0)
		caller.to_chat(span("warning","You fail to harvest anything from \the [src.name]!"))
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
			P.icon_state = associated_plant.harvest_icon_state
			P.potency = potency
			P.yield = yield
			P.growth_speed = growth_speed
			P.plant_type = plant_type
			P.can_slice = associated_plant.can_slice
			INITIALIZE(P)
			GENERATE(P)
			for(var/r_id in associated_plant.reagents)
				var/r_value = associated_plant.reagents[r_id] * potency
				P.reagents.add_reagent(r_id,r_value,TNULL,FALSE,FALSE)
			P.reagents.update_container(FALSE)
			FINALIZE(P)
			animate(P,pixel_x = rand(-16,16),pixel_y = rand(-16,16),time=5)

		caller.visible_message(span("notice","\The [caller.name] harvests from \the [src.name]."),span("notice","You harvest [yield] [associated_plant.name]\s from \the [src.name]."))

	growth = growth_min

	if(delete_after_harvest)
		qdel(src)
	else
		potency = potency > initial(potency) ? (initial(potency) + potency)/2 : potency
		yield = yield > initial(yield) ? (initial(yield) + yield)/2 : yield
		growth = growth_max
		update_sprite()

	return TRUE

/obj/structure/interactive/plant/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	harvest(caller)

	return TRUE