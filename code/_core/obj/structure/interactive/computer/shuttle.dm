obj/structure/interactive/computer/console/flight_control
	name = "flight control console"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is. This one controls a shuttle."
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

obj/structure/interactive/computer/console/flight_control/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	var/obj/shuttle_controller/SC = locate() in get_area(src)

	if(!SC)
		caller.to_chat(span("warning","Error: No shuttle controller found!"))
		return FALSE

	if(SC.time_restricted && !SSgamemode.active_gamemode.allow_launch)
		caller.to_chat(span("warning","Error: The shuttle isn't ready to launch yet!"))
		return FALSE

	var/obj/hud/button/map_background/M_background = locate() in caller.buttons
	if(M_background)
		caller.to_chat(span("warning","Close your current map to access \the [src.name]!"))
		return FALSE

	M_background = new(caller,desired_shuttle_controller=SC)
	M_background.update_owner(caller)