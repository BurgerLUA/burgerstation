/obj/structure/interactive/plant
	name = "plant"
	desc = "A plant grows here."
	desc_extended =  "A growing plant."
	//Icon stand and icon is generated.
	icon = 'icons/obj/markers/plant.dmi'
	icon_state = null

	var/plant_type/plant_type

	//NOTES TO ANY FUTURE BOTANY CODERS:
	//The numbers involved on making plants grow is a fairly complicated, interwoven feedback cycle.desc_extended =
	//You cannot simply change 1 number and expect everything to work as you hoped it would.
	//Its mostly the metabolism part that screws up what is otherwise a straightforward setup, but health changes and tick speed can also
	//cause bigger swings in results than expected. With the current set of numbers, you should mostly be able to change any individual plant values
	//in seed_types.dm to handle any individual plant that needs brought into line.

	var/growth = 0 //Increases by growth_speed every decisecond.
	var/growth_min = 0 //This is set AFTER harvesting.
	var/growth_max = 50 //The growth value when this plant is considered grown, but has no produce grown on it.
	var/growth_produce_max = 200 //The growth value when this plant is considered grown, and has produce on it.

	//current numbers means plants grow in about 45 seconds. WIth the rest of the new demands, this should require mass farming to be a multiple person effort.
	reagents = /reagent_container/plant
	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = FALSE

	//Stats
	var/yield_max = 1 //Maximium yield this plant can give.
	var/potency = 20 //How much chemicals?
	var/yield_percent = 100 //Base harvest chance per yield.
	var/growth_speed = 1 //How much to add to growth every decisecond. A good starting value would be between 0.025 and 0.05

	var/hydration = 50 //Out of 100
	var/nutrition = 50 //Out of 100
	var/age = 0 //In deciseconds. Once it gets old (15 minutes) it starts to take damage.
	var/lifetime = 9000 //The age in which this plant starts dying. 15 minutes = 9000 deciseconds.

	var/delete_after_harvest = TRUE

	health = /health/plant

	mouse_opacity = 2

	var/dead = FALSE

	health_base = 100

	var/natural = FALSE

	var/active = FALSE

/obj/structure/interactive/plant/proc/set_active(var/desired_active=TRUE)
	if(active == desired_active)
		return FALSE
	active = desired_active
	if(active)
		SSbotany.all_plants += src
	else
		SSbotany.all_plants -= src
	return TRUE

/obj/structure/interactive/plant/get_examine_list(var/mob/examiner)
	. = ..()

	if(dead)
		. += span("danger","It's dead, and shriveled...")
	else
		if(growth >= growth_produce_max)
			. += span("notice bold","It is ready for harvest.")
		/*
		if(health)
			switch(health.health_current/health.health_max)
				if(-INFINITY to 0.2)
					. += span("danger","It's starting to shrivel!")
				if(0.2 to 0.3)
					. += span("danger","It looks very unhealthy!")
				if(0.3 to 0.5)
					. += span("warning","It looks unhealthy.")
				if(0.5 to 0.75)
					. += span("notice","It looks like it could use some care.")
		*/

	switch(age/lifetime)
		if(0.6 to 0.7)
			. += span("warning","It looks a little old.")
		if(0.8 to 1)
			. += span("warning","It looks old.")
		if(1 to INFINITY)
			. += span("danger","It looks very old.")

	switch(hydration)
		if(-INFINITY to 10)
			. += span("danger","It looks severely underwatered!")
		if(10 to 50)
			. += span("warning","It looks underwatered, and will not grow.")
		if(50 to 75)
			. += span("notice","It looks like it could use some water.")
		if(75 to 100)
			. += span("notice","It looks properly watered.")
		if(100 to 125)
			. += span("warning","It looks overwatered.")
		if(125 to INFINITY)
			. += span("danger","It looks severely overwatered!")

	switch(nutrition)
		if(-INFINITY to 10)
			. += span("danger","It looks severely underfertilized!")
		if(10 to 50)
			. += span("warning","It looks underfertilized, and will not grow.")
		if(50 to 75)
			. += span("notice","It looks like it could use some fertilizer.")
		if(75 to 100)
			. += span("notice","It looks properly fertilized.")
		if(100 to 125)
			. += span("warning","It looks overfertilized.")
		if(125 to INFINITY)
			. += span("danger","It looks severely overfertilized!")


/obj/structure/interactive/plant/on_destruction(var/damage = TRUE)

	var/should_delete = dead || !damage
	if(damage && !dead)
		set_active(FALSE)
		dead = TRUE
		health.restore()
		update_sprite()
		should_delete = FALSE

	. = ..()

	if(should_delete)
		qdel(src)

/obj/structure/interactive/plant/proc/add_nutrition(var/nutrition_amount)
	nutrition = clamp(nutrition + nutrition_amount,0,200)
	return TRUE

/obj/structure/interactive/plant/proc/add_hydration(var/hydration_amount)
	hydration = clamp(hydration + hydration_amount,0,200)
	return TRUE

/obj/structure/interactive/plant/Generate()
	. = ..()
	growth = growth_produce_max
	lifetime = 60*60*24*7*4*10*rand(1,5)
	hydration = rand(50,75)
	nutrition = rand(50,75)
	age = lifetime * RAND_PRECISE(0.25,0.75)
	age = CEILING(age,1)
	natural = TRUE

/obj/structure/interactive/plant/Finalize()
	. = ..()
	var/plant_type/P = SSbotany.all_plant_types[plant_type]
	if(P && P.allowed_turfs[src.loc.type])
		nutrition *= P.allowed_turfs[src.loc.type]
		hydration *= 0.5 + P.allowed_turfs[src.loc.type]*0.5
	else
		nutrition *= 0.5
		hydration *= 0.5
	update_sprite()
	var/turf/T = get_turf(src)
	if(T)
		var/chunk/C = CHUNK(T)
		if(C)
			C.plants += src


/obj/structure/interactive/plant/PreDestroy()
	set_active(FALSE)
	var/turf/T = get_turf(src)
	if(T)
		var/chunk/C = CHUNK(T)
		if(C)
			C.plants -= src
	. = ..()

/obj/structure/interactive/plant/on_chunk_cross(var/chunk/old_chunk,var/chunk/new_chunk)

	. = ..()

	if(old_chunk)
		old_chunk.plants -= src

	if(new_chunk)
		new_chunk.plants += src

/obj/structure/interactive/plant/proc/on_life(var/tick_rate=1) //Measured in game ticks.

	var/rate = TICKS_TO_DECISECONDS(tick_rate)
	var/plant_type/P = SSbotany.all_plant_types[plant_type]
	var/real_growth_speed = growth_speed * rate * (P.allowed_turfs[src.loc.type] ? P.allowed_turfs[src.loc.type] : 0.1)

	if(nutrition >= 50 && hydration >= 50)
		growth += real_growth_speed

	var/consumption_mod = (1 + growth/100) * real_growth_speed * rate * 1/(P.allowed_turfs[src.loc.type] ? P.allowed_turfs[src.loc.type] : 0.1)
	add_nutrition(-0.005*consumption_mod)
	add_hydration(-0.005*consumption_mod)

	age += rate

	var/brute_to_add = 0
	var/burn_to_add = 0
	var/tox_to_add = 0

	//Damage due to age.
	if(age >= lifetime && !prob(80)) //Old.
		brute_to_add += 0.1*rate

	//Damage due to nutrition.
	if(nutrition <= 10) //Underfertilized.
		brute_to_add += 0.3*(1 - nutrition/25)*rate
	else if(nutrition > 110) //Overfertilized.
		tox_to_add += 0.05*rate
		burn_to_add += 0.025*rate
	else if (nutrition >= 50 && nutrition <= 90) //healthy
		brute_to_add -= 0.1*rate

	//Damage due to hydration.
	if(hydration <= 10) //Underwatered
		burn_to_add += 0.5*(1 - hydration/25)*rate
	else if(hydration > 110) //Overwaterd
		tox_to_add += 0.05*rate
	else if (hydration >= 50 && hydration <= 90) //healthy
		burn_to_add -= 0.05*rate

	if(brute_to_add || burn_to_add || tox_to_add)
		src.health.adjust_loss_smart(
			brute=brute_to_add,
			burn=burn_to_add,
			tox=tox_to_add
		)

	if(reagents && length(reagents.stored_reagents))
		reagents.metabolize(src,rate*0.1) //Assumed that it is metabolism per second.

	update_sprite()

	return TRUE

/obj/structure/interactive/plant/update_icon()

	. = ..()

	var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]

	if(!associated_plant)
		log_error("Could not update plant icon for [src.get_debug_name()] as it did not have an associated plant!")
		return

	name = "[associated_plant.name]"

	icon = associated_plant.plant_icon

	if(dead)
		icon_state = "[associated_plant.plant_icon_state]-dead"

	else if(growth >= growth_produce_max)
		if(associated_plant.plant_icon_state_override)
			icon_state ="[associated_plant.plant_icon_state_override]-harvest"
		else
			icon_state = "[associated_plant.plant_icon_state]-harvest"
	else
		icon_state = "[associated_plant.plant_icon_state]-grow[max(1,CEILING((min(growth,growth_max)/growth_max)*associated_plant.plant_icon_count, 1))]"

	desc = "Icon state: [icon_state]"

/obj/structure/interactive/plant/proc/harvest(var/mob/living/advanced/caller,var/obj/item/harvest_item)

	if(dead)
		caller.to_chat(span("warning","\The [src.name] is dead!"))
		return TRUE

	if(growth < growth_produce_max)
		caller.to_chat(span("warning","\The [src.name] is not ready to be harvested!"))
		return TRUE

	var/turf/caller_turf = get_turf(caller)

	if(!caller_turf)
		return FALSE

	if(!plant_type)
		return FALSE

	var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]

	if(!associated_plant || potency <= 0 || yield_max <= 0)
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

		var/health_mod  = min(health.health_current/health.health_max,1)

		var/child_yield = CEILING(yield_max,1)
		var/child_potency = CEILING(potency,1)

		var/local_potency = potency * health_mod
		var/local_yield = yield_max * health_mod

		var/total_harvests = 0
		if(local_potency > 0 && yield_percent > 0)
			for(var/i=1,i<=local_yield,i++)
				var/local_yield_percent = yield_percent - yield_percent*(total_harvests/local_yield)
				if(!prob(local_yield_percent))
					continue
				var/obj/item/container/edible/plant/P = new(caller_turf)
				P.plant_type = associated_plant.type
				P.pixel_x = animation_offset_x
				P.pixel_y = animation_offset_y
				P.potency =  child_potency
				P.yield_max = child_yield
				P.yield_percent = CEILING(yield_percent,1)
				P.growth_speed = growth_speed
				INITIALIZE(P)
				GENERATE(P)
				for(var/r_id in associated_plant.reagents)
					var/r_value = associated_plant.reagents[r_id] * potency * health_mod
					P.reagents.add_reagent(r_id,r_value,TNULL,FALSE,FALSE)
				FINALIZE(P)
				//Update container is called in Finalize()
				P.reagents.process_recipes(caller)
				animate(P,pixel_x = rand(-16,16),pixel_y = rand(-16,16),time=5)
				total_harvests += 1

		if(total_harvests <= 0)
			caller.visible_message(span("warning","\The [caller.name] fails to harvest anything from \the [src.name]!"),span("warning","You fail to harvest anything from \the [src.name]!"))
		else
			caller.visible_message(span("notice","\The [caller.name] harvests from \the [src.name]."),span("notice","You harvest [total_harvests] [associated_plant.name]\s from \the [src.name]."))

	if(delete_after_harvest)
		growth = 0 //just in case
		qdel(src)
	else
		growth = growth_min
		yield_percent = CEILING(max(0,yield_percent*0.9) - 5,1)
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
