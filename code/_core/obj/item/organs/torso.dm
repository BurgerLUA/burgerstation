/obj/item/organ/torso
	name = "torso"
	id = BODY_TORSO
	desc = "An organ."
	icon_state = BODY_TORSO_MALE
	worn_layer = LAYER_MOB_TORSO
	health_max = 100
	inventories = list(
		/obj/inventory/organs/torso,
		/obj/inventory/organs/torso_o,
		/obj/inventory/organs/torso_u,
		/obj/inventory/organs/torso_b
	)

/obj/item/organ/torso/female
	desc = "A torso. Female variant"
	icon_state = BODY_TORSO_FEMALE


/obj/item/organ/torso/reptile
	name = "reptile torso"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."
	health_max = 125

/obj/item/organ/torso/reptile/female
	icon_state = BODY_TORSO_FEMALE