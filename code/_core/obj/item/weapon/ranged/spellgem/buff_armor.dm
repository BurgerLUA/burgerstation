/obj/item/weapon/ranged/spellgem/buff_armor
	name = "self-armoring spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one temporarily boosts your armor.
	icon_state = "damage"
	color = "#a7007d"

	utilitygem = TRUE
	cost_mana = 50

/obj/item/weapon/ranged/spellgem/buff_armor/shoot(mob/caller, atom/object, location, params, damage_multiplier, click_called)
	if(!istype(caller,mob/living))
		CRASH("Nonliving atom [caller] is somehow using a [object], which shouln't be possible!")
	var/livingmob = caller as mob/living
	livingmob.add_status_effect(TMEP_ARMOR,SECONDS_TO_DECISECONDS(damage_multiplier * 10),SECONDS_TO_DECISECONDS(damage_multiplier * 30))