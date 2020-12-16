/obj/item/firing_pin/
	name = "firing pin"
	desc = "Yes, these exist here too."
	desc_extended = "Acts as a trigger mechanism for the gun. Controls who can fire the gun, what can trigger the gun, when can the gun be fired, where the gun can be fired, why the gun can be fired, and how the gun should be fired. This also controls the IFF settings for the gun."
	var/iff_tag = null
	icon = 'icons/obj/item/firing_pins.dmi'
	icon_state = "normal"

	value = 100

	weight = 0.25

/obj/item/firing_pin/proc/can_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/proc/on_shoot(var/mob/caller,var/obj/item/weapon)
	return TRUE

/obj/item/firing_pin/electronic
	name = "electronic firing pin"

/obj/item/firing_pin/mechanical //YOU SHOULDN'T HAVE THIS.
	name = "mechanical firing pin"
	desc = "Oh god oh fuck."
	desc_extended = "A completely mechanical firing pin that has no digital IFF technology and thus can be shot by anyone and aimed at anybody. These are extremely rare and extremely illegal. Having one may result in contract termination."
	rarity = RARITY_LEGENDARY
	value = 50000

/obj/item/firing_pin/electronic/iff/can_shoot(var/mob/caller,var/obj/item/weapon)

	if(!is_living(caller))
		caller.to_chat(span("danger","The firing pin doesn't detect your IFF signature and refuses to fire!"))
		return FALSE

	var/mob/living/advanced/A = caller

	if(!A.iff_tag)
		caller.to_chat(span("danger","The firing pin doesn't detect your IFF signature and refuses to fire!"))
		return FALSE

	if(A.iff_tag != iff_tag)
		caller.to_chat(span("danger","The firing pin doesn't recognize your IFF signature and refuses to fire!"))
		return FALSE

	return ..()

/obj/item/firing_pin/electronic/iff/nanotrasen
	name = "electronic nanotrasen firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered NanoTrasen IFF implant, and prevents firing at those with one."
	iff_tag = "NanoTrasen"
	icon_state = "nanotrasen"

/obj/item/firing_pin/electronic/iff/nanotrasen/can_shoot(var/mob/caller,var/obj/item/weapon)

	. = ..()

	if(!.)
		return .

	var/area/A = get_area(caller)
	if(A.flags_area & FLAGS_AREA_TUTORIAL)
		caller.to_chat(span("danger","\The [src.name] refuses to fire in this area!"))
		return FALSE

	return TRUE

/obj/item/firing_pin/electronic/iff/syndicate
	name = "syndicate firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Syndicate IFF implant, and prevents firing at those with one."
	iff_tag = "Syndicate"
	icon_state = "syndicate"


/obj/item/firing_pin/electronic/iff/bone
	name = "bone firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Bone IFF implant, and prevents firing at those with one."
	iff_tag = "Skeleton"
	icon_state = "bone"


/obj/item/firing_pin/electronic/iff/revolutionary
	name = "revolutionary firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Revolutionary IFF implant, and prevents firing at those with one."
	iff_tag = "Revolutionary"
	icon_state = "revolution"


/obj/item/firing_pin/electronic/iff/deathsquad
	name = "deathsquad firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Deathsquad IFF implant, and prevents firing at those with one."
	iff_tag = "Deathsquad"
	icon_state = "deathsquad"

/obj/item/firing_pin/electronic/iff/space_cop
	name = "space police firing pin"
	desc_extended = "Acts as a trigger mechanism for the gun. The gun can only be fired by those with a registered Space Cop IFF implant, and prevents firing at those with one."
	iff_tag = "Space Cop"
	icon_state = "deathsquad"