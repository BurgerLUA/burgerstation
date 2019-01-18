//Human
/obj/item/organ/foot
	name = "right foot"
	id = BODY_FOOT_RIGHT
	desc = "An organ."
	icon_state = BODY_FOOT_RIGHT
	worn_layer = LAYER_MOB_FEET
	break_threshold = 15
	health_max = 25
	inventories = list(/obj/inventory/organs/right_foot)

	damage_type = /damagetype/unarmed/feet/

/obj/item/organ/foot/left
	name = "left foot"
	id = BODY_FOOT_LEFT
	desc = "An organ."
	icon_state = BODY_FOOT_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left

//Reptile Feral
/obj/item/organ/foot/reptile
	name = "right reptile foot"
	break_threshold = 25
	health_max = 35
	icon = 'icons/mob/living/advanced/species/reptile.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

	flags_organ = FLAG_ORGAN_BEAST_FEET

/obj/item/organ/foot/reptile/left
	name = "left reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left


//Reptile Advanced
/obj/item/organ/foot/reptile_advanced
	name = "right advanced reptile foot"
	break_threshold = 25
	health_max = 35
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

/obj/item/organ/foot/reptile_advanced/left
	name = "left advanced reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left