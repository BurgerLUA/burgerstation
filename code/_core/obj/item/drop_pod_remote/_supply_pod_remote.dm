/obj/item/supply_remote
	name = "drop pod remote"
	desc = "When you need things delivered."
	desc_extended = "A special remote designed to drop things into the battlefield."
	icon = 'icons/obj/item/supply_remote.dmi'
	icon_state = "inventory"

	var/list/atom/movable/stored_object_types = list(/obj/structure/wip/meme)
	var/charges = 1

	value = 1000

/obj/item/supply_remote/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(charges <= 0)
		caller.to_chat(span("warning","There are no charges left!"))
		return TRUE

	charges--

	var/turf/T = get_turf(object)

	var/obj/structure/interactive/crate/closet/supply_pod/SP = new(T)
	for(var/k in stored_object_types)
		var/atom/movable/M = new k(T)
		INITIALIZE(M)
		GENERATE(M)
		SP.add_to_crate(M)

	INITIALIZE(SP)
	return TRUE

/obj/item/supply_remote/gygax
	name = "drop pod remote - Gygax Combat Mech"
	stored_object_types = list(/mob/living/vehicle/mech/gygax/equipped)
	value = 5000