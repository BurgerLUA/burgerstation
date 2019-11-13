/proc/is_client(var/client/C)
	return istype(C,/client/)

/proc/is_clothing(var/atom/A)
	return istype(A,/obj/item/clothing)

/proc/is_item(var/atom/A)
	return istype(A,/obj/item/)

/proc/is_atom(var/atom/A)
	return istype(A,/atom/)

/proc/is_inventory(var/atom/A)
	return istype(A,/obj/hud/inventory/)

/proc/is_overlay(var/atom/A)
	return istype(A,/obj/overlay/)

/proc/is_mob(var/atom/A)
	return istype(A,/mob/)

/proc/is_obj(var/atom/A)
	return istype(A,/obj/)

/proc/is_turf(var/atom/A)
	return istype(A,/turf/)

/proc/is_button(var/atom/A)
	return istype(A,/obj/hud/button/)

/proc/is_advanced(var/atom/A)
	return istype(A,/mob/living/advanced/)

/proc/is_tail(var/atom/A)
	return istype(A,/obj/item/organ/tail/)

/proc/is_living(var/atom/A)
	return istype(A,/mob/living/)

/proc/is_trigger(var/atom/A)
	return istype(A,/obj/item/trigger/)

/proc/is_observer(var/atom/A)
	return istype(A,/mob/abstract/observer/)

/proc/is_hair(var/atom/A)
	return istype(A,/obj/item/organ/hair/)

/proc/is_melee(var/atom/A)
	return istype(A,/obj/item/weapon/melee/)

/proc/is_ranged_gun(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/)

/proc/is_bullet_gun(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/bullet/)

/proc/is_laser_gun(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/laser/)

/proc/is_magazine_gun(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/bullet/magazine/)

/proc/is_magazine(var/atom/A)
	return istype(A,/obj/item/magazine/)

/proc/is_bullet(var/atom/A)
	return istype(A,/obj/item/bullet/)

/proc/is_movable(var/atom/A)
	return istype(A,/atom/movable/)

/proc/is_organ(var/atom/A)
	return istype(A,/obj/item/organ)

/proc/is_wishgranter(var/atom/A)
	return istype(A,/obj/structure/interactive/localmachine/snowflake/wishgranter/)

proc/is_weapon(var/atom/A)
	return istype(A,/obj/item/weapon/)

proc/is_scroll(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/magic/scroll/)

proc/is_npc(var/atom/A)
	return istype(A,/mob/living/advanced/npc/) || istype(A,/mob/living/simple/npc/)

proc/is_staff(var/atom/A)
	return istype(A,/obj/item/weapon/ranged/magic/staff/)

proc/is_summon(var/atom/A)
	return istype(A,/mob/living/simple/npc/summon/)

proc/is_soulgem(var/atom/A)
	return istype(A,/obj/item/soulgem/)

proc/is_datum(var/atom/A)
	return istype(A,/datum/)

proc/is_wall(var/atom/A)
	return istype(A,/turf/simulated/wall/)

proc/is_simulated(var/atom/A)
	return istype(A,/turf/simulated/)

proc/is_unsimulated(var/atom/A)
	return istype(A,/turf/unsimulated/)

proc/is_player(var/atom/A)
	return istype(A,/mob/living/advanced/player/)

proc/is_floor(var/atom/A)
	return istype(A,/turf/simulated/floor/)

proc/is_currency(var/atom/A)
	return istype(A,/obj/item/currency/)

proc/is_dynamic_inventory(var/atom/A)
	return istype(A,/obj/hud/inventory/dynamic/)

/proc/is_slime(var/atom/A)
	return istype(A,/mob/living/simple/npc/slime/)

/proc/is_turret(var/atom/A)
	return istype(A,/mob/living/simple/npc/turret/)

/proc/is_unique(var/atom/A)
	return istype(A,/mob/living/advanced/npc/unique/)

/proc/is_projectile(var/atom/A)
	return istype(A,/obj/projectile/)

/proc/is_mob_blocker(var/atom/A)
	return istype(A,/obj/marker/mob_blocker/)

proc/is_powercell(var/atom/A)
	return istype(A,/obj/item/powercell/)

proc/is_list(var/atom/A)
	return istype(A, /list)

proc/is_pump_gun(var/atom/A)
	return istype(A, /obj/item/weapon/ranged/bullet/pump/)

proc/is_structure(var/atom/A)
	return istype(A, /obj/structure/)

proc/is_container(var/atom/A)
	return istype(A, /obj/item/container/)

proc/is_radio(var/atom/A)
	return istype(A, /obj/item/radio/)

proc/is_wings(var/atom/A)
	return istype(A, /obj/item/clothing/back/wings/)

proc/is_beaker(var/atom/A)
	return istype(A, /obj/item/container/beaker/)

proc/is_pill(var/atom/A)
	return istype(A, /obj/item/container/pill)

proc/is_food(var/atom/A)
	return istype(A, /obj/item/container/food)
