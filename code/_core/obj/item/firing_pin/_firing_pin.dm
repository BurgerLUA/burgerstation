/obj/item/firing_pin/
	name = "firing pin"
	desc = "Yes, these exist here too."
	desc_extended = "Acts as a trigger mechanism for the gun. Controls who can fire the gun, what can trigger the gun, when can the gun be fired, where the gun can be fired, why the gun can be fired, and how the gun should be fired. This also controls the IFF settings for the gun."
	var/iff_tag = null

/obj/item/firing_pin/proc/can_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/proc/on_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/electronic
	name = "electronic firing pin"

/obj/item/firing_pin/mechanical
	name = "mechanical firing pin"

/obj/item/firing_pin/electronic/nanotrasen
	name = "electronic nanotrasen firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one. Also has a safety feature to prevent accidental discharge on the NSS Eos."
	iff_tag = "NanoTrasen"

/obj/item/firing_pin/electronic/nanotrasen/can_shoot(var/mob/caller,var/obj/item/weapon)

	if(!is_advanced(caller))
		caller.to_chat("The firing pin doesn't detect your IFF signature and refuses to fire!")
		return FALSE

	var/mob/living/advanced/A = caller
	var/obj/item/organ/internal/implant/hand/left/iff/SI = locate() in A.organs

	if(!SI)
		caller.to_chat("The firing pin doesn't detect your IFF signature and refuses to fire!")
		return FALSE

	if(SI.iff_tag != iff_tag)
		caller.to_chat("The firing pin doesn't recognize your IFF signature and refuses to fire!")
		return FALSE

	return ..()