/obj/item/organ/torso
	name = "torso"
	id = BODY_TORSO
	desc = "An organ."
	icon_state = BODY_TORSO_MALE
	worn_layer = LAYER_MOB_TORSO
	break_threshold = 50
	//health_max = 100
	inventories = list(
		/obj/hud/inventory/organs/torso,
		/obj/hud/inventory/organs/torso_o,
		/obj/hud/inventory/organs/torso_b,
		/obj/hud/inventory/organs/torso_ob
	)

	enable_wounds = TRUE

	hud_id = "body_torso"

	can_be_targeted = TRUE

	target_bounds_x_min = 11
	target_bounds_x_max = 21

	target_bounds_y_min = 12
	target_bounds_y_max = 22

	health_base = 100

	health_coefficient = 1

/obj/item/organ/torso/unattach_from_parent(var/turf/T)
	. = ..()
	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.death()
	return .

/obj/item/organ/torso/female
	desc = "A torso. Female variant"
	icon_state = BODY_TORSO_FEMALE

/obj/item/organ/torso/stand
	name = "stand torso"
	icon = 'icons/mob/living/advanced/species/stand.dmi'
	desc = "An organ."

/obj/item/organ/torso/stand/female
	icon_state = BODY_TORSO_FEMALE

//Reptile
/obj/item/organ/torso/reptile
	name = "reptile torso"
	icon = 'icons/mob/living/advanced/species/reptile.dmi'
	desc = "An organ."

	defense_rating = REPTILE_ARMOR

/obj/item/organ/torso/reptile/female
	icon_state = BODY_TORSO_FEMALE


//Reptile Advanced
/obj/item/organ/torso/reptile_advanced
	name = "advanced reptile torso"
	icon = 'icons/mob/living/advanced/species/reptile_advanced.dmi'
	desc = "An organ."

	defense_rating = REPTILE_ARMOR

/obj/item/organ/torso/reptile_advanced/female
	icon_state = BODY_TORSO_FEMALE

/obj/item/organ/torso/diona
	name = "diona torso"
	icon = 'icons/mob/living/advanced/species/diona.dmi'
	icon_state = BODY_TORSO
	desc = "An organ."

	enable_glow = TRUE
	enable_detail = TRUE

	defense_rating = DIONA_ARMOR


//Cyborg
/obj/item/organ/torso/cyborg
	name = "advanced cyborg torso"
	icon = 'icons/mob/living/advanced/species/cyborg.dmi'
	desc = "An organ."

	defense_rating = CYBORG_ARMOR

/obj/item/organ/torso/beefman
	name = "beefman torso"
	icon = 'icons/mob/living/advanced/species/beefman.dmi'
	desc = "An organ."

	defense_rating = MEATMEN_ARMOR


/obj/item/organ/torso/skeleton
	name = "skeleton torso"
	icon = 'icons/mob/living/advanced/species/skeleton.dmi'
	desc = "An organ."

	defense_rating = SKELETON_ARMOR