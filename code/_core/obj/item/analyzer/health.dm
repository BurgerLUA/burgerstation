/obj/item/analyzer/health
	name = "health analyzer"
	desc = "HOLD STILL AND LET ME TREAT YOU!"
	desc_extended = "A handheld portable health analyzer that prints the target's total recieved damage in an arbitary measurement. It also broadcasts the results of the scan for those who can't bother to read."
	icon = 'icons/obj/item/analyzers/health.dmi'
	icon_state = "inventory"
	value = 50

/obj/item/analyzer/health/can_be_scanned(var/mob/caller,var/atom/target)

	if(get_dist(caller,target) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	return is_living(target)

/obj/item/analyzer/health/on_scan(var/mob/caller,var/atom/target,location,control,params)
	. = "<b>Scan:</b> <font color='red'>[CEILING(target.health.get_brute_loss(),1)]</font>|<font color='yellow'>[CEILING(target.health.get_burn_loss(),1)]</font>|<font color='green'>[CEILING(target.health.get_tox_loss(),1)]</font>|<font color='blue'>[CEILING(target.health.get_oxy_loss(),1)]</font>"
	new/obj/effect/chat_text(target,.,TRUE)
	caller.to_chat(.)
	next_scan = world.time + SECONDS_TO_DECISECONDS(4)
	return TRUE