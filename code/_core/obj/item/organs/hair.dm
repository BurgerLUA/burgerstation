/obj/item/organ/hair
	name = "hair"
	id = BODY_HAIR_HEAD
	desc = "Yes. This is hair."
	worn_layer = LAYER_MOB_HAIR_HEAD
	health_max = 10 //Yes, hair has health.
	icon = 'icons/mob/living/advanced/hair/hair.dmi'
	icon_state = "bald"
	var/hairstyle = "bald"

/obj/item/organ/hair/update_icon()
	var/hair/H = hair_types[hairstyle]
	if(H)
		icon_state = H.icon_state

