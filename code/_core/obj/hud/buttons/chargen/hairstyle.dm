mob/living/advanced/proc/handle_hairstyle_chargen(var/hair_num=1,var/desired_color) //This needs to be called when the buttons are made visible.

	var/choice01 = hair_num - 2
	var/choice02 = hair_num - 1
	var/choice_main = hair_num + 0
	var/choice03 = hair_num + 1
	var/choice04 = hair_num + 2

	for(var/obj/hud/button/chargen/hairstyle/slot01/B in buttons)
		B.hair_num = choice01
		if(desired_color)
			B.hair_color = desired_color
		B.update_icon()

	for(var/obj/hud/button/chargen/hairstyle/slot02/B in buttons)
		B.hair_num = choice02
		if(desired_color)
			B.hair_color = desired_color
		B.update_icon()

	for(var/obj/hud/button/chargen/hairstyle/main/B in buttons)
		B.hair_num = choice_main
		if(desired_color)
			B.hair_color = desired_color
		B.update_icon()

	for(var/obj/hud/button/chargen/hairstyle/slot03/B in buttons)
		B.hair_num = choice03
		if(desired_color)
			B.hair_color = desired_color
		B.update_icon()

	for(var/obj/hud/button/chargen/hairstyle/slot04/B in buttons)
		B.hair_num = choice04
		if(desired_color)
			B.hair_color = desired_color
		B.update_icon()

	for(var/obj/hud/button/chargen/change_hairstyle/B in buttons)
		B.hair_num = hair_num

	var/hair_id = hair_head_ids[choice_main]
	var/hair/head/H = hair_head_types[hair_id]
	if(desired_color)
		change_organ_visual("hair_head", desired_icon = H.icon, desired_icon_state = H.icon_state, desired_color = desired_color)
	else
		change_organ_visual("hair_head", desired_icon = H.icon, desired_icon_state = H.icon_state)

	update_all_blends()

	return TRUE

/obj/hud/button/chargen/change_hairstyle
	name = "cycle hairstyle right"
	dir = EAST
	icon_state = "arrow"

	var/hair_num = 1

	screen_loc = "CENTER+3,CENTER+4"

/obj/hud/button/chargen/change_hairstyle/main/update_owner(var/mob/desired_owner)
	. = ..()
	if(. && is_advanced(desired_owner))
		var/mob/living/advanced/A = desired_owner
		A.handle_hairstyle_chargen(A.sex == MALE ? 2 : 16)

	return .

/obj/hud/button/chargen/change_hairstyle/clicked_by_object(var/mob/caller,object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		hair_num = Clamp(hair_num + (dir == EAST ? 1 : -1),1,length(hair_head_types))
		A.handle_hairstyle_chargen(hair_num)

	return TRUE

/obj/hud/button/chargen/change_hairstyle/left
	name = "cycle hairstyle left"
	dir = WEST

	screen_loc = "CENTER-3,CENTER+4"

/obj/hud/button/chargen/hairstyle/
	icon_state = "square_round"
	var/hair_num = 0
	var/hair_color = "#000000"

/obj/hud/button/chargen/hairstyle/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(hair_num >= 1 && hair_num <= length(hair_head_types))
		var/hair_id = hair_head_ids[hair_num]
		if(hair_id)
			var/hair/head/H = hair_head_types[hair_id]
			if(H)
				name = H.name
				var/icon/I = new/icon(icon,icon_state)
				var/icon/I2 = new/icon('icons/mob/living/advanced/species/human.dmi',"head_m")
				var/icon/I3 = new/icon(H.icon,H.icon_state)
				I3.Blend(hair_color,ICON_MULTIPLY)
				I2.Blend(I3,ICON_OVERLAY)
				I2.Shift(SOUTH,9)
				I.Blend(I2,ICON_OVERLAY)
				icon = I

	..()

/obj/hud/button/chargen/hairstyle/clicked_by_object(var/mob/caller,object,location,control,params)
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.handle_hairstyle_chargen(hair_num)
	return TRUE

/obj/hud/button/chargen/hairstyle/main
	icon_state = "square_round"
	screen_loc = "CENTER,CENTER+4"

/obj/hud/button/chargen/hairstyle/main/clicked_by_object(var/mob/caller,object,location,control,params)
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_color = input("Hair Color") as color
		A.handle_hairstyle_chargen(hair_num,desired_color)

	return TRUE

/obj/hud/button/chargen/hairstyle/slot01
	icon_state = "square_round_small"
	screen_loc = "CENTER-2,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot02
	icon_state = "square_round_small"
	screen_loc = "CENTER-1,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot03
	icon_state = "square_round_small"
	screen_loc = "CENTER+1,CENTER+4"

/obj/hud/button/chargen/hairstyle/slot04
	icon_state = "square_round_small"
	screen_loc = "CENTER+2,CENTER+4"




