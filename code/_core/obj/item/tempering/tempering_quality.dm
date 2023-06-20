/obj/item/tempering/quality
	name = "quality improvement"
	desc = "You shouldn't be seeing this..."
	desc_extended = "Report this to burger."
	has_quick_function = TRUE
	var/item_type_name = "items"

/obj/item/tempering/quality/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_advanced(caller) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = caller

	return A.put_in_hands(src,params)

/obj/item/tempering/quality/can_temper(var/mob/caller,var/obj/item/I)

	if(I.quality <= -1)
		caller.to_chat(span("warning","\The [I.name] cannot be improved!"))
		return FALSE

	if(I.quality >= maximum)
		caller.to_chat(span("warning","\The [I.name] cannot be improved any further!"))
		return FALSE

	return ..()

/obj/item/tempering/quality/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Increases the quality of [item_type_name] by [increase]%, up to [maximum]%, with a minimum of [minimum]%.")

/obj/item/tempering/quality/on_temper(var/mob/caller,var/obj/item/I)
	I.quality = clamp(I.quality + increase,minimum,maximum)
	. = ..()

/obj/item/tempering/quality/general
	name = "advanced repair kit"
	desc = "Stay sharp!"
	desc_extended = "A collection of scrap, tools, and generally useful materials that can help you maintain the condition any sort of item."
	icon_state = "repair_kit"

	increase = 25
	minimum = 50
	maximum = 100

	temper_whitelist = /obj/item

	value = 400

/obj/item/tempering/quality/melee
	name = "chef's whetstone"
	desc = "Stay sharp!"
	desc_extended = "A special whetstone that can improve the quality of melee, unarmed, and thrown weapons. Even works on non-sharp objects!"
	icon_state = "whetstone"

	increase = 5
	minimum = 100
	maximum = 125

	temper_whitelist = list(/obj/item/weapon/melee,/obj/item/weapon/unarmed,/obj/item/weapon/ranged/thrown)

	value = 500

/obj/item/tempering/quality/clothing
	name = "armorer's durathread"
	desc = "Stay protected!"
	desc_extended = "A patch of rare durathread that can improve the quality of a piece of clothing."
	icon_state = "durathread"

	increase = 5
	minimum = 100
	maximum = 125

	temper_whitelist = /obj/item/clothing
	value = 750

/obj/item/tempering/quality/ranged/projectile
	name = "soldier's spare brass parts"
	desc = "Stay ahead of the curve!"
	desc_extended = "A collection of spare brass parts stolen from Clockwork Cultists that can improve the quality of ranged weapons."
	icon_state = "brass_box"

	increase = 5
	minimum = 100
	maximum = 125

	temper_whitelist = list(/obj/item/weapon/ranged/bullet,/obj/item/weapon/ranged/energy, /obj/item/weapon/ranged/reagent_ammo/,/obj/item/weapon/ranged/bow)
	value = 1000

/obj/item/tempering/quality/ranged/energy
	name = "alien focusing mechanism"
	desc = "Stay ahead of the curve!"
	desc_extended = "A rare, exotic, and expensive focusing crystal made out of diamonds and alien alloy that improves the quality of ranged energy-based weapons."
	icon_state = "focusing_crystal"

	increase = 25
	minimum = 100
	maximum = 200

	temper_whitelist = /obj/item/weapon/ranged/energy
	value = 3000

/obj/item/tempering/quality/ranged/magic
	name = "wizard's gemstone crystal"
	desc = "Stay ahead of the curve!"
	desc_extended = "A magical phoron composite crystal that improves the quality of spell gems, support gems, and wands."
	icon_state = "gem_fuel"

	increase = 5
	minimum = 100
	maximum = 125

	temper_whitelist = list(/obj/item/weapon/ranged/spellgem,/obj/item/weapon/ranged/wand,/obj/item/supportgem)
	value = 1250