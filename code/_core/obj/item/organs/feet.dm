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

	damage_type = "human_foot_right"

	attach_flag = BODY_LEG_RIGHT

	enable_wounds = TRUE

/obj/item/organ/foot/left
	name = "left foot"
	id = BODY_FOOT_LEFT
	desc = "An organ."
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = "human_foot_left"

//Reptile Feral
/obj/item/organ/foot/reptile
	name = "right reptile foot"

	icon = 'icons/mob/living/advanced/species/reptile.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

	flags_organ = FLAG_ORGAN_BEAST_FEET

/obj/item/organ/foot/reptile/left
	name = "left reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left

//Reptile Advanced
/obj/item/organ/foot/reptile_advanced
	name = "right advanced reptile foot"

	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

/obj/item/organ/foot/reptile_advanced/left
	name = "left advanced reptile foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left

//Reptile Advanced
/obj/item/organ/foot/diona
	name = "right diona foot"

	icon = 'icons/mob/living/advanced/species/diona.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

	flags_organ = FLAG_ORGAN_BEAST_FEET

	enable_glow = TRUE
	enable_detail = TRUE

/obj/item/organ/foot/diona/left
	name = "left diona foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left

	enable_glow = TRUE
	enable_detail = TRUE

//cyborg
/obj/item/organ/foot/cyborg
	name = "right cyborg foot"

	icon = 'icons/mob/living/advanced/species/cyborg.dmi'

	inventories = list(/obj/inventory/organs/right_foot)
	damage_type = /damagetype/unarmed/feet/

/obj/item/organ/foot/cyborg/left
	name = "left cyborg foot"
	id = BODY_FOOT_LEFT
	icon_state = BODY_FOOT_LEFT

	attach_flag = BODY_LEG_LEFT

	inventories = list(/obj/inventory/organs/left_foot)
	damage_type = /damagetype/unarmed/feet/left