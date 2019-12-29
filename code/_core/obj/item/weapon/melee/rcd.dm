/obj/item/weapon/melee/tool/rcd
	name = "rapid construction device"
	desc = "Rapidly construct items."
	desc_extended = "Useful for making complex structures fast. Requires a blueprint disk to be loaded."
	icon = 'icons/obj/items/weapons/melee/tools/rcd.dmi'

	var/obj/item/disk/rcd_disk

/obj/item/weapon/melee/tool/rcd/proc/insert_disk(var/mob/caller,var/obj/item/disk/desired_disk)


	var/obj/item/disk/old_disk
	if(rcd_disk)
		old_disk = eject_disk(caller)

	desired_disk.force_move(src)
	rcd_disk = desired_disk
	caller.to_chat("You insert \the [rcd_disk.name] into \the [src.name].")

	return old_disk

/obj/item/weapon/melee/tool/rcd/proc/eject_disk(var/mob/caller)
	var/obj/item/disk/old_disk
	old_disk = rcd_disk
	rcd_disk.force_move(get_turf(src))
	rcd_disk = null
	caller.to_chat("You remove \the [old_disk.name] from \the [src.name].")
	return old_disk

/obj/item/weapon/melee/tool/rcd/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(is_inventory(object) && rcd_disk)
		var/obj/hud/inventory/I = object
		var/obj/item/disk/ejected_disk = eject_disk(caller)
		I.add_object(ejected_disk)
		return TRUE

	if(istype(object,/obj/item/disk/) && is_inventory(object.loc))
		var/obj/hud/inventory/I = object.loc
		var/obj/item/disk/D = object
		D.drop_item(src.loc)
		var/obj/item/disk/existing_disk = insert_disk(caller,D)
		if(existing_disk)
			I.add_object(existing_disk)
		return TRUE

	return ..()