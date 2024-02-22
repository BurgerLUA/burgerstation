/obj/item/analyzer/plant
	name = "plant analyzer"
	desc = "Minmaxing plant setups since 2520."
	desc_extended = "An incredible complex sensor that sends (mostly) harmless radiation waves to calculate a plant's attributes and health."

	icon = 'icons/obj/item/analyzers/armor.dmi'
	icon_state = "inventory"
	value = 100

/obj/item/analyzer/plant/can_be_scanned(var/mob/caller,var/atom/target)
	return istype(target,/obj/structure/interactive/plant)

/obj/item/analyzer/plant/on_scan(var/mob/caller,var/atom/target,location,control,params)

	var/obj/structure/interactive/plant/P = target

	var/list/planet_list = list()

	planet_list += "Name: [P.name]"
	planet_list += "Age: [get_nice_time(P.age/10)]"
	planet_list += "Growth: [P.growth] (Min:[P.growth_min],Max:[P.growth_max],Produce:[P.growth_produce_max])"
	planet_list += "Growth Speed: [P.growth_speed*10*60]/m"
	planet_list += "Potency: [P.potency]"
	planet_list += "Yield: [P.yield_max] ([CEILING(P.yield_percent,1)]% chance)"
	planet_list += "Nutrition: [CEILING(P.nutrition,1)]/100"
	planet_list += "Hydration: [CEILING(P.hydration,1)]/100"

	for(var/k in planet_list)
		caller.to_chat(span("debug",k))

	next_scan = world.time + SECONDS_TO_DECISECONDS(1)

	return TRUE
