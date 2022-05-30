/obj/item/organ/torso
	name = "torso"
	id = BODY_TORSO
	desc = "An organ."
	icon_state = BODY_TORSO_MALE
	worn_layer = LAYER_MOB_TORSO
	inventories = list(
		/obj/hud/inventory/organs/torso,
		/obj/hud/inventory/organs/torso_o,
		/obj/hud/inventory/organs/torso_b,
		/obj/hud/inventory/organs/torso_ob,
		/obj/hud/inventory/organs/secure
	)

	enable_wounds = TRUE

	hud_id = "body_torso"

	can_be_targeted = TRUE

	target_bounds_x_min = 11
	target_bounds_x_max = 21

	target_bounds_y_min = 12
	target_bounds_y_max = 22

	health_base = 100

	damage_coefficient = 1

	gib_icon_state = "gibtorso"

	has_life = TRUE

/obj/item/organ/torso/unattach_from_parent(var/turf/T,var/do_delete=FALSE)
	var/atom/old_loc = src.loc
	. = ..()
	if(is_advanced(old_loc))
		var/mob/living/advanced/A = old_loc
		A.death()
		qdel(A)

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
	health = /health/obj/item/organ/synthetic

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

	projectile_dodge_chance = 30

	can_gib = FALSE


/obj/item/organ/torso/monkey
	name = "monkey torso"
	icon = 'icons/mob/living/advanced/species/monkey.dmi'
	desc = "An organ."

/obj/item/organ/torso/monkey/female
	icon_state = BODY_TORSO_FEMALE


/obj/item/organ/torso/goblin
	name = "goblin torso"
	icon = 'icons/mob/living/advanced/species/goblin.dmi'
	desc = "An organ."

	defense_rating = GOBLIN_ARMOR

/obj/item/organ/torso/goblin/female
	icon_state = BODY_TORSO_FEMALE


/obj/item/organ/torso/moth
	name = "moth torso"
	icon = 'icons/mob/living/advanced/species/moth.dmi'
	desc = "An organ."

/obj/item/organ/torso/moth/female
	icon_state = BODY_TORSO_FEMALE



/obj/item/organ/torso/golem
	name = "golem torso"
	icon = 'icons/mob/living/advanced/species/golem.dmi'
	desc = "An organ."

/obj/item/organ/torso/abductor
	name = "abductor torso"
	icon = 'icons/mob/living/advanced/species/abductor.dmi'
	desc = "An organ."