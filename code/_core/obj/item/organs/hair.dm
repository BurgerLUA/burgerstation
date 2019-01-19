/obj/item/organ/hair
	name = "hair"
	id = BODY_HAIR_HEAD
	desc = "Yes. This is hair."
	worn_layer = LAYER_MOB_HAIR_HEAD
	break_threshold = 0
	health_max = 10 //Yes, hair has health.
	icon = 'icons/mob/living/advanced/hair/hair.dmi'
	icon_state = "bald"
	var/hair_style = "bald"

	attach_flag = BODY_HEAD

/obj/item/organ/hair/update_icon()
	var/hair/H = hair_types[hair_style]
	if(H)
		icon_state = H.icon_state

/obj/item/organ/hair/unattach_from_parent()
	del(src)