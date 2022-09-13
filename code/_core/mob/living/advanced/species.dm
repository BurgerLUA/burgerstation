/mob/living/advanced/proc/setup_visuals()

	var/species/S = SPECIES(species)

	var/dna/D
	if(dna)
		D = SSliving.all_dna[dna]

	var/desired_hair_color = S.default_color_hair
	var/desired_eye_color = S.default_color_eye
	var/desired_skin_color = S.default_color_skin
	var/desired_hair_style = sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female
	var/desired_beard_style = 1
	var/desired_detail_color = S.default_color_detail
	var/desired_glow_color = S.default_color_glow

	if(D)
		desired_hair_color = D.generate_hair_color()
		desired_eye_color = D.generate_eye_color()
		desired_skin_color = D.generate_skin_color()
		desired_hair_style = D.generate_hair_style(gender)
		desired_beard_style = D.generate_beard_style(gender)

	handle_hairstyle_chargen(desired_hair_style,desired_hair_color,FALSE)
	handle_beardstyle_chargen(desired_beard_style,desired_hair_color,FALSE)
	handle_skincolor_chargen(desired_skin_color,FALSE)
	handle_eyecolor_chargen(desired_eye_color,FALSE)
	handle_detail_chargen(desired_detail_color,FALSE)
	handle_glow_chargen(desired_glow_color,FALSE)

	return TRUE


/mob/living/advanced/proc/setup_appearance(var/set_default=FALSE)

	var/species/S = SPECIES(species)
	add_species_organs() //Base

	setup_visuals()

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