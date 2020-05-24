/client/proc/update_verbs()
	CLEAR_VERBS(src)
	add_inherent_verbs()
	if(mob)
		CLEAR_VERBS(mob)
		mob.add_inherent_verbs()
	return TRUE

/client/proc/add_inherent_verbs()
	verbs += /client/verb/ooc
	verbs += /client/verb/toggle_focus
	verbs += /client/verb/focus_map
	verbs += /client/verb/focus_input
	verbs += /client/verb/button_press
	verbs += /client/verb/button_release
	verbs += /client/verb/toggle_fullscreen
	verbs += /client/verb/change_click_mode
	verbs += /client/verb/set_volume_master
	verbs += /client/verb/set_volume_fx
	verbs += /client/verb/set_volume_ambient
	verbs += /client/verb/set_volume_music
	verbs += /client/verb/set_volume_footsteps
	verbs += /client/verb/ghost
	verbs += /client/verb/edit_macros
	verbs += /client/verb/set_fps
	verbs += /client/verb/open_discord
	verbs += /client/verb/open_github

	if(ENABLE_ATMOS)
		verbs += /client/verb/air_test

	if(ckey == "burgerbb")
		verbs += /client/verb/add_new_wikibot_entry
		verbs += /client/verb/rtv
		verbs += /client/verb/trigger_shutdown
		verbs += /client/verb/get_threat_level
		verbs += /client/verb/get_enemies_to_spawn
		verbs += /client/verb/stealth_test
		verbs += /client/verb/map_test

	return TRUE

/client/verb/open_discord()
	set name = "Open Discord"
	set hidden = TRUE
	to_chat("Opening discord in your browser.")
	src << run("https://discord.gg/yEaV92a")

/client/verb/open_github()
	set name = "Open Github"
	set hidden = TRUE
	to_chat("Opening github in your browser.")
	src << run("https://github.com/BurgerLUA/burgerstation")


/client/verb/stealth_test()
	set name = "Stealth Test"

	var/list/offset = direction_to_pixel_offset(mob.dir)

	var/turf/T = locate(mob.x + offset[1]*5, mob.y + offset[2]*5, mob.z)
	if(T)
		var/mob/living/advanced/npc/syndicate/map/M = new(T)
		M.dir = mob.dir
		INITIALIZE(M)




/client/verb/map_test()
	set name = "Map Test"
	set category = "DANGER ZONE"

	var/confirm = input("Are you sure you want to generate a map icon?","Map Generation") in list("Yes","No","Cancel")|null

	if(confirm == "Yes")
		var/found_tiles = 0
		var/error_tiles = 0
		var/icon/I = new/icon('icons/map_template.dmi',"map_template")
		for(var/x=1,x<=255,x++)
			for(var/y=1,y<=255,y++)
				var/turf/simulated/S = locate(x,y,src.mob.z)
				var/found_color = S.color
				if(!found_color)
					var/icon/I2 = S.icon
					if(!istype(I2))
						I2 = new/icon(S.icon,S.icon_state)
					found_color = I2.GetPixel(16,16)
				if(found_color)
					I.DrawBox(found_color,x,y)
					found_tiles++
				else
					error_tiles++

				sleep(-1)

		src << "Found [found_tiles] tiles, with [error_tiles] errored tiles."
		src << "Icon: [new/image(I)]."
		src << ftp(I,"map_[src.mob.z].png")



