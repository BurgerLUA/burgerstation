/obj/item/tempering/magazine
	name = "magazine improvement"
	desc = "You shouldn't be seeing this..."
	desc_extended = "Report this to burger."

/obj/item/tempering/magazine/bluespace
	name = "Magazine bluespacer"
	desc = "Have you tried just putting more bullets in it?"
	desc_extended = "A tightly controlled bluespace pocket condenser. Fits to expand inside a magazine, and increases capacity 10x for that magazine"
	icon_state = "bluespacer"

	temper_whitelist = /obj/item/magazine

	value = 50000

/obj/item/tempering/magazine/bluespace/can_temper(var/mob/caller,var/obj/item/magazine/I)
	if (!is_magazine(I))
		return FALSE

	if(I.bluespaced)
		caller.to_chat(span("warning","\The [I.name] is already bluespaced!"))
		return FALSE

	return ..()

/obj/item/tempering/magazine/bluespace/on_temper(var/mob/caller,var/obj/item/magazine/I)
	I.bluespaced = TRUE
	I.bullet_count_max *= 10
	return ..()

/obj/item/tempering/magazine/refiller
	name = "Enchantment of Endless Bullets"
	desc = "Not the fastest enhcantment ever, but it works"
	desc_extended = "Eldritch forces will ensure your magazine refills over time, in exchange for... a fat stack of credits?"
	icon_state = "mag_enchant"

	temper_whitelist = /obj/item/magazine

	value = 50000

/obj/item/tempering/magazine/refiller/can_temper(var/mob/caller,var/obj/item/magazine/I)
	if (!is_magazine(I))
		return FALSE

	if(I.regenerate)
		caller.to_chat(span("warning","\The [I.name] already has the regenerate enchantment applied!"))
		return FALSE

	return ..()

/obj/item/tempering/magazine/refiller/on_temper(var/mob/caller,var/obj/item/magazine/I)
	I.regenerate = TRUE
	I.regen()
	return ..()

