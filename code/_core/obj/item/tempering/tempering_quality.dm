/obj/item/tempering/quality
	name = "quality improvement"
	desc = "You shouldn't be seeing this..."
	desc_extended = "Report this to burger."

/obj/item/tempering/quality/can_temper(var/mob/caller,var/obj/item/I)

	if(I.quality >= limit)
		caller.to_chat(span("warning","\The [I.name] cannot be improved any further!"))
		return FALSE

	return ..()

/obj/item/tempering/quality/on_temper(var/mob/caller,var/obj/item/I)

	if(I.quality + increase > limit)
		I.quality = limit
	else if(I.quality + increase < minimum)
		I.quality = minimum
	else
		I.quality += increase

	return ..()

/obj/item/tempering/quality/melee
	name = "warrior's whetstone"
	desc = "Stay sharp!"
	desc_extended = "A special whetstone that improves the quality of a melee weapon by 5%, up to 125%. If the improvement results in a quality value less than 100%, it will set the quality to 100%.  Even works on non-sharp objects, somehow."
	icon_state = "quality_melee"

	temper_whitelist = /obj/item/weapon/melee

	value = 500

/obj/item/tempering/quality/clothing
	name = "durathread"
	desc = "Stay classy!"
	desc_extended = "A large patch of durathread that improves the quality of clothing by 5%, up to 125%. If the improvement results in a quality value less than 100%, it will set the quality to 100%."
	icon_state = "quality_clothing"

	temper_whitelist = /obj/item/clothing

	value = 500

/obj/item/tempering/quality/ranged
	name = "brass tinker's box"
	desc = "Stay on top of things."
	desc_extended = "A special kit of special screws, platings, and mechanical parts that improves the quality of guns by 5%, up to 125%. If the improvement results in a quality value less than 100%, it will set the quality to 100%."
	icon_state = "quality_ranged"

	temper_whitelist = /obj/item/weapon/ranged/bullet

	value = 500

/obj/item/tempering/quality/magic
	name = "magician's gem"
	desc = "Stay on top of things."
	desc_extended = "A fragile, yet magical gem that improves the quality of magicical tomes or staves by 5%, up to 125%. If the improvement results in a quality value less than 100%, it will set the quality to 100%."
	icon_state = "quality_magic"

	temper_whitelist = /obj/item/weapon/ranged/magic

	value = 500

/obj/item/tempering/quality/energy
	name = "focusing crystal"
	desc = "Stay on top of things."
	desc_extended = "A rare focusing crystal that can improve the quality of energy weapons by 5%, up to 125%. If the improvement results in a quality value less than 100%, it will set the quality to 100%."
	icon_state = "quality_energy"

	temper_whitelist = /obj/item/weapon/ranged/energy

	value = 500