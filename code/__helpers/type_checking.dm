/proc/is_clothing(var/atom/A)
	return istype(A,/obj/item/clothing)

/proc/is_item(var/atom/A)
	return istype(A,/obj/item/)

/proc/is_inventory(var/atom/A)
	return istype(A,/obj/inventory/)

/proc/is_overlay(var/atom/A)
	return istype(A,/obj/overlay/)

/proc/is_mob(var/atom/A)
	return istype(A,/mob/)

/proc/is_obj(var/atom/A)
	return istype(A,/obj/)

/proc/is_turf(var/atom/A)
	return istype(A,/turf/)

/proc/is_button(var/atom/A)
	return istype(A,/obj/button/)

/proc/is_advanced(var/atom/A)
	return istype(A,/mob/living/advanced/)

/proc/is_tail(var/atom/A)
	return istype(A,/obj/item/organ/tail/)

/proc/is_living(var/atom/A)
	return istype(A,/mob/living/)

/proc/is_trigger(var/atom/A)
	return istype(A,/obj/trigger/)

/proc/is_observer(var/atom/A)
	return istype(A,/mob/abstract/observer/)

/proc/is_hair(var/atom/A)
	return istype(A,/obj/item/organ/hair/)

proc/is_bullet_gun(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/bullet/)

/proc/is_magazine(var/atom/A)
	return istype(A,/obj/item/magazine/)

/proc/is_bullet(var/atom/A)
	return istype(A,/obj/item/bullet/)

proc/is_movable(var/atom/A)
	return istype(A,/atom/movable/)