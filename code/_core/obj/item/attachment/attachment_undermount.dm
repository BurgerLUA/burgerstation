/obj/item/attachment/undermount
	name = "undermount attachment"

/obj/item/attachment/undermount/vertical_grip
	name = "vertical grip"
	desc = "Firmly grasp it."
	desc_extended = "A simple underbarrel vertical grip designed to reduce recoil and recoil spread, movement spread, and increase accuracy. Difficult to use while prone."
	icon_state = "vertical_grip"

	attachment_stats = list(
		movement_spread = 0.8,
		skill_spread = 1.2,
		heat_spread = 0.8,
		prone_mul = 1.5
	)

	value = 150

/obj/item/attachment/undermount/angled_grip
	name = "angled grip"
	desc = "Firmly grasp it."
	desc_extended = "A special angled grip designed to make it easier to handle the weapon at the cost of higher recoil and higher movement spread."
	icon_state = "angled_grip"

	attachment_stats = list(
		movement_spread = 1.25,
		skill_spread = 0.9,
		heat_spread = 0.8,
	)

	value = 150

/obj/item/attachment/undermount/burst_adapter
	name = "burst fire improver"
	icon_state = "burst_adapter"
	desc = "PewPewPew"
	desc_extended = "A complex underbarrel mechanism that increases the amount of bursts a burst fire weapon does. Also decreases accuracy loss due to recoil and makes the weapon easier to handle at the cost of higher movement spread."

	attachment_stats = list(
		bursts_to_use = 3,
		shoot_delay = 0.75,
		heat_spread = 0.5,
		skill_spread = 0.75,
		movement_spread = 1.75,
	)

	value = 400

/obj/item/attachment/undermount/bipod
	name = "bipod"
	desc = "Firmly mount it."
	desc_extended = "A simple bipod mount that nearly eliminates recoil and accuracy penalties when used while laying down or on a barricade. The bulkiness of the weapon causes inaccuracy while not prone and further increases movement accuracy penalties."
	icon_state = "bipod"

	attachment_stats = list(
		prone_mod = 0.5,
		movement_spread = 1.5,
		static_spread = 2
	)

	value = 250



/obj/item/attachment/undermount/gun
	name = "gun"
	var/obj/item/weapon/ranged/stored_gun

/obj/item/attachment/undermount/gun/Destroy()
	QDEL_NULL(stored_gun)
	. = ..()

/obj/item/attachment/undermount/gun/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return stored_gun?.clicked_on_by_object(caller,object,location,control,params)

/obj/item/attachment/undermount/gun/Generate()
	if(stored_gun)
		stored_gun = new stored_gun(src)
		stored_gun.anchored = TRUE
		INITIALIZE(stored_gun)
		GENERATE(stored_gun)
		FINALIZE(stored_gun)
	. = ..()

/obj/item/attachment/undermount/gun/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEATOM("stored_gun")

/obj/item/attachment/undermount/gun/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_gun")

/obj/item/attachment/undermount/gun/click_on_object_alt(var/mob/caller,var/atom/object,location,control,params)
	return stored_gun.click_on_object(caller,object,location,control,params)


/obj/item/attachment/undermount/gun/grenade_launcher
	name = "20mm undermounted grenade launcher"
	desc = "Thump!"
	desc_extended = "A compact undermounted grenade launcher capable of shooting 20mm grenades at medium ranges. The added weight to the front makes the weapon bulkier to shoot when moving."
	icon_state = "grenade_launcher"

	stored_gun = /obj/item/weapon/ranged/bullet/revolver/grenade_launcher/undermount

	attachment_stats = list(
		movement_spread = 1.75
	)

	value = 1000
