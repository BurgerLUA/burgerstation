/obj/item/analyzer/gps
	name = "gps"
	desc = "Where are you?"
	desc_extended = "A highly advanced gps and rangefinder that can get the location of where you aim it."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/analyzers/gps.dmi'
	icon_state = "inventory"
	value = 700

/obj/item/analyzer/gps/can_be_scanned(var/mob/caller,var/atom/target)
	return TRUE

/obj/item/analyzer/gps/on_scan(var/mob/caller,var/atom/target,location,control,params)

	if(!target || !caller)
		caller.to_chat(span("warning","Invalid target!"))
		return FALSE

	caller.to_chat(span("notice","Position: ([target.x],[target.y],[target.z])."))
	caller.to_chat(span("notice","Angle: [get_angle(caller,target)] degrees."))
	next_scan = world.time + SECONDS_TO_DECISECONDS(2)
	return TRUE