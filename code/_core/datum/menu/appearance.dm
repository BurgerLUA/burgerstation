/menu/appearance/
	name = "Appearance Editor"
	id = "appearance_editor"
	file = 'html/chargen_appearance.html'
	resources = list(
		"button_blue.png" = 'html/button_blue.png',
		"button_blue_extended.png" = 'html/button_blue_extended.png',
		"button_green_extended.png" = 'html/button_green_extended.png',
		"button_grey.png" = 'html/button_grey.png',
		"left.png" = 'html/left.png',
		"right.png" = 'html/right.png',
		"tile.png" = 'html/tile.png',
		"chargen_head.png" = 'html/chargen_head.png'
	)

	var/list/valid_hair_head_ids = list(
		"none",
		"hair_a",
		"hair_b",
		"hair_c",
		"hair_d",
		"hair_e",
		"hair_f"
	)
	var/list/valid_hair_face_ids = list(
		"none",
		"facial_fullbeard_s",
		"facial_wise_s",
		"facial_5oclock_s",
		"facial_gt_s"
	)

	size = "800x800"

/menu/appearance/cache_resources(var/user)
	..()

	for(var/k in valid_hair_head_ids)
		var/icon/v = hair_head_icons[k]
		user << browse_rsc(v,"[k].png")


	for(var/k in valid_hair_face_ids)
		var/icon/v = hair_face_icons[k]
		user << browse_rsc(v,"[k].png")

	/*
	for(var/k in hair_head_icons)
		var/icon/v = hair_head_icons[k]
		user << browse_rsc(v,"[k].png")

	for(var/k in hair_face_icons)
		var/icon/v = hair_face_icons[k]
		user << browse_rsc(v,"[k].png")
	*/

/menu/appearance/open(var/mob/user)
	//Credit to Multiverse7 for providing the code for getting this to work.
	if(ENABLE_CHARGEN)
		cache_resources(user)
		winclone(user, "window", id)
		play_sound('sounds/music/menu/chargen.ogg',list(user),list(user.x,user.y,user.z),loop=1,channel=SOUND_CHANNEL_MUSIC)
		winset(user, "browser([id])", "parent=map;type=browser;size=0x0;anchor1=0,0;anchor2=100,100;is-visible=true")
		user << output(file, "browser([id])")
	else if(is_advanced(user))
		var/mob/living/advanced/A = user
		A.Initialize()
		stop_sound('sounds/music/menu/lobby.ogg',list(user))
		A.chargen = FALSE

/menu/appearance/on_load(var/mob/user)

	run_function(usr,"set_reference","'\ref[src]'")

	if(TRUE)
		var/final_args = "'hair_head'"
		final_args += ",'[english_list(valid_hair_head_ids, nothing_text = "", and_text = "|", comma_text = "|", final_comma_text = "")]'"
		//final_args += ",'[english_list(hair_head_names, nothing_text = "", and_text = "|", comma_text = "|", final_comma_text = "")]'"
		run_function(usr,"generate_color_icon_picker",final_args)

	if(TRUE)
		var/final_args = "'hair_face'"
		final_args += ",'[english_list(valid_hair_face_ids, nothing_text = "", and_text = "|", comma_text = "|", final_comma_text = "")]'"
		//final_args += ",'[english_list(hair_face_names, nothing_text = "", and_text = "|", comma_text = "|", final_comma_text = "")]'"
		run_function(usr,"generate_color_icon_picker",final_args)

	run_function(usr,"get_data_to_send","")

/menu/appearance/Topic(href,href_list)

	if(length(href_list))
		if(href_list["give_me_color"])
			var/desired_type = href_list["give_me_color"]
			var/menu/M = all_menus[desired_type]
			M.open(usr)
			return

		var/list/forged_data = list()

		forged_data["name"] = sanitize(href_list["name"])
		forged_data["sex"] = href_list["sex"]

		forged_data["head"] = list()
		forged_data["head"]["color"] = "#[href_list["skin_color"]]"
		forged_data["head"]["icon"] = 'icons/mob/living/advanced/species/human.dmi'
		forged_data["head"]["icon_state"] = "head_[href_list["sex"]]"

		forged_data["hair_head"] = list()
		forged_data["hair_head"]["color"] = "#[href_list["hair_color"]]"
		forged_data["hair_head"]["icon"] = 'icons/mob/living/advanced/hair/head.dmi'
		forged_data["hair_head"]["icon_state"] = href_list["hair_style"]

		forged_data["hair_face"] = list()
		forged_data["hair_face"]["color"] = "#[href_list["beard_color"]]"
		forged_data["hair_face"]["icon"] = 'icons/mob/living/advanced/hair/face.dmi'
		forged_data["hair_face"]["icon_state"] = href_list["beard_style"]

		forged_data["eye_l"] = list()
		forged_data["eye_l"]["color"] = "#[href_list["eye_color"]]"
		forged_data["eye_l"]["icon"] = 'icons/mob/living/advanced/species/human.dmi'
		forged_data["eye_l"]["icon_state"] = "eye_l"

		forged_data["eye_r"] = list()
		forged_data["eye_r"]["color"] = "#[href_list["eye_color"]]"
		forged_data["eye_r"]["icon"] = 'icons/mob/living/advanced/species/human.dmi'
		forged_data["eye_r"]["icon_state"] = "eye_r"

		forged_data["mouth"] = list()
		forged_data["mouth"]["color"] = "#[href_list["lip_color"]]"
		forged_data["mouth"]["icon"] = 'icons/mob/living/advanced/species/human.dmi'
		forged_data["mouth"]["icon_state"] = href_list["lips_enabled"] == "true" ? "mouth" : "none"

		forged_data["blush"] = list()
		forged_data["blush"]["color"] = "#[href_list["blush_color"]]"
		forged_data["blush"]["icon"] = 'icons/mob/living/advanced/species/human.dmi'
		forged_data["blush"]["icon_state"] = href_list["blush_enabled"] == "true" ? "blush" : "none"

		if(href_list["save_and_quit"] && href_list["save_and_quit"] == "true")
			var/choice = input(usr,"Are you sure you want to save and finish creating your character? You won't be able to change your character again until later in the game.") in list("Yes","No")
			if(choice == "Yes")
				winset(usr, "browser([id])","is-visible:false")
				if(is_advanced(usr))
					var/mob/living/advanced/A = usr
					apply_javascript_to_mob(usr,forged_data)

					if(A.sex == MALE)
						A.add_outfit("new_male",TRUE)
					else
						A.add_outfit("new_female",TRUE)

					open_menu(A,"class_editor")

			return

		var/icon/generated_icon_NORTH = generate_character_icon(forged_data,NORTH)
		usr << browse_rsc(generated_icon_NORTH,"character_NORTH.png")

		var/icon/generated_icon_EAST = generate_character_icon(forged_data,EAST)
		usr << browse_rsc(generated_icon_EAST,"character_EAST.png")

		var/icon/generated_icon_WEST = generate_character_icon(forged_data,WEST)
		usr << browse_rsc(generated_icon_WEST,"character_WEST.png")

		var/icon/generated_icon_SOUTH = generate_character_icon(forged_data,SOUTH)
		usr << browse_rsc(generated_icon_SOUTH,"character_SOUTH.png")

		sleep(3)
		run_function(usr,"refresh_character")




/proc/apply_javascript_to_mob(var/mob/living/advanced/player/A,var/forged_data)
	A.real_name = forged_data["name"]
	A.sex = forged_data["sex"] == "m" ? MALE : FEMALE
	A.gender = forged_data["sex"] == "m" ? MALE : FEMALE
	A.Initialize()
	A.change_organ_visual("hair_head", desired_icon = forged_data["hair_head"]["icon"], desired_icon_state = forged_data["hair_head"]["icon_state"], desired_color = forged_data["hair_head"]["color"])
	A.change_organ_visual("hair_face", desired_icon = forged_data["hair_face"]["icon"], desired_icon_state = forged_data["hair_face"]["icon_state"], desired_color = forged_data["hair_face"]["color"])
	A.change_organ_visual("skin", desired_color = forged_data["head"]["color"])
	A.change_organ_visual("eye", desired_color = forged_data["eye_r"]["color"])
	A.change_organ_visual("blush", desired_color = forged_data["blush"]["color"], desired_icon = forged_data["blush"]["icon"], desired_icon_state = forged_data["blush"]["icon_state"])
	A.change_organ_visual("lips", desired_color = forged_data["mouth"]["color"], desired_icon = forged_data["mouth"]["icon"], desired_icon_state = forged_data["mouth"]["icon_state"])
	A.update_all_blends()

/proc/generate_character_icon(var/list/data,direction = SOUTH)

	var/icon/I = new /icon(data["head"]["icon"],data["head"]["icon_state"],direction)
	I.Blend(data["head"]["color"],ICON_MULTIPLY)

	var/icon/hair_icon = new /icon(data["hair_head"]["icon"],data["hair_head"]["icon_state"],direction)
	hair_icon.Blend(data["hair_head"]["color"],ICON_MULTIPLY)

	var/icon/beard_icon = new /icon(data["hair_face"]["icon"],data["hair_face"]["icon_state"],direction)
	beard_icon.Blend(data["hair_face"]["color"],ICON_MULTIPLY)

	var/icon/eye_l_icon = new /icon(data["eye_l"]["icon"],data["eye_l"]["icon_state"],direction)
	eye_l_icon.Blend(data["eye_l"]["color"],ICON_MULTIPLY)

	var/icon/eye_r_icon = new /icon(data["eye_r"]["icon"],data["eye_r"]["icon_state"],direction)
	eye_r_icon.Blend(data["eye_r"]["color"],ICON_MULTIPLY)

	var/icon/mouth_icon = new /icon(data["mouth"]["icon"],data["mouth"]["icon_state"],direction)
	mouth_icon.Blend(data["mouth"]["color"],ICON_MULTIPLY)

	var/icon/blush_icon = new /icon(data["blush"]["icon"],data["blush"]["icon_state"],direction)
	blush_icon.Blend(data["blush"]["color"],ICON_MULTIPLY)

	I.Blend(eye_r_icon,ICON_OVERLAY)
	I.Blend(eye_l_icon,ICON_OVERLAY)
	I.Blend(blush_icon,ICON_OVERLAY)
	I.Blend(beard_icon,ICON_OVERLAY)
	I.Blend(mouth_icon,ICON_OVERLAY)
	I.Blend(hair_icon,ICON_OVERLAY)

	I.Shift(SOUTH,9)
	I.Scale(128, 128)
	I.Crop(64-32,64-32,64+32,64+32)

	return I