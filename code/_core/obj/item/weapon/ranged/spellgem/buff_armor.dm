/obj/item/weapon/ranged/spellgem/buff_armor
	name = "self-armoring spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one temporarily boosts your armor."
	icon_state = "damage"
	color = "#a7007d"

	use_loyalty_tag = FALSE
	use_iff_tag = FALSE
	has_quick_function = TRUE

	utilitygem = TRUE

	utility_cost = 60
	
	value = 800
/obj/item/weapon/ranged/spellgem/buff_armor/shoot(mob/caller, atom/object, location, params, damage_multiplier = 1, click_called)
	if(istype(caller,/mob/living))
		var/damage_multiplier_to_use = 1
		. = ..()
		var/mob/living/livingcaller = caller
		livingcaller.add_status_effect(TEMP_ARMOR,damage_multiplier_to_use * 10,SECONDS_TO_DECISECONDS(damage_multiplier_to_use * 30))
		caller.visible_message(span("warning","\The [caller.name] looks tougher!"),span("warning","You feel more resistant to damage!"))
		return TRUE
	else
		CRASH("Nonliving atom [caller] is somehow using a [object], which shouldn't be possible!")