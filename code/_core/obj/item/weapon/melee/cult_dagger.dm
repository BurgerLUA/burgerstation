/obj/item/weapon/melee/sword/cult_dagger
	name = "cultist dagger"
	desc = "Now safe and reliable to use!"
	desc_extended = "An ancient cultist dagger repurposed by the wizard federation to make use of Soul Trapping. Can also be seen in the hands of cultists sometimes with a sense of poetic irony."
	icon = 'icons/obj/item/weapons/melee/swords/cult_dagger.dmi'
	icon_state = "inventory"
	dan_mode = FALSE

	value = 1

	damage_type = /damagetype/melee/sword/cult_dagger
	size = SIZE_2
	weight = 7
	rarity = RARITY_UNCOMMON

/obj/item/weapon/melee/sword/cult_dagger/Generate()
	. = ..()
	enchantment = new /enchantment/soul_trap
	enchantment.strength = 5
	enchantment.cost = initial(enchantment.cost) * enchantment.strength * 0.75
	enchantment.charge = SOUL_SIZE_UNCOMMON
	enchantment.max_charge = SOUL_SIZE_UNCOMMON
