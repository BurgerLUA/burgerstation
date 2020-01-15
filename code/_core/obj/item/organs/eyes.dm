//Human
/obj/item/organ/eye
	name = "right eye"
	id = BODY_EYE_RIGHT
	desc = "An eye."
	icon_state = BODY_EYE_RIGHT
	worn_layer = LAYER_MOB_EYE
	break_threshold = 5

	attach_flag = BODY_HEAD

	has_dropped_icon = TRUE
	has_dropped_icon_underlay = TRUE

	enable_wounds = TRUE

	var/vision_mod = FLAG_VISION_NONE
	var/sight_mod = SEE_SELF | SEE_BLACKNESS


/obj/item/organ/eye/initialize_blends()
	add_blend("eye", desired_color = "#00FF00", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE)

/obj/item/organ/eye/left
	name = "left eye"
	id = BODY_EYE_LEFT
	desc = "An eye."
	icon_state = BODY_EYE_LEFT

//Reptile
/obj/item/organ/eye/reptile
	name = "right reptile eye"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'


/obj/item/organ/eye/reptile/left
	name = "left reptile eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT


//Reptile Advanced
/obj/item/organ/eye/reptile_advanced
	name = "right advanced reptile eye"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'


/obj/item/organ/eye/reptile_advanced/left
	name = "left advanced reptile eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT



//Cyborg
/obj/item/organ/eye/cyborg
	name = "right cyborg optical sensor"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'


/obj/item/organ/eye/cyborg/left
	name = "left cyborg optical sensor"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT


