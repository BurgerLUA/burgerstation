//Human
/obj/item/organ/foot
	name = "right foot"
	id = BODY_FOOT_RIGHT
	desc = "An organ."
	icon_state = BODY_FOOT_RIGHT
	worn_layer = LAYER_MOB_FEET
	break_threshold = 15
	//health_max = 25
	inventories = list(/obj/hud/inventory/organs/right_foot)

	attach_flag = BODY_LEG_RIGHT

	enable_wounds = TRUE

	hud_id = "body_foot_right"

	can_be_targeted = TRUE

	target_bounds_x_min = 10
	target_bounds_x_max = 15

	target_bounds_y_min = 1
	target_bounds_y_max = 3

	base_miss_chance = 20

	health_base = 25

	damage_coefficient = 0.5

	has_pain = TRUE

/obj/item/organ/foot/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps

/obj/item/organ/foot/on_pain()

	. = ..()

	if(is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(!A.horizontal && A.add_status_effect(STAGGER,5,5))
			A.visible_message(span("warning","\The [A.name]'s [src.name] recoils in pain, throwing them off balance!"),span("danger","Your [src.name] recoils in pain, throwing you off balance!"))
			return TRUE

	return .

/obj/item/organ/foot/get_footsteps(var/list/original_footsteps,var/enter=TRUE)

	for(var/k in src.inventories)
		var/obj/hud/inventory/H = k
		var/obj/item/clothing/I = H.get_top_object()
		if(istype(I))
			return I.get_footsteps(original_footsteps,enter)

	return original_footsteps

/obj/item/organ/foot/left
	name = "left foot"
	id = BODY_FOOT_LEFT
	desc = "An organ."
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3

//Reptile Feral
/obj/item/organ/foot/reptile
	name = "right reptile foot"

	icon = 'icons/mob/living/advanced/species/reptile.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	flags_organ = FLAG_ORGAN_BEAST_FEET

	defense_rating = REPTILE_ARMOR

/obj/item/organ/foot/reptile/left
	name = "left reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3

//Reptile Advanced
/obj/item/organ/foot/reptile_advanced
	name = "right advanced reptile foot"

	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	defense_rating = REPTILE_ARMOR

/obj/item/organ/foot/reptile_advanced/left
	name = "left advanced reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3

//Reptile Advanced
/obj/item/organ/foot/diona
	name = "right diona foot"

	icon = 'icons/mob/living/advanced/species/diona.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	flags_organ = FLAG_ORGAN_BEAST_FEET

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR

/obj/item/organ/foot/diona/left
	name = "left diona foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	enable_glow = TRUE
	enable_detail = TRUE

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3

//cyborg
/obj/item/organ/foot/cyborg
	name = "right cyborg foot"

	icon = 'icons/mob/living/advanced/species/cyborg.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	defense_rating = CYBORG_ARMOR
	health = /health/obj/item/organ/synthetic

/obj/item/organ/foot/cyborg/left
	name = "left cyborg foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3

//Beefman
/obj/item/organ/foot/beefman
	name = "right beef foot"

	icon = 'icons/mob/living/advanced/species/beefman.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	defense_rating = MEATMEN_ARMOR

/obj/item/organ/foot/beefman/left
	name = "left beef foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3


//Skeleton
/obj/item/organ/foot/skeleton
	name = "right skeleton foot"

	icon = 'icons/mob/living/advanced/species/skeleton.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

	defense_rating = SKELETON_ARMOR

/obj/item/organ/foot/skeleton/left
	name = "left skeleton foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3


//Monkey
/obj/item/organ/foot/monkey
	name = "right skeleton foot"

	icon = 'icons/mob/living/advanced/species/monkey.dmi'

	inventories = list(/obj/hud/inventory/organs/right_foot)

/obj/item/organ/foot/monkey/left
	name = "left monkey foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/hud/inventory/organs/left_foot)

	hud_id = "body_foot_left"

	target_bounds_x_min = 17
	target_bounds_x_max = 22

	target_bounds_y_min = 1
	target_bounds_y_max = 3