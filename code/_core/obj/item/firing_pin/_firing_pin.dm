/obj/item/firing_pin/
	name = "firing pin"
	desc = "Yes, these exist here too."
	desc_extended = "Acts as a trigger mechanism for the gun. Controls who can fire the gun, what can trigger the gun, when can the gun be fired, where the gun can be fired, why the gun can be fired, and how the gun should be fired. This also controls the IFF settings for the gun."
	var/iff_tag = null
	icon = 'icons/obj/items/firing_pins.dmi'
	icon_state = "normal"

	value = 10

/obj/item/firing_pin/proc/can_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/proc/on_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/electronic
	name = "electronic firing pin"

/obj/item/firing_pin/mechanical
	name = "mechanical firing pin"


/obj/item/firing_pin/electronic/iff/can_shoot(var/mob/caller,var/obj/item/weapon)

	if(!is_advanced(caller))
		caller.to_chat("The firing pin doesn't detect your IFF signature and refuses to fire!")
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.iff_tag)
		caller.to_chat("The firing pin doesn't detect your IFF signature and refuses to fire!")
		return FALSE

	if(A.iff_tag != iff_tag)
		caller.to_chat("The firing pin doesn't recognize your IFF signature and refuses to fire!")
		return FALSE

	return ..()

/obj/item/firing_pin/electronic/iff/nanotrasen
	name = "electronic nanotrasen firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one. Also has a safety feature to prevent accidental discharge on the NSS Eos."
	iff_tag = "NanoTrasen"
	icon_state = "nanotrasen"




/obj/item/firing_pin/electronic/iff/syndicate
	name = "syndicate firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one. Also has a safety feature to prevent accidental discharge on the NSS Eos."
	iff_tag = "Syndicate"
	icon_state = "syndicate"