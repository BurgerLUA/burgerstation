/genetic_code/

	var/species/species
	var/sex

	var/icon_hair_head
	var/icon_state_hair_head

	var/icon_hair_face
	var/icon_state_hair_face

	var/color_hair_head
	var/color_hair_face

	var/color_skin
	var/color_glow
	var/color_detail

	var/color_eyes

	var/mob/living/advanced/owner

/genetic_code/proc/get_save_data()

	. = list()

	.["species"] = species.id
	.["sex"] = sex
	.["icon_hair_head"] = icon_hair_head
	.["icon_hair_face"] = icon_hair_face
	.["color_hair_head"] = color_hair_head
	.["color_hair_face"] = color_hair_face
	.["color_skin"] = color_skin
	.["color_glow"] = color_glow
	.["color_detail"] = color_detail
	.["color_eyes"] = color_eyes

	return .


/genetic_code/proc/update_sex() //And gender
	if(species.genderless)
		owner.gender = NEUTER
	owner.remove_all_organs()
	sync_species_organs()
	sync_species_colors()
	apply_visuals()

/genetic_code/proc/sync_species_organs()

	if(!species)
		log_error("WARNING: INVALID SPECIES: [species].")
		return FALSE

	var/obj/hud/screen/B
	var/initially_disabled = FALSE
	if(owner.client)
		initially_disabled = owner.client.disable_controls
		owner.client.disable_controls = TRUE
		B = new()
		B.icon = 'icons/hud/discovery.dmi' //320x320
		B.icon_state = "black"
		B.screen_loc = "CENTER-4.5,CENTER-4.5"
		B.client = owner.client
		B.maptext = "<font size='4'>Loading...</font>"
		B.maptext_width = 320
		B.maptext_height = 300
		B.maptext_y = 20
		B.mouse_opacity = 0
		B.layer = 99 //I DON'T GIFE A FUKC
		owner.client.screen += B
		owner.client.update_zoom(3)
	if(sex == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in species.spawning_organs_female)
			owner.add_organ(species.spawning_organs_female[key])
			if(world_state == STATE_RUNNING) sleep(world.tick_lag)
	else
		for(var/key in species.spawning_organs_male)
			owner.add_organ(species.spawning_organs_male[key])
			if(world_state == STATE_RUNNING) sleep(world.tick_lag)

	if(owner.client)
		if(B)
			owner.client.screen -= B
			qdel(B)
			owner.client.update_zoom(2)
		if(!initially_disabled)
			owner.client.disable_controls = FALSE


/genetic_code/proc/sync_species_colors()

	if(species.default_color_skin)
		color_skin = species.default_color_skin

	if(species.default_color_eye)
		color_eyes = species.default_color_eye

	if(species.default_color_hair)
		color_hair_head = species.default_color_hair
		color_hair_face = species.default_color_hair

	if(species.default_icon_hair && species.default_icon_state_hair)
		icon_hair_head = species.default_icon_hair
		icon_state_hair_head = species.default_icon_state_hair

	if(species.default_icon_hair_face && species.default_icon_state_hair_face)
		icon_hair_face = species.default_icon_hair_face
		icon_state_hair_face = species.default_icon_state_hair_face

	if(species.default_color_detail)
		color_detail = species.default_color_detail

	if(species.default_color_glow)
		color_glow = species.default_color_glow

/genetic_code/proc/apply_visuals()
	owner.change_organ_visual("skin", desired_color = color_skin)
	owner.change_organ_visual("skin_detail", desired_color = color_detail)
	owner.change_organ_visual("skin_glow", color_glow)
	owner.change_organ_visual("hair_head", desired_icon = icon_hair_head, desired_icon_state = icon_state_hair_head, desired_color = color_hair_head)
	owner.change_organ_visual("hair_face", desired_icon = icon_hair_face, desired_icon_state = icon_state_hair_face, desired_color = color_hair_face)

/genetic_code/proc/apply_species_colors()

	//Eye
	if(species.default_color_eye)
		color_eyes = species.default_color_eye

	//Skin
	if(species.default_color_skin)
		color_skin = species.default_color_skin

	if(species.default_color_detail)
		color_detail = species.default_color_detail

	if(species.default_color_glow)
		color_glow = species.default_color_glow

	//Hair
	if(species.default_color_hair)
		color_hair_head = species.default_color_hair
		color_hair_face = species.default_color_hair

	if(species.default_icon_hair)
		icon_hair_head = species.default_icon_hair

	if(species.default_icon_state_hair)
		icon_state_hair_head = species.default_icon_state_hair

	if(species.default_icon_hair_face)
		icon_hair_face = species.default_icon_hair_face

	if(species.default_icon_state_hair_face)
		icon_state_hair_face = species.default_icon_state_hair_face

	return TRUE