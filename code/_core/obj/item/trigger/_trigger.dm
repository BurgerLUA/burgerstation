/obj/item/device
	name = "trigger assembly"
	icon = 'icons/obj/items/trigger.dmi'

	var/interactable = FALSE

/obj/item/device/proc/on_active()
	return TRUE

/obj/item/device/proc/on_inactive()
	return TRUE

/mob/living/advanced/player/proc/set_device_active(var/obj/item/device/D)

	if(D == active_device)
		return FALSE

	if(active_device)
		set_device_unactive()

	active_device = D

	active_device.on_active(src)

/mob/living/advanced/player/proc/set_device_unactive()

	if(active_device)
		active_device.on_inactive(src)

	active_device = FALSE

	return TRUE
