/obj/item/storage/bags //These are things that always has a container whitelist.
	name = "specific item type bags"
	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining"
	value = 0

/obj/item/storage/bags/botany
	name = "botany bag"
	desc = "Green bag for a green thumb."
	desc_extended = "A giant green bag that is designed to hold all your plants and seeds. Holds up to 60 plants and seeds."
	icon_state = "botany"

	dynamic_inventory_count = 6
	container_max_size = SIZE_2
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/seed,
		/obj/item/container/edible/plant
	)

	value = 30

/obj/item/storage/bags/botany/processor
	name = "botany seed processing bag"
	desc = "Process your seed."
	desc_extended = "A special bag that converts all plant matter into seeds when inserted into the bag."
	icon_state = "botany_processor"

/obj/item/storage/bags/botany/processor/click_self(mob/caller,location,control,params)

	if(caller.attack_flags & CONTROL_MOD_DISARM)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		process_plants(caller)
		return TRUE

	return ..()

/obj/item/storage/bags/botany/processor/proc/process_plants(mob/caller)

	var/process_count = 0

	var/turf/T = get_turf(src)

	for(var/k in inventories)
		CHECK_TICK(50,FPS_SERVER*4)
		var/obj/hud/inventory/I = k
		for(var/obj/item/container/edible/plant/P in I.contents)
			CHECK_TICK(50,FPS_SERVER*2)
			if(!P.plant_type)
				continue
			if(P.loc != I)
				continue
			var/plant_type/PT = SSbotany.all_plant_types[P.plant_type]
			var/obj/item/seed/S = new(T)
			INITIALIZE(S)
			S.icon = PT.seed_icon
			S.icon_state = PT.seed_icon_state

			S.plant_type = P.plant_type

			S.growth_min = P.growth_min
			S.growth_max = P.growth_max
			S.growth_produce_max = P.growth_produce_max

			S.potency = P.potency
			S.yield_max = P.yield_max
			S.growth_speed = S.growth_speed

			FINALIZE(S)
			qdel(P)
			I.add_object(S,FALSE,TRUE,silent=TRUE) //We add the object to this item's inventory.
			process_count++

	caller.to_chat(span("notice","You process [process_count] plants to seeds."))

	return TRUE

/obj/item/storage/bags/blacksmithing
	name = "blacksmithing bag"
	desc = "Just kidding... Unless?"
	desc_extended = "A giant black bag that is designed to hold all your ingots. Holds up to 100 ingots per slot."
	icon_state = "blacksmithing"

	value = 400

	container_max_size = SIZE_2
	dynamic_inventory_count = 8
	container_max_slots = 2
	container_whitelist = list(
		/obj/item/material/ingot
	)

	value = 100




/obj/item/storage/bags/chemistry
	name = "chemistry bag"
	desc_extended = "A giant white and orange bag that is designed to hold all your medicine. Holds up to 40 objects."
	icon_state = "chemistry"

	dynamic_inventory_count = 6
	container_max_size = SIZE_2
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/container/simple/beaker,
		/obj/item/container/edible/pill,
		/obj/item/container/syringe
	)

	value = 30
