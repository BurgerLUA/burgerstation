/mob/living/advanced/proc/start_chargen()

	spawn()

		Initialize()
		//show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET,speed=0)
		//show_hud(TRUE,FLAGS_HUD_MOB,FLAGS_HUD_SPECIAL,3)
		handle_hairstyle_chargen(sex == MALE ? 2 : 16,"#000000")
		handle_beardstyle_chargen(1,"#000000")
		add_outfit("new")

		stop_music_track(client)

		if(ENABLE_LORE)

			play_music_track("space_wayfarer",src.client)

			client.allow_zoom_controls = FALSE
			client.update_zoom(2)

			stun_time = -1
			paralyze_time = -1

			add_notification_colored_easy(client,"#000000",200*5 + 10,fade_in = FALSE, fade_out = TRUE)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_1",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_2",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_3",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_4",180,fade_in = TRUE)
			sleep(200)

			add_notification_easy(client,'icons/hud/discovery.dmi',"intro_5",180,fade_in = TRUE)
			sleep(200)

			stun_time = 20
			paralyze_time = 20



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
		kept_items = drop_all_items(FALSE,TRUE)
	else
		for(var/obj/hud/inventory/I in inventory)
			I.remove_all_objects()

	remove_all_organs()
	remove_all_buttons()

	return kept_items

/mob/living/advanced/proc/post_perform_change(var/keep_items,var/chargen,var/list/kept_items = list())

	apply_mob_parts(FALSE,FALSE)

	update_all_blends()
	update_icon()
	update_health_element_icons(TRUE,TRUE,TRUE)

	if(chargen)
		add_chargen_buttons()

	show_inventory(TRUE,FLAGS_HUD_WORN,FLAGS_HUD_SPECIAL,0.1)
	for(var/obj/hud/button/hide_show_inventory/B in buttons)
		B.update_icon()

	var/species/S = all_species[species]

	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair)
	handle_beardstyle_chargen(1,S.default_color_hair)
	//Blends are updated in the above two procs

	if(length(kept_items))
		equip_objects_in_list(kept_items)
	else
		if(sex == MALE)
			add_outfit("new_male",TRUE)
		else
			add_outfit("new_female",TRUE)

		add_outfit("assistant",TRUE)