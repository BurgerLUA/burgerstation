/obj/item/analyzer/value
	name = "value analyzer"
	desc = "Is it worth it?"
	desc_extended = "A special camera and sensor combo that calculates the current market rate of an item."

	icon = 'icons/obj/item/analyzers/value.dmi'
	icon_state = "inventory"
	value = 450

/obj/item/analyzer/value/can_be_scanned(var/mob/activator,var/atom/target)
	return ismovable(target)

/obj/item/analyzer/value/on_scan(var/mob/activator,var/atom/target,location,control,params)
	var/atom/movable/M = target
	var/calculated_value = M.get_value()
	activator.to_chat(span("notice","\The [target.name]'s total value and its contents is worth [nice_number(CEILING(calculated_value,1))] credits(s)."))
	next_scan = world.time + SECONDS_TO_DECISECONDS(4)
	return TRUE