/obj/structure/interactive/ore_deposit
	name = "ore deposit"
	desc = "MINECRAFT."
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	initialize_type = INITIALIZE_LATE
	var/obj/item/material/ore/stored_ore //We don't need to spawn this yet.
	var/ore_max = 5 // How much can the vein hold?
	var/deep_ore_max = 100 //How much does a deep-vein hold? - the thrombosis.
	var/ore_count = 0 // How much does it hold currently
	alpha = 200
/obj/structure/interactive/ore_deposit/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller

		if(!is_item(object))
			A.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
			return TRUE

		var/obj/item/I = object

		if(!(I.flags_tool & FLAG_TOOL_PICKAXE))
			A.to_chat(span("notice","You need a mining tool in order to mine \the [src.name]."))
			return TRUE
		if(ore_count <= 0)
			A.to_chat(span("notice", "The [name] runs dry!"))
			qdel(src)
		ore_count--
		src.drop_ore(A,stored_ore)
		INTERACT_DELAY(I.tool_time)

	return TRUE

/obj/structure/interactive/ore_deposit/proc/drop_ore(var/mob/caller,var/ore_to_spawn)
	var/obj/item/TO = new src.stored_ore
	var/obj/structure/interactive/ore_box/OB = locate() in range(1,src)
	INITIALIZE(TO)
	GENERATE(TO)
	FINALIZE(TO)
	if(OB)
		TO.drop_item(OB.loc)
	else
		TO.drop_item(caller.loc)

/obj/structure/interactive/ore_deposit/random

/obj/structure/interactive/ore_deposit/random/New(var/desired_loc)

	var/list/possible_materials = list(
		/obj/structure/interactive/ore_deposit/iron = 100,
		/obj/structure/interactive/ore_deposit/plasma = 10,
		/obj/structure/interactive/ore_deposit/carbon = 50,
		/obj/structure/interactive/ore_deposit/gold = 20,
		/obj/structure/interactive/ore_deposit/silver = 30,
		/obj/structure/interactive/ore_deposit/diamond = 5,
		/obj/structure/interactive/ore_deposit/uranium = 30,
		/obj/structure/interactive/ore_deposit/copper = 25,
		/obj/structure/interactive/ore_deposit/titanium = 25,
		/obj/structure/interactive/ore_deposit/zinc = 25,
		/obj/structure/interactive/ore_deposit/magnesium = 25,
		/obj/structure/interactive/ore_deposit/aluminium = 25,
		/obj/structure/interactive/ore_deposit/nickel = 25
	)

	var/obj/structure/interactive/ore_deposit/ore_type = pickweight(possible_materials)
	stored_ore = initial(ore_type.stored_ore)
	ore_count = rand(1,initial(ore_type.ore_max))
	name = initial(ore_type.name)
	icon_state = initial(ore_type.icon_state)
	return ..()

/obj/structure/interactive/ore_deposit/iron
	name = "iron deposit"
	icon_state = "deposit_iron"
	stored_ore = /obj/item/material/ore/iron
	ore_max = 10

/obj/structure/interactive/ore_deposit/copper
	name = "copper deposit"
	color = "#E28446"
	stored_ore = /obj/item/material/ore/copper
	ore_max = 7
	deep_ore_max = 70

/obj/structure/interactive/ore_deposit/tin
	name = "tin deposit"
	color = "#E2E2E2"
	stored_ore = /obj/item/material/ore/tin
	ore_max = 7
	deep_ore_max = 70

/obj/structure/interactive/ore_deposit/zinc
	name = "zinc deposit"
	color = "#E8E8EF"
	stored_ore = /obj/item/material/ore/zinc
	ore_max = 6
	deep_ore_max = 60

/obj/structure/interactive/ore_deposit/gold
	name = "gold deposit"
	icon_state = "deposit_gold"
	stored_ore = /obj/item/material/ore/gold
	ore_max = 5
	deep_ore_max = 50

/obj/structure/interactive/ore_deposit/uranium
	name = "uranium deposit"
	icon_state = "deposit_uranium"
	stored_ore = /obj/item/material/ore/uranium
	ore_max = 5
	deep_ore_max = 50

/obj/structure/interactive/ore_deposit/titanium
	name = "titanium deposit"
	stored_ore = /obj/item/material/ore/titanium
	ore_max = 3
	deep_ore_max = 50

/obj/structure/interactive/ore_deposit/silver
	name = "silver deposit"
	icon_state = "deposit_silver"
	stored_ore = /obj/item/material/ore/silver
	ore_max = 5
	deep_ore_max = 50

/obj/structure/interactive/ore_deposit/carbon
	name = "coal deposit"
	icon_state = "deposit_coal"
	stored_ore = /obj/item/material/ore/carbon
	ore_max = 3
	deep_ore_max = 10

/obj/structure/interactive/ore_deposit/magnesium
	name = "magnesium deposit"
	stored_ore = /obj/item/material/ore/magnesium
	ore_max = 3
	deep_ore_max = 30

/obj/structure/interactive/ore_deposit/aluminium
	name = "aluminium deposit"
	stored_ore = /obj/item/material/ore/aluminium
	color = "#C4C4C4"
	ore_max = 3
	deep_ore_max = 30

/obj/structure/interactive/ore_deposit/nickel
	name = "nickel deposit"
	stored_ore = /obj/item/material/ore/nickel
	ore_max = 3
	deep_ore_max = 30

/obj/structure/interactive/ore_deposit/plasma
	name = "phoron plasma deposit"
	icon_state = "deposit_phoron"
	stored_ore = /obj/item/material/ore/plasma
	ore_max = 3
	deep_ore_max = 10

/obj/structure/interactive/ore_deposit/diamond
	name = "diamond deposit"
	icon_state = "deposit_diamond"
	stored_ore = /obj/item/material/ore/diamond
	ore_max = 3
	deep_ore_max = 10
//deep ore
/obj/structure/interactive/ore_deposit_ground
	name = "deep ore deposit"
	desc = "bring out the excavator"
	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"
	var/obj/item/material/ore/stored_ore //We don't need to spawn this yet.
	var/ore_count = 0 // How much does it hold currently
	initialize_type = INITIALIZE_LATE

/obj/structure/interactive/ore_deposit_ground/clicked_on_by_object(mob/caller, atom/object, location, control, params)
	caller.to_chat(span("notice","This vein is far too deep to mine manually! You should get a Drill to do it for you!"))
	return TRUE
	
/obj/structure/interactive/ore_deposit_ground/proc/drop_ore(var/caller,var/ore_to_spawn)

	var/obj/structure/interactive/mining_drill/MD = locate() in range(1,src)
	var/obj/structure/interactive/ore_box/OB = locate() in orange(2,src)
	if(!MD)
		CRASH("Who the fuck called drop_ore on a deep vein without a drill? [caller] did.")
	
	var/obj/item/TO = new src.stored_ore
	INITIALIZE(TO)
	GENERATE(TO)
	FINALIZE(TO)
	if(OB)
		TO.drop_item(OB.loc)
	else
		TO.drop_item(MD.loc)

/obj/structure/interactive/ore_deposit_ground/random
	

/obj/structure/interactive/ore_deposit_ground/random/New(var/desired_loc)

	var/list/possible_materials = list(
		/obj/structure/interactive/ore_deposit/iron = 100,
		/obj/structure/interactive/ore_deposit/plasma = 10,
		/obj/structure/interactive/ore_deposit/carbon = 20,
		/obj/structure/interactive/ore_deposit/gold = 50,
		/obj/structure/interactive/ore_deposit/silver = 50,
		/obj/structure/interactive/ore_deposit/diamond = 25,
		/obj/structure/interactive/ore_deposit/uranium = 60,
		/obj/structure/interactive/ore_deposit/copper = 10,
		/obj/structure/interactive/ore_deposit/titanium = 40,
		/obj/structure/interactive/ore_deposit/zinc = 10,
		/obj/structure/interactive/ore_deposit/magnesium = 10,
		/obj/structure/interactive/ore_deposit/aluminium = 10,
		/obj/structure/interactive/ore_deposit/nickel = 10
	)
	var/obj/structure/interactive/ore_deposit/ore_type = pickweight(possible_materials)
	stored_ore = initial(ore_type.stored_ore)
	var/ore_number = initial(ore_type.deep_ore_max)
	ore_count = rand(round(ore_number/3,1),ore_number)
	name = initial("deep [ore_type.name]")
	icon_state = initial(ore_type.icon_state)
	return ..()

