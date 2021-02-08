/obj/item/rcd
	name = "rapid construction device"
	desc = "Rapidly construct items."
	desc_extended = "Useful for making complex structures fast. Requires a blueprint disk to be loaded."
	icon = 'icons/obj/item/weapons/melee/tools/rcd.dmi'

	var/obj/item/disk/rcd_disk

	var/matter_current = 0
	var/matter_max = 10000

	value = 50

	weight = 5

/obj/item/rcd/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("rcd_disk")
	SAVEVAR("matter_current")
	return .

/obj/item/rcd/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("rcd_disk")
	LOADVAR("matter_current")
	update_sprite()
	return .

/obj/item/rcd/Generate()
	matter_current = matter_max
	return ..()

/obj/item/rcd/proc/add_matter(var/matter_amount)
	matter_current = min(matter_current + matter_amount,matter_max)
	update_sprite()
	return matter_current

/obj/item/rcd/proc/spend_matter(var/matter_to_spend)
	if(matter_to_spend > matter_current)
		return FALSE
	matter_current -= matter_to_spend
	update_sprite()
	return TRUE

/obj/item/rcd/update_overlays()

	. = ..()

	var/charge_level = matter_current == 0 ? 0 : FLOOR(1+(matter_current/matter_max)*9, 1)
	if(charge_level)
		var/image/I = new/image(initial(icon),"charge_[charge_level]")
		add_overlay(I)

	return .

/obj/item/rcd/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	if(!isturf(object)) object = get_turf(object)

	if(object)

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)

		var/turf/T = object
		if(!rcd_disk)
			caller.to_chat(span("warning","ERROR: There is no construction disk loaded in \the [src.name]!"))
			return TRUE
		var/list/data = rcd_disk.data
		if(!data || !data["object"] || !data["cost"] || !ispath(data["object"]))
			caller.to_chat(span("warning","ERROR: Invalid construction disk!"))
			return TRUE

		if(ispath(data["object"],/turf/) ? !T.can_construct_on(caller,/obj/structure/interactive/construction/girder/) : !T.can_construct_on(caller,data["object"]))
			return TRUE

		var/matter_cost = data["cost"]
		var/delay_time = 0

		if(matter_cost && !spend_matter(matter_cost))
			caller.to_chat(span("warning","You don't have enough matter to construct this! (You have [matter_current], [matter_cost] needed)."))
			return TRUE

		if(ispath(data["effect"]))
			var/obj/effect/temp/E = data["effect"]
			E = new E(T)
			INITIALIZE(E)
			E.alpha = 100
			E.color = "#00FF00"
			delay_time = E.duration

		spawn(delay_time)
			if(ispath(data["object"],/turf/))
				T.change_turf(data["object"])
				caller.to_chat(span("notice","You construct \a [T.name] with \the [src.name]."))
			else
				var/atom/A = data["object"]
				A = new A(T)
				INITIALIZE(A)
				FINALIZE(A)
				caller.to_chat(span("notice","You construct \a [A.name] with \the [src.name]."))

		return TRUE

	return ..()

/obj/item/rcd/proc/insert_disk(var/mob/caller,var/obj/item/disk/desired_disk,var/silent=FALSE)
	if(rcd_disk)
		if(caller && !silent) caller.to_chat(span("warning","There is already a [rcd_disk.name] installed in \the [src.name]!"))
		return null
	desired_disk.drop_item(src)
	rcd_disk = desired_disk
	if(caller && !silent) caller.visible_message(span("notice","\The [caller.name] inserts a disk into \the [src.name]."),span("notice","You insert \the [rcd_disk.name] into \the [src.name] and download the data onto the RCD."))
	return rcd_disk

/obj/item/rcd/proc/eject_disk(var/mob/caller,var/silent=FALSE)
	if(!rcd_disk)
		caller.to_chat(span("warning","There is no disk to eject from \the [src.name]!"))
		return null
	if(caller && !silent) caller.visible_message(span("notice","\The [caller.name] removes a disk from \the [src.name]."),span("notice","You remove \the [rcd_disk.name] from \the [src.name]."))
	rcd_disk.drop_item(get_turf(src))
	. = rcd_disk
	rcd_disk = null
	return .

/obj/item/rcd/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(is_inventory(object) && rcd_disk)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/hud/inventory/I = object
		var/obj/item/disk/ejected_disk = eject_disk(caller)
		I.add_object(ejected_disk)
		return TRUE

	if(istype(object,/obj/item/disk/) && is_inventory(object.loc))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/hud/inventory/I = object.loc
		var/obj/item/disk/D = object
		var/obj/item/disk/old_disk
		if(rcd_disk) old_disk = eject_disk(caller)
		if(!rcd_disk)
			insert_disk(caller,D)
			if(old_disk) I.add_object(old_disk)
		return TRUE

	return ..()