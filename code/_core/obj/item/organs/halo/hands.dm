/obj/item/organ/hand/halo/unggoy
	name = "right hand"
	icon = 'icons/mob/living/advanced/species/halo/covenant/unggoy.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_held
	)

	damage_coefficient = 0.2
	//defense_rating = UNGGOY_ARMOR
	flags_organ = FLAG_ORGAN_COVENANT

/obj/item/organ/hand/halo/unggoy/left
	name = "left hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

/obj/item/organ/hand/halo/kigyar
	name = "right hand"
	icon = 'icons/mob/living/advanced/species/halo/covenant/kigyar.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

	flags_organ = FLAG_ORGAN_COVENANT

/obj/item/organ/hand/halo/kigyar/left
	name = "left hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

/obj/item/organ/hand/halo/elite
	name = "right hand"
	icon = 'icons/mob/living/advanced/species/halo/covenant/elite.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

	damage_type = /damagetype/unarmed/elite/
	flags_organ = FLAG_ORGAN_COVENANT

	health_base = 35

/obj/item/organ/hand/halo/elite/left
	name = "left hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

	health_base = 35

/obj/item/organ/hand/halo/spartan
	name = "right hand"
	icon = 'icons/mob/living/advanced/species/halo/spartan/spartan.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

	damage_type = /damagetype/unarmed/elite/
	flags_organ = FLAG_ORGAN_SPARTAN

	health_base = 35

/obj/item/organ/hand/halo/spartan/left
	name = "left hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

	target_bounds_x_min = 21
	target_bounds_x_max = 24

	target_bounds_y_min = 11
	target_bounds_y_max = 14

	health_base = 35