/obj/item/organ/hand
	name = "right hand"
	id = BODY_HAND_RIGHT
	desc = "A right hand."
	icon_state = BODY_HAND_RIGHT
	worn_layer = LAYER_MOB_HANDS
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)
	break_threshold = 15
	health_max = 25

	damage_type = "fist_human"

	attach_flag = BODY_ARM_RIGHT

	enable_wounds = TRUE

	hud_id = "body_hand_right"

/obj/item/organ/hand/left
	name = "left hand"
	id = BODY_HAND_LEFT
	desc = "A left hand."
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

//Reptile Advanced
/obj/item/organ/hand/reptile
	name = "right reptile hand"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)


/obj/item/organ/hand/reptile/left
	name = "left reptile hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"

//Reptile Advanced
/obj/item/organ/hand/reptile_advanced
	name = "right advanced reptile hand"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

/obj/item/organ/hand/reptile_advanced/left
	name = "left advanced reptile hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"


//Diona
/obj/item/organ/hand/diona
	name = "right diona hand"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

	enable_glow = TRUE
	enable_detail = TRUE


/obj/item/organ/hand/diona/left
	name = "left diona hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"


//Cyborg
/obj/item/organ/hand/cyborg
	name = "right cyborg hand"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	inventories = list(
		/obj/hud/inventory/organs/right_hand_worn,
		/obj/hud/inventory/organs/right_hand_held
	)

/obj/item/organ/hand/cyborg/left
	name = "left cyborg hand"
	id = BODY_HAND_LEFT
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/hud/inventory/organs/left_hand_worn,
		/obj/hud/inventory/organs/left_hand_held
	)

	attach_flag = BODY_ARM_LEFT

	hud_id = "body_hand_left"