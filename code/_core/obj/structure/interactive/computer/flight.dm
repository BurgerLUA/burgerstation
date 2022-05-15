obj/structure/interactive/computer/console/flight
	name = "flight control console"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is. This one controls a shuttle."
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

obj/structure/interactive/computer/console/flight/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	var/obj/shuttle_controller/SC = locate() in get_area(src)

	if(!SC)
		caller.to_chat(span("warning","No shuttle controller found!"))
		return FALSE

	if(SC.time_restricted && !SSgamemode.active_gamemode.allow_launch)
		caller.to_chat(span("warning","The shuttle isn't ready to launch yet!"))
		return FALSE

	var/selection = input("Are you sure you wish to launch this shuttle?","Shuttle Control","Cancel") in list("Yes","No","Cancel")

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(selection == "Yes")
		if(SC.state == SHUTTLE_STATE_LANDED)
			SC.state = SHUTTLE_STATE_WAITING
			SC.time = 0
			caller.to_chat(span("notice","You prepare the shuttle for launch."))
		else
			caller.to_chat(span("warning","ERROR: Shuttle already in transit."))

	return TRUE