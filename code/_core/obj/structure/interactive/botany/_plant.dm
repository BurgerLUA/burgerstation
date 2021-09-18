/obj/structure/interactive/plant
	name = "plant"
	desc = "A plant grows here."
	desc_extended =  "A growing plant."
	//Icon stand and icon is generated.
	icon = 'icons/obj/markers/plant.dmi'
	icon_state = null

	var/plant_type/plant_type

	//NOTES TO ANY FUTURE BOTANY CODERs:
	//The numbers involved on making plants grow is a fairly complicated, interwoven feedback cycle.desc_extended =
	//You cannot simply change 1 number and expect everything to work as you hoped it would.
	//Its mostly the metabolism part that screws up what is otherwise a straightforward setup, but health changes and tick speed can also
	//cause bigger swings in results than expected. With the current set of numbers, you should mostly be able to change any individual plant values
	//in seed_types.dm to handle any individual plant that needs brought into line.

	var/growth = 0 //Increases by growth_speed every second.
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
	var/yield_percent = 100 //Harvest chance per yield.
	var/growth_speed = 40 //How much to add to growth every second. Looks high, but there's so many other percentage modifiers it needs to be for plants to grow at all.
// no, it was just high ^

	var/hydration = 35 //Out of 100
	var/nutrition = 35 //Out of 100
	var/age = 0 //In seconds. Once it gets old (15 minutes) it starts to take damage.
	var/lifetime = 900 //The age in which this plant starts dying. 15 minutes @ 900

	var/delete_after_harvest = TRUE

	health = /health/plant

	mouse_opacity = 2

	var/dead = FALSE

	health_base = 100

	var/natural = FALSE

/obj/structure/interactive/plant/get_examine_list(var/mob/examiner)
	. = ..()

	switch(age/lifetime)
		if(0.6 to 0.7)
			. += span("warning","It looks a little old.")
		if(0.8 to 0.1)
			. += span("warning","It looks old.")
		if(1 to INFINITY)
			. += span("warning","It looks very old.")

	switch(hydration)
		if(0 to 10)
			. += span("danger","It looks severely underwatered!")
		if(10 to 30)
			. += span("warning","It looks underwatered.")
		if(30 to 50)
			. += span("notice","It looks like it could use some water.")
		if(50 to 90)
			. += span("notice","It looks properly watered.")
		if(90 to 125)
			. += span("warning","It looks overwatered.")
		if(125 to 200)
			. += span("warning","It looks severely overwatered!")

	switch(nutrition)
		if(0 to 10)
			. += span("danger","It looks severely underfertilized!")
		if(10 to 30)
			. += span("warning","It looks underfertilized.")
		if(30 to 50)
			. += span("notice","It looks like it could use some fertilizer.")
		if(50 to 90)
			. += span("notice","It looks properly fertilized.")
		if(90 to 125)
			. += span("warning","It looks overfertilized.")
		if(125 to 200)
			. += span("warning","It looks severely overfertilized!")

	. += span("notice","AGE: [age] GROWTH [growth] ")



/obj/structure/interactive/plant/on_destruction(var/mob/caller,var/damage = FALSE)
	if(damage && !dead)
		SSbotany.all_plants -= src //The dead don't think anymore.
		dead = TRUE
		health.restore()
		update_sprite()
	. = ..()
	if(dead || !damage)
		qdel(src)

/obj/structure/interactive/plant/proc/add_nutrition(var/nutrition_amount)
	nutrition += nutrition_amount
	nutrition = clamp(nutrition,0,200)
	return TRUE

/obj/structure/interactive/plant/proc/add_hydration(var/hydration_amount)
	hydration += hydration_amount
	hydration = clamp(hydration,0,200)
	return TRUE

/obj/structure/interactive/plant/New(var/desired_loc)
	SSbotany.all_plants += src
	. = ..()

/obj/structure/interactive/plant/Generate()
	. = ..()
	growth = growth_produce_max
	lifetime = 60*60*24*7*4*rand(1,5)
	hydration = rand(50,75)
	nutrition = rand(50,75)
	age = lifetime * RAND_PRECISE(0.25,0.75)
	age = CEILING(age,1)
	natural = TRUE

/obj/structure/interactive/plant/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/plant/Destroy()
	SSbotany.all_plants -= src
	. = ..()

/obj/structure/interactive/plant/proc/on_life(var/tick_rate=1) //Measured in game ticks.

	var/rate = TICKS_TO_DECISECONDS(tick_rate)
	var/plant_type/P = SSbotany.all_plant_types[plant_type]
	var/real_growth_speed = growth_speed * rate * (P.allowed_turfs[src.loc.type] ? P.allowed_turfs[src.loc.type] : 0.1)

	if(nutrition >= 10 && hydration >= 10)
		growth += real_growth_speed

	if(!natural)
		//plants need 1 water for every 2 seconds they're alive, and 1 nutrition for every 8.
		//Plants gain between 3-8 growth every second (varies by crop) and they need 100 to harvest.
		//nutrition/hyrdation get added during metabolize_plant, but it's hard to tell how fast added water goes into the plant.
		add_nutrition(-0.125) //-real_growth_speed*0.25)
		add_hydration(-0.5) //-real_growth_speed)

	age += rate / 10

	var/brute_to_add = 0
	var/tox_to_add = 0
	if(age >= lifetime && !prob(80)) //Old.
		brute_to_add += 1
	if(nutrition <= 10) //Underfertilized.
		brute_to_add += 3*(1 - nutrition/25)
	else if(nutrition > 110) //Overfertilized.
		tox_to_add += 1
	else if (nutrition >= 50 && nutrition <= 90) //healthy
		brute_to_add -= 1
	if(hydration <= 10) //Underwatered
		brute_to_add += 5*(1 - hydration/25)
	else if(hydration > 110) //Overwaterd
		tox_to_add += 1
	else if (hydration >= 50 && hydration <= 90) //healthy
		tox_to_add -= 1
	if(brute_to_add || tox_to_add)
		src.health.adjust_loss_smart(brute=brute_to_add,tox=tox_to_add)

	if(reagents)
		//Fake metabolism.
		var/total_metabolized = 0
		for(var/r_id in reagents.stored_reagents)
			var/reagent/R = REAGENT(r_id)
			var/volume = reagents.stored_reagents[r_id]
			var/amount_metabolized = R.on_metabolize_plant(src,reagents,volume,1)
			if(amount_metabolized > 0)
				total_metabolized += reagents.remove_reagent(r_id,amount_metabolized,FALSE,FALSE,null)

		if(total_metabolized > 0)
			reagents.update_container()

	//dead plants auto-remove themselves
	var/health_percent = health.health_current/health.health_max
	if(health_percent <= 0.01)
		src.visible_message(span("warning","\The [src.name] dies!"),span("warning","You, somehow a plant, have died and read this message?"))
		qdel(src)
	else
		update_sprite()

	return TRUE

/obj/structure/interactive/plant/update_icon()

	var/plant_type/associated_plant = SSbotany.all_plant_types[plant_type]

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

		var/skill_power = caller.get_skill_power(SKILL_BOTANY,0,1,2)
		var/health_mod  = health.health_current/health.health_max

		var/child_yield = yield_max
		var/child_potency = potency

		var/local_potency = (potency  + (skill_power * 10)) * health_mod //10 skill gives +1 potency, up to 10 extra at lv.100
		var/local_yield = (yield_max  + (skill_power * 2)) * health_mod  //50 skill gives +1 yield, up to 2 extra at lv100

		//Guarentee at least 1 for each.
		local_potency = CEILING(local_potency,1)
		local_yield = CEILING(local_yield,1)

		var/list/harvest_contents = list()
		for(var/i=1,i<=local_yield,i++)
			var/obj/item/container/food/plant/P = new(caller_turf)
			P.plant_type = associated_plant.type
			P.pixel_x = animation_offset_x
			P.pixel_y = animation_offset_y
			P.potency =  child_potency //associated_plant.potency //CEILING(local_potency,1)
			P.yield_max = child_yield //CEILING(local_yield,1)
			P.yield_percent = CEILING(yield_percent,1)
			P.growth_speed = growth_speed
			INITIALIZE(P)
			GENERATE(P)
			for(var/r_id in associated_plant.reagents)
				var/r_value = associated_plant.reagents[r_id] * potency * health_mod + (skill_power * 10) //10 skill adds 1 extra chemical, up to 10 extra at lv100
				P.reagents.add_reagent(r_id,r_value,TNULL,FALSE,FALSE)
			P.reagents.update_container(FALSE)
			FINALIZE(P)
			animate(P,pixel_x = rand(-16,16),pixel_y = rand(-16,16),time=5)
			harvest_contents += P

		var/total_harvests = length(harvest_contents)
		if(total_harvests <= 0)
			caller.visible_message(span("warning","\The [caller.name] fails to harvest anything from \the [src.name]!"),span("warning","You fail to harvest anything from \the [src.name]!"))
		else
			caller.visible_message(span("notice","\The [caller.name] harvests from \the [src.name]."),span("notice","You harvest [total_harvests] [associated_plant.name]\s from \the [src.name]."))
			caller.add_skill_xp(SKILL_BOTANY, FLOOR(total_harvests*potency,1))

	if(delete_after_harvest)
		growth = 0 //just in case
		qdel(src)
	else
		growth = growth_min
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
