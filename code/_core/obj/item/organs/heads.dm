/obj/item/organ/head
	name = "head"
	id = BODY_HEAD
	desc = "So no head?"
	icon_state = BODY_HEAD_MALE
	worn_layer = LAYER_MOB_HEAD
	break_threshold = 25
	//health_max = 50
	inventories = list(
		/obj/hud/inventory/organs/head,
		/obj/hud/inventory/organs/neck,
		/obj/hud/inventory/organs/face,
		/obj/hud/inventory/organs/ear
	)

	attach_flag = BODY_TORSO

	enable_wounds = TRUE

	hud_id = "body_head"

	can_be_targeted = TRUE

	target_bounds_x_min = 12
	target_bounds_x_max = 20

	target_bounds_y_min = 23
	target_bounds_y_max = 29

	base_miss_chance = 20

	health_base = 50

	reagents = /reagent_container/limb

	damage_coefficient = 2

/obj/item/organ/head/initialize_blends()
	add_blend("blush", desired_color = "#00FF00", desired_blend = ICON_MULTIPLY, desired_icon = 'icons/mob/living/advanced/species/human.dmi', desired_icon_state = "none", desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)
	add_blend("lips", desired_color = "#00FF00", desired_blend = ICON_MULTIPLY, desired_icon = 'icons/mob/living/advanced/species/human.dmi', desired_icon_state = "none", desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)
	return ..()

/obj/item/organ/head/female
	icon_state = BODY_HEAD_FEMALE

//Reptile
/obj/item/organ/head/reptile
	name = "reptile head"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	defense_rating = REPTILE_ARMOR

/obj/item/organ/head/reptile/female
	icon_state = BODY_HEAD_FEMALE

//Reptile Advanced
/obj/item/organ/head/reptile_advanced
	name = "advanced reptile head"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	defense_rating = REPTILE_ARMOR

/obj/item/organ/head/reptile_advanced/female
	icon_state = BODY_HEAD_FEMALE


//Diona
/obj/item/organ/head/diona
	name = "diona head"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	icon_state = BODY_HEAD
	desc = "An organ."
	flags_organ = FLAG_ORGAN_BEAST_HEAD

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR


//cyborg
/obj/item/organ/head/cyborg
	name = "cyborg head"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	desc = "An organ."

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic


//beef
/obj/item/organ/head/beefman
	name = "beef head"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'
	desc = "An organ."

	defense_rating = MEATMEN_ARMOR


//skeleton
/obj/item/organ/head/skeleton
	name = "skeleton head"
	icon = 'icons/mob/living/advanced/species/skeleton.dmi'
	desc = "An organ."

	defense_rating = SKELETON_ARMOR


//skeleton
/obj/item/organ/head/monkey
	name = "monkey head"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'
	desc = "An organ."

/obj/item/organ/head/monkey/female
	icon_state = BODY_HEAD_FEMALE