/obj/item/organ/leg
	name = "right leg"
	id = BODY_LEG_RIGHT
	desc = "An organ."
	icon_state = BODY_LEG_RIGHT
	worn_layer = LAYER_MOB_LEGS
	break_threshold = 25
	//health_max = 50

	attach_flag = BODY_GROIN

	enable_wounds = TRUE

	hud_id = "body_leg_right"

	can_be_targeted = TRUE

	target_bounds_x_min = 12
	target_bounds_x_max = 15

	target_bounds_y_min = 4
	target_bounds_y_max = 8

	base_miss_chance = 10

	health_base = 70

	damage_coefficient = 0.75

	has_pain = TRUE

/obj/item/organ/leg/left
	name = "left leg"
	id = BODY_LEG_LEFT
	desc = "An organ."
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8

//Reptile
/obj/item/organ/leg/reptile
	name = "right reptile leg"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'

	flags_organ = FLAG_ORGAN_BEAST_FEET

	defense_rating = REPTILE_ARMOR

/obj/item/organ/leg/reptile/left
	name = "left reptile leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8


//Reptile Advanced
/obj/item/organ/leg/reptile_advanced
	name = "right advanced reptile leg"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

	defense_rating = REPTILE_ARMOR


/obj/item/organ/leg/reptile_advanced/left
	name = "left advanced reptile leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8



//Diona
/obj/item/organ/leg/diona
	name = "right diona leg"
	icon = 'icons/mob/living/advanced/species/diona.dmi'

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR

/obj/item/organ/leg/diona/left
	name = "left diona leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8


//Cyborg
/obj/item/organ/leg/cyborg
	name = "right cyborg leg"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic


/obj/item/organ/leg/cyborg/left
	name = "left cyborg leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8


/obj/item/organ/leg/beefman
	name = "right beef leg"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'

	defense_rating = MEATMEN_ARMOR

/obj/item/organ/leg/beefman/left
	name = "left beef leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8


//Cyborg
/obj/item/organ/leg/skeleton
	name = "right skeleton leg"
	icon = 'icons/mob/living/advanced/species/skeleton.dmi'

	defense_rating = SKELETON_ARMOR


/obj/item/organ/leg/skeleton/left
	name = "left skeleton leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8


//Cyborg
/obj/item/organ/leg/monkey
	name = "right monkey leg"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'


/obj/item/organ/leg/monkey/left
	name = "left monkey leg"
	id = BODY_LEG_LEFT
	icon_state = BODY_LEG_LEFT

	hud_id = "body_leg_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 20

	target_bounds_y_min = 4
	target_bounds_y_max = 8