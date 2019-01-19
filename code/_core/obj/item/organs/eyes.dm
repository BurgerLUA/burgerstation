//Human
/obj/item/organ/eye
	name = "right eye"
	id = BODY_EYE_RIGHT
	desc = "An eye."
	icon_state = BODY_EYE_RIGHT
	worn_layer = LAYER_MOB_EYE
	break_threshold = 5
	health_max = 10

	attach_flag = BODY_HEAD

	has_dropped_icon = TRUE
	has_dropped_icon_underlay = TRUE

/obj/item/organ/eye/left
	name = "left eye"
	id = BODY_EYE_LEFT
	desc = "An eye."
	icon_state = BODY_EYE_LEFT

//Reptile
/obj/item/organ/eye/reptile
	name = "right reptile eye"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	break_threshold = 5
	health_max = 15

/obj/item/organ/eye/reptile/left
	name = "left reptile eye"
	id = BODY_EYE_RIGHT
	icon_state = BODY_EYE_LEFT


//Reptile Advanced
/obj/item/organ/eye/reptile_advanced
	name = "right advanced reptile eye"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	break_threshold = 5
	health_max = 15

/obj/item/organ/eye/reptile_advanced/left
	name = "left advanced reptile eye"
	id = BODY_EYE_RIGHT
	icon_state = BODY_EYE_LEFT

