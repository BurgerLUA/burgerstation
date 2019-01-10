/obj/item/organ/hand
	name = "right hand"
	id = BODY_HAND_RIGHT
	desc = "A right hand."
	icon_state = BODY_HAND_RIGHT
	worn_layer = LAYER_MOB_HANDS
	inventories = list(
		/obj/inventory/organs/right_hand_worn,
		/obj/inventory/organs/right_hand_held
	)
	health_max = 25

	damage_type = /damagetype/unarmed/fists/

/obj/item/organ/hand/left
	name = "left hand"
	id = BODY_HAND_LEFT
	desc = "A left hand."
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/inventory/organs/left_hand_worn,
		/obj/inventory/organs/left_hand_held
	)

	damage_type = /damagetype/unarmed/fists/left



/obj/item/organ/hand/reptile
	name = "right reptile hand"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	inventories = list(
		/obj/inventory/organs/right_hand_worn,
		/obj/inventory/organs/right_hand_held
	)

	damage_type = /damagetype/unarmed/fists/


/obj/item/organ/hand/reptile/left
	name = "left reptile hand"
	icon_state = BODY_HAND_LEFT
	inventories = list(
		/obj/inventory/organs/left_hand_worn,
		/obj/inventory/organs/left_hand_held
	)

	damage_type = /damagetype/unarmed/fists/left