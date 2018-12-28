var/global/list/all_clients = list()

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/datum/button_tracker/button_tracker
	var/datum/macros/macros
	fps = FPS_CLIENT

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
