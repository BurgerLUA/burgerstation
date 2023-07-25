/obj/item/halo/kit
	name = "briefcase"
	desc = "An typical brown briefcase."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "briefcase_dark"
	value = 20

	size = SIZE_6
	weight = 4

/obj/item/halo/kit/odst/cqb
	name = "CQB-kit"
	value = 1650

/obj/item/halo/kit/odst/cqb/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/cqb,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/odst/medic
	name = "Medic-kit"
	value = 1650

/obj/item/halo/kit/odst/medic/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/medic,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/odst/soldier
	name = "Rifleman-kit"
	value = 1200

/obj/item/halo/kit/odst/soldier/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/rifleman,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/odst/sl
	name = "Squad Leader kit"
	value = 1900

/obj/item/halo/kit/odst/sl/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/sl,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/odst/engineer
	name = "Engineer-kit"
	value = 1650

/obj/item/halo/kit/odst/engineer/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/engineer,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/odst/sharp
	name = "Sharpshooter-kit"
	value = 1900

/obj/item/halo/kit/odst/sharp/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/unsc/odst/sharpshooter,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/cqb
	name = "CQB-kit"
	value = 1650
	icon_state = "briefcase"

/obj/item/halo/kit/soe/cqb/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/cqb,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/medic
	name = "Medic-kit"
	value = 1650
	icon_state = "briefcase"

/obj/item/halo/kit/soe/medic/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/medic,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/rifleman
	name = "Rifleman-kit"
	value = 1200
	icon_state = "briefcase"

/obj/item/halo/kit/soe/rifleman/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/rifleman,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/leader
	name = "Squad Leader kit"
	value = 1900
	icon_state = "briefcase"

/obj/item/halo/kit/soe/leader/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/sl,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/engineer
	name = "Engineer-kit"
	value = 1650
	icon_state = "briefcase"

/obj/item/halo/kit/soe/engineer/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/engineer,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/soe/sharp
	name = "Sharpshooter-kit"
	value = 1900
	icon_state = "briefcase"

/obj/item/halo/kit/soe/sharp/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/urf/soe/sharpshooter,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/cov/minor
	name = "Minor-kit"
	value = 1200
	icon_state = "briefcase"

/obj/item/halo/kit/cov/minor/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/covenant/elite_minor,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/cov/major
	name = "Major-kit"
	value = 1200
	icon_state = "briefcase"

/obj/item/halo/kit/cov/major/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/covenant/elite_major,TRUE)
	qdel(src)

	return TRUE

/obj/item/halo/kit/cov/ultra
	name = "Ultra-kit"
	value = 1200
	icon_state = "briefcase"

/obj/item/halo/kit/cov/ultra/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/advanced/A = caller

//	if(!length(A.worn_objects))
	A.equip_loadout(/loadout/covenant/elite_ultra,TRUE)
	qdel(src)

	return TRUE