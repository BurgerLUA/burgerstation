/obj/item/tempering/quality
	name = "quality improvement"
	desc = "You shouldn't be seeing this..."
	desc_extended = "Report this to burger."
	has_quick_function = TRUE
	var/item_type_name = "items"

	var/increase_maximum = 0

/obj/item/tempering/quality/quick(var/mob/activator,var/atom/object,location,params)

	if(!is_advanced(activator) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = activator

	return A.put_in_hands(src,params)

/obj/item/tempering/quality/can_temper(var/mob/activator,var/obj/item/I)

	if(!I.can_adjust_quality())
		activator.to_chat(span("warning","\The [I.name] cannot be improved!"))
		return FALSE

	if(increase_maximum)
		if(I.quality_max >= 200 && I.quality >= I.quality_max)
			activator.to_chat(span("warning","\The [I.name] cannot be improved further!"))
			return FALSE
	else
		if(I.quality >= I.quality_max)
			activator.to_chat(span("warning","\The [I.name] cannot be repaired further!"))
			return FALSE

	return ..()

/obj/item/tempering/quality/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Increases the quality of [item_type_name] by [increase]%, with a minimum of [minimum]%.")
	if(increase_maximum > 0)
		. += span("notice","Increases the maximum quality of [item_type_name] by [increase_maximum], up to 200%.")


/obj/item/tempering/quality/on_temper(var/mob/activator, var/obj/item/I)

	if(increase_maximum > 0)
		I.adjust_quality_max(increase_maximum)

	if((I.quality + increase) < minimum)
		I.set_quality(minimum)
	else
		I.adjust_quality(increase)

	return ..()

/obj/item/tempering/quality/general
	name = "advanced repair kit"
	desc = "Your gear is your life. Take care of it!"
	desc_extended = "A collection of scrap, tools, and generally useful materials that can help you maintain the condition any sort of item."
	icon_state = "repair_kit"

	increase = 25
	minimum = 50

	temper_whitelist = /obj/item

	value = 400

/obj/item/tempering/quality/melee
	name = "chef's whetstone"
	desc = "Stay sharp!"
	desc_extended = "A special whetstone that can improve the quality and maximium quality of melee, unarmed, and thrown weapons. Even works on non-sharp objects!"
	icon_state = "whetstone"

	increase = 5
	minimum = 100
	increase_maximum = 1

	temper_whitelist = list(/obj/item/weapon/melee, /obj/item/weapon/unarmed, /obj/item/weapon/ranged/thrown)

	value = 500

/obj/item/tempering/quality/clothing
	name = "armorer's durathread"
	desc = "Stay protected!"
	desc_extended = "A patch of rare durathread that can improve the quality and maximum quality of a piece of clothing."
	icon_state = "durathread"

	increase = 5
	minimum = 100
	increase_maximum = 1

	temper_whitelist = /obj/item/clothing
	value = 750

/obj/item/tempering/quality/ranged

/obj/item/tempering/quality/ranged/projectile
	name = "soldier's spare brass parts"
	desc = "Stay ahead of the curve!"
	desc_extended = "A collection of spare brass parts stolen from Clockwork Cultists that can improve the quality and maximum quality of ranged non-energy based weapons."
	icon_state = "brass_box"

	increase = 5
	minimum = 100
	increase_maximum = 1

	temper_whitelist = list(
		/obj/item/weapon/ranged/bullet,
		/obj/item/weapon/ranged/reagent_ammo,
		/obj/item/weapon/ranged/bow,
	)
	value = 1000

/obj/item/tempering/quality/ranged/energy
	name = "alien focusing mechanism"
	desc = "Stay ahead of the curve!"
	desc_extended = "A rare, exotic, and expensive focusing crystal made out of diamonds and alien alloy that improves the quality and maximum quality of ranged energy-based weapons."
	icon_state = "focusing_crystal"

	increase = 10
	minimum = 100
	increase_maximum = 1

	temper_whitelist = /obj/item/weapon/ranged/energy
	value = 3000

/obj/item/tempering/quality/ranged/magic
	name = "wizard's gemstone crystal"
	desc = "Stay ahead of the curve!"
	desc_extended = "A magical phoron composite crystal that improves the quality and maximum quality of spell gems, support gems, and wands."
	icon_state = "gem_fuel"

	increase = 5
	minimum = 100
	increase_maximum = 1

	temper_whitelist = list(/obj/item/weapon/ranged/spellgem, /obj/item/weapon/ranged/wand, /obj/item/supportgem)
	value = 1250
