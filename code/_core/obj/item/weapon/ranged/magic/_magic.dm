/obj/item/weapon/ranged/magic

	var/cost_mana = 0
	var/cooldown = 60 //In deciseconds. Only used for artifacts.

	var/current_cooldown = 0

	automatic = FALSE

	use_loyalty_tag = TRUE
	firing_pin = null

/obj/item/weapon/ranged/magic/get_static_spread()
	return 0

/obj/item/weapon/ranged/magic/get_skill_spread(var/mob/living/L)
	return 0.05 - (0.1 * L.get_skill_power(SKILL_MAGIC))
