/**
  *for reference ismob(), isturf(), isarea(), isobj() and isicon() are built-in byond procs.
  *As of 513, islist() and ismovable() also became built-in byond procs.
  *That's why they are not included here.
  */

#define is_client(C) istype(C,/client)

#define is_clothing(A) istype(A,/obj/item/clothing)

#define is_item(A) istype(A,/obj/item)

#define is_atom(A) istype(A,/atom)

#define is_inventory(A) istype(A,/obj/hud/inventory)

//#define is_overlay(A) istype(A, /obj/overlay)

#define is_button(A) istype(A, /obj/hud/button)

#define is_advanced(A) istype(A, /mob/living/advanced)

#define is_tail(A) istype(A, /obj/item/organ/tail)

#define is_living(A) istype(A, /mob/living)

#define is_trigger(A)istype(A, /obj/item/device)

#define is_observer(A) istype(A, /mob/abstract/observer)

#define is_hair(A) istype(A, /obj/item/organ/hair)

#define is_melee(A) istype(A, /obj/item/weapon/melee)

#define is_ranged_gun(A) istype(A, /obj/item/weapon/ranged)

#define is_bullet_gun(A) istype(A, /obj/item/weapon/ranged/bullet)

#define is_laser_gun(A) istype(A, /obj/item/weapon/ranged/energy)

#define is_magazine_gun(A) istype(A, /obj/item/weapon/ranged/bullet/magazine)

#define is_magazine(A) istype(A, /obj/item/magazine)

#define is_bullet(A) istype(A, /obj/item/bullet_cartridge)

#if DM_VERSION < 513
#define ismovable(A) (istype(A, /atom/movable))
#endif

#define is_organ(A) istype(A, /obj/item/organ)

/*
#define is_wishgranter(A) istype(A, /obj/structure/interactive/localmachine/snowflake/wishgranter)
*/

#define is_weapon(A) istype(A, /obj/item/weapon)

#define is_scroll(A) istype(A, /obj/item/weapon/ranged/magic/scroll)

#define is_npc(A) (istype(A, /mob/living/advanced/npc) || istype(A, /mob/living/simple))

#define is_staff(A) istype(A, /obj/item/weapon/ranged/magic/staff)

/*
#define is_summon(A) istype(A, /mob/living/simple/summon)
*/

#define is_soulgem(A) istype(A, /obj/item/soulgem)

#define is_datum(A) istype(A, /datum)

#define is_wall(A) istype(A, /turf/simulated/wall)

#define is_simulated(A) istype(A, /turf/simulated)

#define is_unsimulated(A) istype(A, /turf/unsimulated)

#define is_player(A) istype(A, /mob/living/advanced/player)

#define is_floor(A) istype(A, /turf/simulated/floor)

#define is_currency(A) istype(A, /obj/item/currency)

#define is_dynamic_inventory(A) istype(A, /obj/hud/inventory/dynamic)

#define is_pocket(A) istype(A, /obj/hud/inventory/organs/groin/pocket)

#define is_slime(A) istype(A, /mob/living/simple/slime)

#define is_unique(A) istype(A, /mob/living/advanced/npc/unique)

#define is_projectile(A) istype(A, /obj/projectile)

#define is_mob_blocker(A) istype(A, /obj/marker/mob_blocker)

#define is_powercell(A) istype(A, /obj/item/powercell)

#if DM_VERSION < 513
#define islist(L) (istype(L, /list))
#endif

#define is_pump_gun(A) istype(A, /obj/item/weapon/ranged/bullet/pump)

#define is_structure(A) istype(A, /obj/structure)

#define is_container(A) istype(A, /obj/item/container)

#define is_radio(A) istype(A, /obj/item/device/radio)

#define is_wings(A) istype(A, /obj/item/clothing/back/wings)

#define is_beaker(A) istype(A, /obj/item/container/beaker)

#define is_pill(A) istype(A, /obj/item/container/pill)

#define is_food(A) istype(A, /obj/item/container/food)

#define is_hud(A) istype(A,/obj/hud/)

#define is_modular_mech(A) istype(A,/mob/living/vehicle/mech/modular)

#define is_mech_part(A) istype(A,/obj/item/mech_part)

#define is_paper(A) istype(A,/obj/item/paper)