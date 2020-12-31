/mob/living/advanced/proc/start_chargen()

	INITIALIZE(src)
	FINALIZE(src)
	default_appearance()
	equip_loadout(/loadout/new_player,TRUE)
	stop_music_track(client)

	nutrition *= RAND_PRECISE(0.5,0.75)
	hydration *= RAND_PRECISE(0.5,0.75)

	/*
	if(client)

		show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET | FLAGS_HUD_CHARGEN,speed=0)

		var/list/lore = list(
			"In the year 2320, Humankind has advanced their interstellar space travel technology to allow for safe and reliable faster than light travel.",
			"Using bluespace drives, any living being or material can instantaneously move from one point to another with a minuscule amount of energy.",
			"With every nation on earth having this technology, it is now possible to travel to and from nearby planets outside our own Sol System regardless of nation or creed.",
			"But it was not just nations that benefited from this discovery; All corporations, even those without prior interest in space exploration, shifted their focus to the near-endless resources of the Universe.",
			"You work for one such corporation; NanoTrasen. Today is your first day at this technology giant.",
			"They promise it won't be your last."
		)

		play_music_track(/track/space_wayfarer,src.client)

		client.disable_controls = TRUE
		client.update_zoom(3)

		var/obj/hud/screen/S = new()
		S.icon = 'icons/hud/discovery.dmi' //320x320
		S.icon_state = "black"
		S.screen_loc = "CENTER-4.5,CENTER-4.5"
		S.client = src.client
		S.maptext = "<font size='4'>A.</font>"
		S.maptext_width = 320
		S.maptext_height = 300
		S.maptext_y = 20
		S.mouse_opacity = 2
		client.screen += S

		//SHITCODE AHOY
		var/cached_text = ""
		for(var/line in lore)
			cached_text += "<br><br>"
			S.maptext = "[cached_text]"
			for(var/char in splittext(line,""))
				cached_text += char
				S.maptext = "[cached_text]"
				sleep(world.tick_lag*2)
			sleep(30)
		sleep(50)
		animate(S,alpha = 0,time = 20)
		sleep(20)


		show_hud(TRUE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL,speed=3)
		client.screen -= S
		qdel(S)

		client.update_zoom(2)
		client.disable_controls = FALSE
	*/




/mob/living/advanced/proc/perform_specieschange(var/desired_species,var/keep_clothes,var/chargen)

	if(!desired_species)
		return FALSE

	var/list/kept_clothes = pre_perform_change(keep_clothes)

	known_languages.Cut()
	species = desired_species
	var/species/S = SPECIES(species)
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
		for(var/k in inventory)
			var/obj/hud/inventory/I = k
			I.delete_objects()

	remove_all_organs()
	remove_all_buttons()

	return kept_items

/mob/living/advanced/proc/default_appearance()
	var/species/S = SPECIES(species)
	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair,FALSE)
	handle_beardstyle_chargen(1,S.default_color_hair,FALSE)
	handle_skincolor_chargen(S.default_color_skin,FALSE)
	handle_eyecolor_chargen(S.default_color_eye,FALSE)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	update_all_blends()

/mob/living/advanced/proc/post_perform_change(var/keep_items,var/chargen,var/list/kept_items = list())

	if(chargen)
		add_chargen_buttons()

	apply_mob_parts(FALSE,FALSE,FALSE)
	default_appearance()
	add_species_buttons()
	add_species_health_elements()

	if(length(kept_items))
		equip_objects_in_list(kept_items)
	else
		equip_loadout(/loadout/new_player,TRUE)


	for(var/obj/hud/button/hide_show_inventory/B in buttons)
		B.update_sprite()

	update_all_blends()
	update_health_element_icons(TRUE,TRUE,TRUE,TRUE)

	show_hud(TRUE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL,speed=3)



