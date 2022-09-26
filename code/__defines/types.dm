var/global/list/all_typecaches = list()

#define istypecache(needle,haystack) (needle && length(all_typecaches[haystack]) ? (all_typecaches[haystack][needle.type] ? TRUE : FALSE) : FALSE)
#define ispathcache(needle,haystack) (needle && length(all_typecaches[haystack]) ? (all_typecaches[haystack][needle] ? TRUE : FALSE) : FALSE)

/proc/createtypecache(var/datum/type_to_generate)

	if(all_typecaches[type_to_generate])
		CRASH("Tried generating a typecache that already exists!")

	all_typecaches[type_to_generate] = list()

	for(var/k in typesof(type_to_generate))
		all_typecaches[type_to_generate][k] = TRUE





#define is_datum(A) istype(A, /datum)
#define is_atom(A) istype(A,/atom)

#define is_living(A) istypecache(A,/mob/living/)


#define is_advanced(A) istypecache(A,/mob/living/advanced/)


#define is_player(A) istypecache(A,/mob/living/advanced/player/)


#define is_observer(A) istypecache(A,/mob/abstract/observer/)

#define is_structure(A) istypecache(A,/obj/structure/)


#define is_item(A) istypecache(A,/obj/item/)

#define is_clothing(A) istypecache(A,/obj/item/clothing)


#define is_currency(A) istypecache(A,/obj/item/currency/)


#define is_organ(A) istypecache(A,/obj/item/organ/)


#define is_hud(A) istypecache(A,/obj/hud/)


#define is_inventory(A) istypecache(A,/obj/hud/inventory/)


#define is_floor(A) istypecache(A,/turf/simulated/floor/)


#define is_wall(A) istypecache(A,/turf/simulated/wall/)


#define is_simulated(A) istypecache(A, /turf/simulated/)

#define is_unsimulated(A) istypecache(A, /turf/unsimulated)
