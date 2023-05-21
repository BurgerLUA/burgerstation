/obj/item/weapon/ranged/spellgem/buff_armor
	name = "self-reinforcing spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one temporarily boosts your armor."
	icon_state = "protection"
	color = "#a7007d"

	use_loyalty_tag = FALSE
	use_iff_tag = FALSE
	has_quick_function = TRUE

	utilitygem = TRUE

	mana_cost_override = 60

	value = 800
/obj/item/weapon/ranged/spellgem/buff_armor/shoot(mob/caller, atom/object, location, params, damage_multiplier = 1, click_called)
	if(istype(caller,/mob/living))
		..()
		var/quality_bonus = get_quality_bonus(0.5,2)
		var/damage_multiplier_to_use = damage_multiplier * damage_mod
		damage_multiplier_to_use *= quality_bonus
		if(length(attachment_stats))
			MUL(damage_multiplier_to_use,attachment_stats["damage_multiplier"])
		var/mob/living/livingcaller = caller
		if(livingcaller.status_effects[TEMP_ARMOR])
			livingcaller.visible_message(span("warning","\The [livingcaller.name] looks dissapointedly at \the [src]."),span("warning","The Spell Fizzles!"))
		else
			livingcaller.add_status_effect(TEMP_ARMOR,damage_multiplier_to_use * 10,SECONDS_TO_DECISECONDS(damage_multiplier_to_use * 30))
		return TRUE
	else
		CRASH("Nonliving atom [caller] is somehow using a [object], which shouldn't be possible!")