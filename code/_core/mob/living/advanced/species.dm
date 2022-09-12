/mob/living/advanced/proc/setup_appearance(var/set_default=FALSE)
	var/species/S = SPECIES(species)
	add_species_organs() //Base

	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair,FALSE)
	handle_beardstyle_chargen(1,S.default_color_hair,FALSE)
	handle_skincolor_chargen(S.default_color_skin,FALSE)
	handle_eyecolor_chargen(S.default_color_eye,FALSE)
	handle_detail_chargen(S.default_color_detail,FALSE)
	handle_glow_chargen(S.default_color_glow,FALSE)

	for(var/language in S.languages)
		known_languages[language] = TRUE

	//Blood type
	blood_type = initial(blood_type)
	if(!(blood_type in S.valid_blood_types))
		blood_type = S.generate_blood_type()

	//Inherit Species traits
	S.generate_traits(src)

	return TRUE


/mob/living/advanced/proc/species_initialize(var/set_default=FALSE)

	var/species/S = SPECIES(species)
	setup_appearance(set_default) //Either set the default appearance or load in a saved appearance.

	if(!initial(health))
		if(src.initialized && istype(health))
			qdel(health)
			health = null
		if(S && S.health)
			health = S.health
		else
			health = /health/mob/living/advanced/ //Fallback
		if(src.initialized && health)
			health = new health(src)
			health.armor = armor
			health.Finalize()

	//Buttons
	if(is_player_controlled())
		add_species_buttons()
		add_ability_buttons()
		add_stat_buttons()

	update_items(force=TRUE)

	update_all_blends()

	return TRUE

/mob/living/advanced/player/setup_appearance(var/set_default=FALSE)

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)
	if(set_default || !mobdata || !length(mobdata.loaded_data["organs"]))
		return ..()

	set_mob_data(mobdata["loaded_data"])
	return TRUE



/mob/living/advanced/proc/add_species_organs()

	var/species/S = SPECIES(species)

	if(!S)
		log_error("WARNING: INVALID SPECIES: [species].")
		return FALSE

	var/obj/hud/flash/B
	var/initially_disabled = FALSE
	if(client)
		initially_disabled = client.disable_controls
		client.disable_controls = TRUE
		B = new()
		B.icon = 'icons/hud/discovery.dmi' //320x320
		B.icon_state = "black"
		B.screen_loc = "CENTER-4.5,CENTER-4.5"
		B.maptext = "<font size='4'>Loading...</font>"
		B.maptext_width = 320
		B.maptext_height = 300
		B.maptext_y = 20
		B.mouse_opacity = 0
		B.layer = 99 //I DON'T GIFE A FUKC
		client.screen += B
		client.update_zoom(3)
	if(sex == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in S.spawning_organs_female)
			add_organ(S.spawning_organs_female[key])
			CHECK_TICK_SAFE(50,FPS_SERVER)
	else
		for(var/key in S.spawning_organs_male)
			add_organ(S.spawning_organs_male[key])
			CHECK_TICK_SAFE(50,FPS_SERVER)

	if(client)
		if(B)
			client.screen -= B
			qdel(B)
			client.update_zoom(2)
		if(!initially_disabled)
			client.disable_controls = FALSE