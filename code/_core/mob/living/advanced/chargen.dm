/mob/living/advanced/proc/start_chargen()

	Initialize()
	//show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET | FLAGS_HUD_CHARGEN,speed=0)
	default_appearance()
	if(sex == MALE)
		equip_loadout("new_male",TRUE)
	else
		equip_loadout("new_female",TRUE)
	stop_music_track(client)


	if(ENABLE_LORE && client)

		var/list/lore = list(
			"The year is 2520.",
			"Decades ago, humankind reached a crucial landmark in interstellar space travel technology: safe and reliable faster than light travel.",
			"All nations, regardless of wealth or prosperity, have access to this miraculous technology. It is now possible for humanity to expand beyond the Sol System.",
			"We are now in an era where every soul now has the unrestricted ability to travel to and from nearby planets outside their own systems within mere seconds of preperation and travel time.",
			"However, it was not just sovereign nations benefiting from this discovery; All corporations, even those without prior interest in space exploration, shifted their focus to the near-endless resources of the Universe.",
			"Corporate entities of all types sought to claim land with this new technology. With new land, came new resources. With new resources, came new wealth. With new wealth, came new corporate wars and Corporate Military Forces.",
			"A new age of greed plagued mankind as a whole. As the wealth of corporations grew, non-corporate powers dwindled by comparison. Governments could not effectively uphold the law. Space became a new lawless wild west.",
			"In this wild west, ",
		)

		play_music_track("space_wayfarer",src.client)

		client.disable_controls = TRUE
		client.update_zoom(2) //200%

		add_notification_colored_easy(client,"#000000",600 + 10,fade_in = FALSE, fade_out = TRUE)


		var/obj/hud/screen/S = new()
		S.icon = 'icons/hud/discovery.dmi' //320x320
		S.icon_state = "black"
		S.screen_loc = "CENTER-4.5,CENTER-4.5"
		S.client = src.client
		S.maptext = "<font size='4'>A.</font>"
		S.maptext_width = 320
		S.maptext_height = 320
		S.mouse_opacity = 2
		client.screen += S

		//SHITCODE AHOY
		var/cached_text = ""
		for(var/line in lore)
			for(var/char in splittext(line,""))
				cached_text += char
				S.maptext = "[cached_text]"
				sleep(world.tick_lag*3)
			sleep(30)
			cached_text += "<br><br>"
			S.maptext = "[cached_text]"
		sleep(50)
		animate(S,alpha = 0,time = 100)
		sleep(100)


		client.screen -= S
		qdel(S)

		client.disable_controls = FALSE




/mob/living/advanced/proc/perform_specieschange(var/desired_species,var/keep_clothes,var/chargen)

	if(!desired_species)
		return FALSE

	var/list/kept_clothes = pre_perform_change(keep_clothes)

	species = desired_species
	var/species/S = all_species[species]
	if(S.genderless)
		sex = MALE
		gender = MALE

	post_perform_change(keep_clothes,chargen,kept_clothes)

/mob/living/advanced/proc/perform_sexchange(var/desired_sex,var/keep_clothes,var/chargen)

	if(sex == desired_sex)
		return FALSE

	var/list/kept_clothes = pre_perform_change(keep_clothes)

	sex = desired_sex
	gender = desired_sex
	post_perform_change(keep_clothes,chargen,kept_clothes)

	return TRUE

/mob/living/advanced/proc/pre_perform_change(var/keep_items)


	var/list/kept_items = list()

	if(keep_items)
		kept_items = drop_all_items(src,FALSE,TRUE)
	else
		for(var/obj/hud/inventory/I in inventory)
			I.remove_all_objects()

	remove_all_organs()
	remove_all_buttons()

	return kept_items

/mob/living/advanced/proc/default_appearance()
	var/species/S = all_species[species]
	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair,FALSE)
	handle_beardstyle_chargen(1,S.default_color_hair,FALSE)
	handle_skincolor_chargen(S.default_color_skin,FALSE)
	handle_eyecolor_chargen(S.default_color_eye,FALSE)
	update_all_blends()

/mob/living/advanced/proc/post_perform_change(var/keep_items,var/chargen,var/list/kept_items = list())

	if(chargen)
		add_chargen_buttons()

	apply_mob_parts(FALSE,FALSE,FALSE)
	default_appearance()

	if(length(kept_items))
		equip_objects_in_list(kept_items)
	else
		if(sex == MALE)
			equip_loadout("new_male",TRUE)
		else
			equip_loadout("new_female",TRUE)

	for(var/obj/hud/button/hide_show_inventory/B in buttons)
		B.update_sprite()

	update_all_blends()
	update_health_element_icons(TRUE,TRUE,TRUE,TRUE)
	//show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET | FLAGS_HUD_CHARGEN,speed=0)



