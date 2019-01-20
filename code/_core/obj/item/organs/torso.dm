/obj/item/organ/torso
	name = "torso"
	id = BODY_TORSO
	desc = "An organ."
	icon_state = BODY_TORSO_MALE
	worn_layer = LAYER_MOB_TORSO
	break_threshold = 50
	health_max = 100
	inventories = list(
		/obj/inventory/organs/torso,
		/obj/inventory/organs/torso_o,
		/obj/inventory/organs/torso_b
	)

/obj/item/organ/torso/unattach_from_parent(var/turf/T)

	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.death()
	..()

/obj/item/organ/torso/female
	desc = "A torso. Female variant"
	icon_state = BODY_TORSO_FEMALE

//Reptile
/obj/item/organ/torso/reptile
	name = "reptile torso"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."
	break_threshold = 75
	health_max = 125

/obj/item/organ/torso/reptile/female
	icon_state = BODY_TORSO_FEMALE


//Reptile Advanced
/obj/item/organ/torso/reptile_advanced
	name = "advanced reptile torso"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	desc = "An organ."
	break_threshold = 75
	health_max = 125

/obj/item/organ/torso/reptile_advanced/female
	icon_state = BODY_TORSO_FEMALE


/obj/item/organ/torso/diona
	name = "diona torso"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	icon_state = BODY_TORSO
	desc = "An organ."
	break_threshold = 75
	health_max = 125

	enable_color = TRUE
	enable_glow = TRUE