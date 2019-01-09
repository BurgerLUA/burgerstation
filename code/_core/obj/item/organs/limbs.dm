/obj/item/organ/torso
	name = "torso"
	id = "torso"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "torso_m"
	worn_layer = LAYER_MOB_TORSO
	health_max = 100
	inventories = list(
		/obj/inventory/organs/torso,
		/obj/inventory/organs/torso_o,
		/obj/inventory/organs/torso_u,
		/obj/inventory/organs/torso_b
	)

/obj/item/organ/groin
	name = "groin"
	id = "groin"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "groin_m"
	worn_layer = LAYER_MOB_GROIN
	health_max = 75
	inventories = list(
		/obj/inventory/organs/groin,
		/obj/inventory/organs/groin_u
	)

/obj/item/organ/head
	name = "head"
	id = "head"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "head_m"
	worn_layer = LAYER_MOB_HEAD
	health_max = 50
	inventories = list(/obj/inventory/organs/head)

/obj/item/organ/right_arm
	name = "right arm"
	id = "r_arm"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "r_arm"
	worn_layer = LAYER_MOB_ARMS
	health_max = 50

/obj/item/organ/right_hand
	name = "right hand"
	id = "r_hand"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "r_hand"
	worn_layer = LAYER_MOB_HANDS
	inventories = list(
		/obj/inventory/organs/right_hand_worn,
		/obj/inventory/organs/right_hand_held
	)
	health_max = 25

	damage_type = /damagetype/unarmed/fists/

/obj/item/organ/right_leg
	name = "right leg"
	id = "r_leg"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "r_leg"
	worn_layer = LAYER_MOB_LEGS
	health_max = 50

/obj/item/organ/right_foot
	name = "right foot"
	id = "r_foot"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "r_foot"
	worn_layer = LAYER_MOB_FEET
	health_max = 25
	inventories = list(/obj/inventory/organs/right_foot)

	damage_type = /damagetype/unarmed/feet/

/obj/item/organ/left_arm
	name = "left arm"
	id = "l_arm"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "l_arm"
	worn_layer = LAYER_MOB_ARMS
	health_max = 50

/obj/item/organ/left_hand
	name = "left hand"
	id = "l_hand"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "l_hand"
	worn_layer = LAYER_MOB_HANDS
	inventories = list(
		/obj/inventory/organs/left_hand_worn,
		/obj/inventory/organs/left_hand_held
	)
	health_max = 25

	damage_type = /damagetype/unarmed/fists/left

/obj/item/organ/left_leg
	name = "left leg"
	id = "l_leg"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "l_leg"
	worn_layer = LAYER_MOB_LEGS
	health_max = 50

/obj/item/organ/left_foot
	name = "left foot"
	id = "l_foot"
	desc = "An organ."
	icon = 'icons/mob/living/advanced/human.dmi'
	icon_state = "l_foot"
	worn_layer = LAYER_MOB_FEET
	health_max = 25
	inventories = list(/obj/inventory/organs/left_foot)

	damage_type = /damagetype/unarmed/feet/left

