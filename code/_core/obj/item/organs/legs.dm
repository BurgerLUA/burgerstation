/obj/item/organ/leg
	name = "right leg"
	id = BODY_LEG_RIGHT
	desc = "An organ."
	icon_state = BODY_LEG_RIGHT
	worn_layer = LAYER_MOB_LEGS
	break_threshold = 25
	health_max = 50

	attach_flag = BODY_GROIN

/obj/item/organ/leg/left
	name = "left leg"
	id = BODY_LEG_LEFT
	desc = "An organ."
	icon_state = BODY_LEG_LEFT

//Reptile
/obj/item/organ/leg/reptile
	name = "right reptile leg"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	break_threshold = 50
	health_max = 75
	flags_organ = FLAG_ORGAN_BEAST_FEET

/obj/item/organ/leg/reptile/left
	name = "left reptile leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT


//Reptile Advanced
/obj/item/organ/leg/reptile_advanced
	name = "right advanced reptile leg"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	break_threshold = 50
	health_max = 75

/obj/item/organ/leg/reptile_advanced/left
	name = "left advanced reptile leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT



//Diona
/obj/item/organ/leg/diona
	name = "right diona leg"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	break_threshold = 50
	health_max = 75

	enable_color = TRUE
	enable_glow = TRUE

/obj/item/organ/leg/diona/left
	name = "left diona leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT