/obj/item/organ/groin
	name = "groin"
	id = BODY_GROIN
	desc = "An organ."
	icon_state = BODY_GROIN_MALE
	worn_layer = LAYER_MOB_GROIN
	health_max = 75
	inventories = list(
		/obj/inventory/organs/groin,
		/obj/inventory/organs/groin_u
	)

/obj/item/organ/groin/female
	desc = "A groin. Female variant"
	icon_state = BODY_GROIN_FEMALE

//Reptile
/obj/item/organ/groin/reptile
	name = "reptile groin"
	health_max = 100
	icon = 'icons/mob/living/advanced/species/reptile.dmi'

/obj/item/organ/groin/reptile/female
	icon_state = BODY_GROIN_FEMALE