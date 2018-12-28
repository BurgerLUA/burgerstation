/client/verb/debug_all_clients()
	set category = "Debug"

	for(var/client/C in all_clients)
		src << C.ckey

/client/verb/debug_tracker()
	set category = "Debug"

	src << button_tracker.owner

/client/verb/debug_pressed()
	set category = "Debug"

	for(var/pressed_buttons in button_tracker.get_pressed())
		src << pressed_buttons

/client/verb/debug_macros()
	set category = "Debug"

	for(var/listed_macro in macros.macros)
		src << "[listed_macro] [macros.macros[listed_macro]]"

/client/verb/debug_tickcount()
	set category = "Debug"
	src << tick_count

client/verb/debug_active_subsystems()
	set category = "Debug"

	for(var/datum/subsystem/subsystem in active_subsystems)
		src << subsystem.name

client/verb/debug_movement()
	set category = "Debug"

	src << mob.move_dir