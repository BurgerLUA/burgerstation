/obj/item/storage/bags //These are things that always has a container whitelist.
	name = "specific item type bags"
	icon = 'icons/obj/item/storage/bags.dmi'
	icon_state = "mining"
	value = -1

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

	value = 30

/obj/item/storage/bags/botany/processor
	name = "botany seed processing bag"
	desc = "Process your seed."
	desc_extended = "A special bag that converts all plant matter into seeds when inserted into the bag."
	icon_state = "botany_processor"

/obj/item/storage/bags/botany/processor/click_self(var/mob/caller)

	if(caller.attack_flags & CONTROL_MOD_DISARM)
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

	return TRUE


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

	value = 100


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

	value = 30

/obj/item/storage/bags/bio
	name = "biobag"
	desc_extended = "A giant green'ish bag that is designed to hold all your biological stuff. And food. Actually just food. Holds up to 50 objects."
	icon_state = "biology"

	dynamic_inventory_count = 5
	container_max_size = SIZE_4
	container_max_slots = 10
	container_whitelist = list(
		/obj/item/container/food
	)

	value = 30

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

	appearance_flags = RESET_COLOR

	drop_sound = 'sound/items/drop/pillbottle.ogg'

	value = 20


/obj/item/storage/pillbottle/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("color_lid")
	SAVEVAR("color_label")
	SAVEVAR("color_canister")

/obj/item/storage/pillbottle/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("color_lid")
	LOADVAR("color_label")
	LOADVAR("color_canister")

/obj/item/storage/pillbottle/PostInitialize()
	. = ..()
	update_sprite()

/obj/item/storage/pillbottle/update_inventory()
	. = ..()
	update_sprite()

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

/obj/item/storage/pillbottle/assprin
	name = "assprin pill bottle"
	desc = "Contains 20 10u assprin painkiller pills. To remove that pain in your ass!"

/obj/item/storage/pillbottle/assprin/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/pill/assprin(src)
	return ..()



/obj/item/storage/bagofhoarding
	name = "bag of hoarding"
	desc = "we just warframe now"
	desc_extended = "A peculiar bag that can hold unlimited amounts of specific rare currencies. Can be dyed."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "moneybag"
	value = 10000
	var/hoard = 0				// how many inside
	var/targetitem				// this one is used for the base item roots, look further down for comments
	var/obj/item/goods			// targeted goods
	container_whitelist = list(
		/obj/item/currency/telecrystals,
		/obj/item/currency/magic_token,
		/obj/item/currency/gold,
		/obj/item/currency/prize_ticket,
		/obj/item/coin/antag_token
	)
	dynamic_inventory_count = 0
	is_container = FALSE
	dyeable = TRUE
	color = "#D8C1B0"


/obj/item/storage/bagofhoarding/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("hoard")
	SAVEPATH("targetitem")
	SAVEATOM("goods")

/obj/item/storage/bagofhoarding/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("hoard")
	LOADPATH("targetitem")
	LOADATOM("goods")

/obj/item/storage/bagofhoarding/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(hoard) . += span("notice","It currently holds [hoard] [goods.name]\s.")
	else . += span("notice","It does not currently hold anything.")

/obj/item/storage/bagofhoarding/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(hoard)
		if(istype(object,/obj/hud/inventory))
			var/mob/living/advanced/C = caller
			var/maxstack = goods.item_count_max
			if(hoard <= maxstack)
				maxstack = hoard
			if((goods.item_count_max == 1) || (hoard == 1))
				var/obj/item/M = new goods.type
				M.drop_item(get_turf(caller))
				C.put_in_hands(M)
				C.to_chat(span("notice","You take out a single [M.name]."))
				hoard--
				INTERACT_DELAY(1)
				if (!hoard)
					caller.to_chat(span("notice","The [src.name] is now empty."))
					goods = null
					return TRUE
				return TRUE
			var/choice = input("How many do you want to take out?","Total: [hoard] Max: [maxstack]") as null|num
			INTERACT_CHECK
			if(!choice) return TRUE
			if(choice >= maxstack)
				var/obj/item/M = new goods.type
				M.item_count_current = maxstack
				M.update_sprite()
				hoard -= maxstack
				M.drop_item(get_turf(caller))
				C.put_in_hands(M)
			else if(choice < maxstack)
				var/obj/item/M = new goods.type
				M.item_count_current = choice
				M.update_sprite()
				hoard -= choice
				M.drop_item(get_turf(caller))
				C.put_in_hands(M)
			if (!hoard)
				caller.to_chat(span("notice","\The [src.name] is now empty."))
				goods = null
			return TRUE
		var/obj/item/I = object
		if(ispath(I.type,targetitem))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			hoard += I.item_count_current
			play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.2)
			qdel(I)
			return TRUE

	if(!hoard)
		var/obj/item/I = object
		var/obj/O
		for(var/allofem in container_whitelist)
			O = allofem
			if(ispath(I.type,O))
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				var/choice = input("Would you like to deposit [I.name] in \the [src.name]?","Hoarding Time") as null|anything in list("Yes","No")
				if(choice == "Yes")
					INTERACT_CHECK
					INTERACT_CHECK_OBJECT
					if(ispath(I.type,/obj/item/currency/telecrystals))	//i dont know how else to do this because like "goods" doesnt work here
						targetitem = /obj/item/currency/telecrystals	//otherwise things like obj/.../telecrystals/goblins and /treasure break
					if(ispath(I.type,/obj/item/currency/magic_token))	//cuz it needs to be shortened back to telecrystals/
						targetitem = /obj/item/currency/magic_token		//keeping the targetitem var is also important for some shit like the desc
					if(ispath(I.type,/obj/item/currency/gold))			//works around it so eh good enough absolute shitcode but smiling imp emoji
						targetitem = /obj/item/currency/gold
					if(ispath(I.type,/obj/item/currency/prize_ticket))
						targetitem = /obj/item/currency/prize_ticket
					if(ispath(I.type,/obj/item/coin/antag_token))
						targetitem = /obj/item/coin/antag_token
					goods = I
					hoard = I.item_count_current
					play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.2)
					caller.to_chat(span("notice","The [src.name] now accepts [I.name]\s."))
					qdel(I)
					return TRUE
	return ..()