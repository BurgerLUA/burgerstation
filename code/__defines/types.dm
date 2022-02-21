//Common types used. Common types only.

#define is_datum(A) istype(A, /datum)

#define is_item(A) istype(A,/obj/item)

#define is_atom(A) istype(A,/atom)

#define is_inventory(A) istype(A,/obj/hud/inventory)

#define is_advanced(A) istype(A, /mob/living/advanced)

#define is_living(A) istype(A, /mob/living)

#define is_observer(A) istype(A, /mob/abstract/observer)

#define is_organ(A) istype(A, /obj/item/organ)

#define is_floor(A) istype(A, /turf/simulated/floor)

#define is_wall(A) istype(A, /turf/simulated/wall)

#define is_simulated(A) istype(A, /turf/simulated)

#define is_unsimulated(A) istype(A, /turf/unsimulated)

#define is_player(A) istype(A, /mob/living/advanced/player)

#define is_currency(A) istype(A, /obj/item/currency)

#define is_structure(A) istype(A, /obj/structure)

#define is_hud(A) istype(A,/obj/hud/)