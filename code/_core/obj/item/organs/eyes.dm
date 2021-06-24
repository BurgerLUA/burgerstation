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
	var/sight_mod = SEE_BLACKNESS
	var/see_invisible = 0
	var/see_in_dark = 1


/obj/item/organ/eye/initialize_blends()
	add_blend("eye", desired_color = "#000000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE, desired_layer = worn_layer)

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

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic

/obj/item/organ/eye/cyborg/left
	name = "left cyborg optical sensor"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT


//Beefman
/obj/item/organ/eye/beefman
	name = "right beefman eye"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'

/obj/item/organ/eye/beefman/left
	name = "left beefman eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT


//Monkey
/obj/item/organ/eye/monkey
	name = "right monkey eye"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'

/obj/item/organ/eye/monkey/left
	name = "left monkey eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT

//goblin
/obj/item/organ/eye/goblin
	name = "right goblin eye"
	icon = 'icons/mob/living/advanced/species/goblin.dmi'

/obj/item/organ/eye/goblin/left
	name = "left goblin eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT

//Moth
/obj/item/organ/eye/moth
	name = "right moth eye"
	icon = 'icons/mob/living/advanced/species/moth.dmi'

/obj/item/organ/eye/moth/left
	name = "left moth eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT

/obj/item/organ/eye/diona
	name = "right diona eye"
	icon = 'icons/mob/living/advanced/species/diona.dmi'

/obj/item/organ/eye/diona/left
	name = "left diona eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT


//golem
/obj/item/organ/eye/golem
	name = "right golem eye"
	icon = 'icons/mob/living/advanced/species/golem.dmi'

/obj/item/organ/eye/golem/left
	name = "left golem eye"
	id = BODY_EYE_LEFT
	icon_state = BODY_EYE_LEFT