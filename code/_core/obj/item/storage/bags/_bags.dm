/obj/item/storage/bags //These are things that always has a container whitelist.
	name = "specific item type bags"
	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining"

	value = 20

/obj/item/storage/bags/click_on_object(var/mob/caller as mob, var/atom/object, location, contmrol, params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/turf/T = get_turf(object)

	if(length(container_whitelist) && get_dist(src,T) <= 1)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/pickup = 0
		for(var/obj/item/I in T.contents)
			if(I.type in container_whitelist)
				if(src.add_to_inventory(caller,I,enable_messages = FALSE,silent=TRUE))
					pickup++
		if(pickup)
			caller?.to_chat(span("notice","You add [pickup] objects to \the [src.name]."))
			//TODO: Pickup sounds.
		else
			caller?.to_chat(span("warning","You fail to pickup anything!"))
		return TRUE

	return ..()

/obj/item/storage/bags/botany
	name = "botany bag"
	desc = "Green bag for a green thumb."
	desc_extended = "A giant green bag that is designed to hold all your plants and seeds. Holds up to 60 plants and seeds."
	icon_state = "botany"

	dynamic_inventory_count = 6
	container_max_size = SIZE_3
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/seed,
		/obj/item/container/food/plant
	)

/obj/item/storage/bags/botany/processor
	name = "botany seed processing bag"
	desc = "Process your seed."
	desc_extended = "A special bag that converts all plant matter into seeds when inserted into the bag."
	icon_state = "botany_processor"

/obj/item/storage/bags/botany/processor/click_self(var/mob/caller)

	if(caller.attack_flags & CONTROL_MOD_ALT)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		process_plants(caller)
		return TRUE

	return ..()

/obj/item/storage/bags/botany/processor/proc/process_plants(var/mob/caller)

	var/process_count = 0

	var/turf/T = get_turf(src)

	for(var/k in inventories)
		CHECK_TICK(50,FPS_SERVER*4)
		var/obj/hud/inventory/I = k
		for(var/obj/item/container/food/plant/P in I.contents)
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
			S.yield = P.yield
			S.growth_speed = S.growth_speed

			FINALIZE(S)
			qdel(P)
			I.add_object(S,FALSE,TRUE,silent=TRUE) //We add the object to this item's inventory.
			process_count++

	caller.to_chat(span("notice","You process [process_count] plants to seeds."))

	return ..()


/obj/item/storage/bags/mining
	name = "mining bag"
	desc = "What if i put my mining bed next to yours?"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots. Holds up to 60 ores and ingots."
	icon_state = "mining"

	dynamic_inventory_count = 6
	container_max_size = SIZE_3
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/material/ore,
		/obj/item/material/ingot
	)

/obj/item/storage/bags/mining/bluespace
	name = "bluespace mining bag"
	icon_state = "mining_bluespace"
	desc = "I got that bluespace fever and I can't sleep!"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots, now in bluespace. Holds up to 90 ores and ingots."
	dynamic_inventory_count = 6
	container_max_size = SIZE_4
	container_max_slots = 30


/obj/item/storage/bags/chemistry
	name = "chemistry bag"
	desc_extended = "A giant white and orange bag that is designed to hold all your medicine. Holds up to 40 objects."
	icon_state = "chemistry"

	dynamic_inventory_count = 6
	container_max_size = SIZE_4
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/container/beaker,
		/obj/item/container/pill,
		/obj/item/container/syringe
	)

/obj/item/storage/bags/chemistry/filled/fill_inventory()


/obj/item/storage/pillbottle
	name = "pill bottle"
	desc = "Be sure to read the label before eating the contents."
	desc_extended = "A pill bottle that can hold up to 30 pills."
	icon = 'icons/obj/item/storage/bottles.dmi'
	icon_state = "pill_canister"

	size = SIZE_1
	dynamic_inventory_count = 1
	container_max_size = SIZE_0
	container_max_slots = 30
	container_whitelist = list(
		/obj/item/container/pill,
	)

	var/color_lid = "#FFFFFF"
	var/color_label = "#FFFFFF"
	var/color_canister = "#D35400"

	drop_sound = 'sound/items/drop/pillbottle.ogg'

	value = 20


/obj/item/storage/pillbottle/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("color_lid")
	SAVEVAR("color_label")
	SAVEVAR("color_canister")
	return .

/obj/item/storage/pillbottle/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("color_lid")
	LOADVAR("color_label")
	LOADVAR("color_canister")
	return .

/obj/item/storage/pillbottle/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/item/storage/pillbottle/update_inventory()
	. = ..()
	update_sprite()
	return .

/obj/item/storage/pillbottle/update_overlays()

	. = ..()

	var/image/lid = new/image(icon,"lid")
	lid.appearance_flags = RESET_COLOR
	lid.color = color_lid
	add_overlay(lid)

	var/image/canister = new/image(icon,"canister")
	canister.appearance_flags = RESET_COLOR
	canister.color = color_canister
	add_overlay(canister)

	var/image/label = new/image(icon,"label")
	label.appearance_flags = RESET_COLOR
	label.color = color_label
	add_overlay(label)

	return .

/obj/item/storage/pillbottle/update_icon()

	. = ..()

	var/chosen_color
	var/filled_slots = 0
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		filled_slots += length(I.contents)
		if(!chosen_color)
			var/obj/item/I2 = I.get_top_object()
			if(I2) chosen_color = I2.color

	var/icon_mod = CEILING( (filled_slots/(dynamic_inventory_count*container_max_slots)) * 7,1)
	icon_state = "contents_[icon_mod]"
	color = chosen_color

	return .


/obj/item/storage/pillbottle/bicaridine
	name = "bicaridine pill bottle"
	desc = "Contains 20 20u bicaridine pills."

/obj/item/storage/pillbottle/bicaridine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/bicaridine(src)
	return ..()

/obj/item/storage/pillbottle/bicaridine_small
	name = "bicaridine pill bottle"
	desc = "Contains 10 20u bicaridine pills."

/obj/item/storage/pillbottle/bicaridine_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/pill/bicaridine(src)
	return ..()

/obj/item/storage/pillbottle/kelotane
	name = "kelotane pill bottle"
	desc = "Contains 20 20u kelotane pills."

/obj/item/storage/pillbottle/kelotane/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/kelotane(src)
	return ..()

/obj/item/storage/pillbottle/kelotane_small
	name = "kelotane pill bottle"
	desc = "Contains 10 20u kelotane pills."

/obj/item/storage/pillbottle/kelotane_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/pill/kelotane(src)
	return ..()

/obj/item/storage/pillbottle/dylovene
	name = "dylovene pill bottle"
	desc = "Contains 20 20u dylovene pills."

/obj/item/storage/pillbottle/dylovene/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/dylovene(src)
	return ..()

/obj/item/storage/pillbottle/dylovene_small
	name = "dylovene pill bottle"
	desc = "Contains 10 20u dylovene pills."

/obj/item/storage/pillbottle/dylovene_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/pill/dylovene(src)
	return ..()


/obj/item/storage/pillbottle/iron
	name = "iron pill bottle"
	desc = "Contains 20 20u iron pills."

/obj/item/storage/pillbottle/iron/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/iron(src)
	return ..()

/obj/item/storage/pillbottle/iron_small
	name = "iron pill bottle"
	desc = "Contains 10 20u iron pills."

/obj/item/storage/pillbottle/iron_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/pill/iron(src)
	return ..()


/obj/item/storage/pillbottle/omnizine
	name = "omnizine pill bottle"
	desc = "Contains 20 20u omnizine pills."

/obj/item/storage/pillbottle/omnizine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/omnizine(src)
	return ..()

/obj/item/storage/pillbottle/charcoal
	name = "charcoal pill bottle"
	desc = "Contains 20 20u charcoal pills."

/obj/item/storage/pillbottle/charcoal/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/charcoal(src)
	return ..()



/obj/item/storage/pillbottle/antihol_small
	name = "antihol bottle"
	desc = "Contains 10 20u antihol pills."

/obj/item/storage/pillbottle/antihol_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/pill/antihol(src)
	return ..()