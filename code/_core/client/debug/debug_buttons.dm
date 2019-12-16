/client/verb/debug_screen()
	set name = "Debug Screen"
	set category = "Debug"

	for(var/datum/D in screen)
		to_chat("[D.name] ([D.type])")
