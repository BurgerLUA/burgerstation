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

	weight = 4

/obj/item/supply_remote/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("charges")

/obj/item/supply_remote/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("charges")

/obj/item/supply_remote/get_base_value()
	. = ..()
	. *= (1 + charges)

/obj/item/supply_remote/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(charges <= 0)
		caller.to_chat(span("warning","There are no charges left in \the [src.name]!"))
		return TRUE

	var/turf/T = get_turf(object)
	var/area/A = T.loc

	if(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION)
		caller.to_chat(span("warning","Invalid landing zone!"))
		return TRUE

	charges--

	var/obj/structure/interactive/crate/closet/supply_pod/SP = new supply_pod_type(T)
	for(var/k in stored_object_types)
		var/atom/movable/M = new k(T)
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		M.force_move(SP)

	INITIALIZE(SP)
	FINALIZE(SP)

	return TRUE

/obj/item/supply_remote/drill
	name = "drop pod remote - Drill Kit"
	desc_extended = "A special remote designed to drop things into the battlefield. This one contains a large mining drill and two mining braces."
	stored_object_types = list(
		/obj/structure/interactive/mining_drill,
		/obj/structure/interactive/mining_brace,
		/obj/structure/interactive/mining_brace,
		/obj/structure/interactive/ore_box,
		/obj/item/storage/bags/mining
	)
	value = 1000

/obj/item/supply_remote/ammo
	name = "drop pod remote - Ammo Restocker"
	desc_extended = "A special remote designed to drop things into the battlefield. This one drops an ammo restocker."
	stored_object_types = list(
		/obj/structure/interactive/restocker/ammo
	)
	value = 3000
	value_burgerbux = 1


/obj/item/supply_remote/mech/
	value = 1000

/obj/item/supply_remote/mech/ripley
	name = "drop pod remote - Ripley Mining Mech with Drill + Laser Gun"
	stored_object_types = list(/mob/living/vehicle/mech/modular/premade/ripley)
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

/obj/item/supply_remote/barbecue
	name = "drop pod remote - Barbecue Kit"
	desc_extended = "A special remote designed to drop cool essential things into the battlefield. This one contains a portable barbecue."
	stored_object_types = list(
		/obj/structure/smooth/table/cooking/barbecue
	)
	value = 500
