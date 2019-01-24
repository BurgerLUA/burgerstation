/obj/item/organ/hair
	name = "hair"
	id = BODY_HAIR_HEAD
	desc = "Yes. This is hair."
	worn_layer = LAYER_MOB_HAIR_HEAD
	break_threshold = 0
	health_max = 10 //Yes, hair has health.

	attach_flag = BODY_HEAD

//TODO COLOR
/*
/obj/item/organ/hair/update_icon()
	var/hair/H = hair_types[style]
	if(H)
		icon_state = H.icon_state

	icon = initial(icon)
	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(color_skin,ICON_MULTIPLY)


	icon = base_icon
*/

/obj/item/organ/hair/unattach_from_parent()
	del(src)