/mob/living/advanced/proc/setup_visuals()

	var/species/S = SPECIES(species)

	dna = S.dna

	var/dna/D
	if(dna)
		D = SSliving.all_dna[dna]

	var/desired_hair_color = S.default_color_hair
	var/desired_beard_color = S.default_color_hair
	var/desired_eye_color = S.default_color_eye
	var/desired_skin_color = S.default_color_skin
	var/desired_hair_style = sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female
	var/desired_beard_style = 1
	var/desired_detail_color = S.default_color_detail
	var/desired_glow_color = S.default_color_glow

	if(D)
		desired_skin_color = D.generate_skin_color(fallback=desired_skin_color)

		desired_hair_style = D.generate_hair_style(gender,fallback=desired_hair_style)
		desired_hair_color = D.hair_color_same_as_skin_color ? desired_skin_color : D.generate_hair_color(fallback=desired_hair_color)


		desired_beard_style = D.beard_color_same_as_skin_color ? desired_skin_color : D.generate_beard_style(gender,fallback=desired_beard_style)
		if(D.beard_color_same_as_skin_color)
			desired_beard_color = desired_skin_color
		else if (D.has_seperate_beard_color)
			desired_beard_color = D.generate_beard_color(fallback=desired_beard_color)
		else
			desired_beard_color = desired_hair_color

		desired_eye_color = D.generate_eye_color(fallback=desired_eye_color)

		//TODO
		//desired_detail_color
		//desired_glow_color

	handle_hairstyle_chargen(desired_hair_style,desired_hair_color,FALSE)
	handle_beardstyle_chargen(desired_beard_style,desired_beard_color,FALSE)
	handle_skincolor_chargen(desired_skin_color,FALSE)
	handle_eyecolor_chargen(desired_eye_color,FALSE)
	handle_detail_chargen(desired_detail_color,FALSE)
	handle_glow_chargen(desired_glow_color,FALSE)

	return TRUE


/mob/living/advanced/proc/setup_appearance(var/set_default=FALSE)

	if(sex == PLURAL)
		sex = pick(MALE,FEMALE)
		gender = prob(99) ? sex : pick(MALE,FEMALE,NEUTER)

	var/species/S = SPECIES(species)
	add_species_organs() //Base

	setup_visuals()

	for(var/language in S.languages)
		known_languages[language] = TRUE

	//Blood type
	blood_type = initial(blood_type)
	if(!(blood_type in S.valid_blood_types))
		blood_type = S.generate_blood_type()
	return TRUE


/mob/living/advanced/proc/species_initialize(var/set_default=FALSE)

	var/species/S = SPECIES(species)

	if(!initial(health))

		if(src.finalized)
			qdel(health)
			health = null

		if(S && S.health)
			health = S.health
		else
			health = /health/mob/living/advanced/ //Fallback

		if(health)
			health = new health(src)
			health.armor = src.armor
			if(src.finalized)
				health.Finalize()
				QUEUE_HEALTH_UPDATE(src)

	if(!src.finalized)
		add_ability_buttons()

	setup_appearance(set_default) //Either set the default appearance or load in a saved appearance.

	//Buttons
	if(!src.finalized && is_player_controlled())
		add_species_buttons()
		add_stat_buttons()

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
		B.plane = PLANE_HUD_LOADING
		B.layer = LAYER_HUD_ALL
		client.screen += B
		client.update_zoom(3)

	var/list/organs_to_use = sex == FEMALE && length(S.spawning_organs_female) ? S.spawning_organs_female : S.spawning_organs_male

	if(!length(organs_to_use))
		log_error("ERROR: Species [S.get_debug_name()] didn't have any valid organs to spawn!")
		qdel(src)
		return FALSE

	for(var/key in organs_to_use)
		add_organ(S.spawning_organs_male[key])
		CHECK_TICK(50,FPS_SERVER)

	if(client)
		if(B)
			client.screen -= B
			qdel(B)
			client.update_zoom(2)
		if(!initially_disabled)
			client.disable_controls = FALSE