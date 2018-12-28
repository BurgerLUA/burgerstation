var/global/list/all_clients = list()

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	fps = FPS

	var/datum/button_tracker/button_tracker
	var/datum/macros/macros


/client/New()
	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	all_clients += src

	src.mob = new /mob/living/advanced/human


/client/verb/button_press(button as text)
	set hidden = TRUE
	set instant = TRUE
	button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	set instant = TRUE
	button_tracker.set_released(button)

/client/verb/debug_all_clients()
	for(var/client/C in all_clients)
		src << C.ckey

/client/verb/debug_tracker()
	src << button_tracker.owner

/client/verb/debug_pressed()
	for(var/pressed_buttons in button_tracker.get_pressed())
		src << pressed_buttons

/client/verb/debug_macros()
	for(var/listed_macro in macros.macros)
		src << "[listed_macro] [macros.macros[listed_macro]]"

/client/verb/debug_tickcount()
	src << tick_count

client/verb/debug_active_subsystems()
	for(var/datum/subsystem/subsystem in active_subsystems)
		src << subsystem.name

client/verb/debug_movement()
	src << mob.move_dir
