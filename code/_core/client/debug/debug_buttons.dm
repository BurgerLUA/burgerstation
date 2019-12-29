/client/verb/debug_screen()
	set name = "Debug Screen"
	set category = "Debug"

	for(var/atom/A in screen)
		to_chat("[A.name] ([A.type])")
