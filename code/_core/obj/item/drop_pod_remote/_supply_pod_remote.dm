/obj/item/supply_remote
	name = "drop pod remote"
	desc = "When you need things delivered."
	desc_extended = "A special remote designed to drop things into the battlefield."
	icon = 'icons/obj/item/supply_remote.dmi'
	icon_state = "inventory"

	var/list/atom/movable/stored_object_types = list(/obj/structure/wip/meme)
	var/obj/structure/interactive/crate/closet/supply_pod/supply_pod_type = /obj/structure/interactive/crate/closet/supply_pod
	var/charges = 1

	value = 1000

/obj/item/supply_remote/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("charges")
	return .

/obj/item/supply_remote/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("charges")
	return .

/obj/item/supply_remote/calculate_value()
	return  charges ? charges * value : 10

/obj/item/supply_remote/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(charges <= 0)
		caller.to_chat(span("warning","There are no charges left!"))
		return TRUE

	charges--

	var/turf/T = get_turf(object)

	var/obj/structure/interactive/crate/closet/supply_pod/SP = new supply_pod_type(T)
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

/obj/item/supply_remote/crates/
	value = 5000

/obj/item/supply_remote/crates/nanotrasen
	name = "drop pod remote - x4 NanoTrasen supply crates"
	stored_object_types = list(
		/obj/item/supply_crate/nanotrasen,
		/obj/item/supply_crate/nanotrasen,
		/obj/item/supply_crate/nanotrasen,
		/obj/item/supply_crate/nanotrasen
	)

/obj/item/supply_remote/crates/syndicate
	name = "drop pod remote - x4 Syndicate supply crates"
	stored_object_types = list(
		/obj/item/supply_crate/syndicate,
		/obj/item/supply_crate/syndicate,
		/obj/item/supply_crate/syndicate,
		/obj/item/supply_crate/syndicate
	)
	supply_pod_type = /obj/structure/interactive/crate/closet/supply_pod/syndicate

/obj/item/supply_remote/crates/russian
	name = "drop pod remote - x4 Russian supply crates"
	stored_object_types = list(
		/obj/item/supply_crate/russian,
		/obj/item/supply_crate/russian,
		/obj/item/supply_crate/russian,
		/obj/item/supply_crate/russian
	)

/obj/item/supply_remote/crates/american
	name = "drop pod remote - x4 American supply crates"
	stored_object_types = list(
		/obj/item/supply_crate/american,
		/obj/item/supply_crate/american,
		/obj/item/supply_crate/american,
		/obj/item/supply_crate/american
	)