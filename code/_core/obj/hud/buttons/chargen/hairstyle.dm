mob/living/advanced/proc/handle_hairstyle_chargen(var/hair_num=-1,var/desired_color,var/update_blends=TRUE) //This needs to be called when the buttons are made visible.

	var/species/S = SPECIES(species)

	if(hair_num == -1)
		if(labeled_organs[BODY_HAIR_HEAD])
			var/obj/item/organ/beard/O = labeled_organs[BODY_HAIR_HEAD]
			if(O.additional_blends["hair_head"])
				var/icon_blend/IB = O.additional_blends["hair_head"]
				hair_num = IB.icon_state
				desired_color = IB.color
	if(!isnum(hair_num))
		var/found_value = SSspecies.all_hair_files[S.default_icon_hair].Find(hair_num)
		if(found_value)
			hair_num = found_value
		else
			hair_num = 1

	var/choice01 = hair_num - 2
	var/choice02 = hair_num - 1
	var/choice_main = hair_num + 0
	var/choice03 = hair_num + 1
	var/choice04 = hair_num + 2

	for(var/obj/hud/button/chargen/hairstyle/slot01/B in buttons)
		B.hair_num = choice01
		if(desired_color)
			B.hair_color = desired_color
		B.update_sprite()

	for(var/obj/hud/button/chargen/hairstyle/slot02/B in buttons)
		B.hair_num = choice02
		if(desired_color)
			B.hair_color = desired_color
		B.update_sprite()

	for(var/obj/hud/button/chargen/hairstyle/main/B in buttons)
		B.hair_num = choice_main
		if(desired_color)
			B.hair_color = desired_color
		B.update_sprite()

	for(var/obj/hud/button/chargen/hairstyle/slot03/B in buttons)
		B.hair_num = choice03
		if(desired_color)
			B.hair_color = desired_color
		B.update_sprite()

	for(var/obj/hud/button/chargen/hairstyle/slot04/B in buttons)
		B.hair_num = choice04
		if(desired_color)
			B.hair_color = desired_color
		B.update_sprite()

	for(var/obj/hud/button/chargen/change_hairstyle/B in buttons)
		B.hair_num = hair_num

	var/final_hair_number = clamp(choice_main,1,length(SSspecies.all_hair_files[S.default_icon_hair]))
	var/hair_icon = SSspecies.all_hair_files[S.default_icon_hair][final_hair_number]
	if(desired_color)
		change_organ_visual("hair_head", desired_icon = S.default_icon_hair, desired_icon_state = hair_icon, desired_color = desired_color, should_update = update_blends)
	else
		change_organ_visual("hair_head", desired_icon = S.default_icon_hair, desired_icon_state = hair_icon, should_update = update_blends)



	return TRUE

/obj/hud/button/chargen/change_hairstyle
	name = "cycle hairstyle right"
	dir = EAST
	icon_state = "arrow"

	var/hair_num = 1

	screen_loc = "CENTER+3,CENTER+4"

	user_colors = TRUE

	chargen_flags = CHARGEN_HAIR

/obj/hud/button/chargen/change_hairstyle/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/species/S = SPECIES(A.species)
		var/desired_hair_num = clamp(hair_num + (dir == EAST ? 1 : -1),1,length(SSspecies.all_hair_files[S.default_icon_hair]))
		A.handle_hairstyle_chargen(desired_hair_num)

/obj/hud/button/chargen/change_hairstyle/left
	name = "cycle hairstyle left"
	dir = WEST

	screen_loc = "CENTER-3,CENTER+4"

/obj/hud/button/chargen/hairstyle/
	icon_state = "square_round"
	var/hair_num = 0
	var/hair_color = "#000000"

	chargen_flags = CHARGEN_HAIR

	user_colors = TRUE

/obj/hud/button/chargen/hairstyle/update_overlays()

	. = ..()

	var/mob/living/advanced/A = owner
	var/species/S = SPECIES(A.species)

	if(hair_num >= 1 && hair_num <= length(SSspecies.all_hair_files[S.default_icon_hair]))
		var/hair_icon = SSspecies.all_hair_files[S.default_icon_hair][hair_num]
		if(hair_icon)
			var/obj/item/organ/head/H
			if(A.sex == FEMALE && length(S.spawning_organs_female) && S.spawning_organs_female[BODY_HEAD])
				H = S.spawning_organs_female[BODY_HEAD]
			else
				H = S.spawning_organs_male[BODY_HEAD]
			var/image/I_head = new/image(initial(H.icon),initial(H.icon_state))
			var/image/I_hair = new/image(S.default_icon_hair,hair_icon)
			I_head.pixel_y = -9
			I_hair.pixel_y = -9
			I_hair.color = hair_color
			add_overlay(I_head)
			add_overlay(I_hair)

/obj/hud/button/chargen/hairstyle/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()
	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.handle_hairstyle_chargen(hair_num)

	return TRUE

/obj/hud/button/chargen/hairstyle/main
	name = "change hair style"
	desc_extended = "Your currently selected hair style. Clicking here will change the color."
	icon_state = "square_round"
	screen_loc = "CENTER,CENTER+4"

/obj/hud/button/chargen/hairstyle/main/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Hair Color","Hair Color",hair_color) as color|null
		if(desired_color)
			A.handle_hairstyle_chargen(hair_num,desired_color)


/obj/hud/button/chargen/hairstyle/slot01
	icon_state = "square_trim"
	screen_loc = "CENTER-2,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot02
	icon_state = "square_trim"
	screen_loc = "CENTER-1,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot03
	icon_state = "square_trim"
	screen_loc = "CENTER+1,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot04
	icon_state = "square_trim"
	screen_loc = "CENTER+2,CENTER+4"




