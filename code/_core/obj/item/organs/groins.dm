/obj/item/organ/groin
	name = "groin"
	id = BODY_GROIN
	desc = "An organ."
	icon_state = BODY_GROIN_MALE
	worn_layer = LAYER_MOB_GROIN
	break_threshold = 50
	health_max = 75
	inventories = list(
		/obj/inventory/organs/groin,
		/obj/inventory/organs/groin_o,
	)

/obj/item/organ/groin/female
	desc = "A groin. Female variant"
	icon_state = BODY_GROIN_FEMALE

//Reptile Feral
/obj/item/organ/groin/reptile
	name = "reptile groin"
	break_threshold = 75
	health_max = 100
	icon = 'icons/mob/living/advanced/species/reptile.dmi'

/obj/item/organ/groin/reptile/female
	icon_state = BODY_GROIN_FEMALE


//Reptile Advanced
/obj/item/organ/groin/reptile_advanced
	name = "reptile groin"
	break_threshold = 75
	health_max = 100
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'

/obj/item/organ/groin/reptile_advanced/female
	icon_state = BODY_GROIN_FEMALE