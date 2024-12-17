/loot/random/gun/wand
	company_type = "Wizard Federation"
	base_type = /obj/item/weapon/ranged/wand
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_RARE
	value_min = 1
	value_max = 100000
	use_random_quality_amounts = TRUE
	quality_min = 75
	quality_max = 125
	quality_mod_min = 0.5

/loot/random/gun/spellgem
	company_type = "Wizard Federation"
	base_type = /obj/item/weapon/ranged/spellgem
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_RARE
	value_min = 1
	value_max = 100000
	quality_min = 75
	quality_max = 125
	quality_mod_min = 0.5


/loot/safe_spellgems //Prevents NPCs from getting utility spells, generally low-range spells, or projectile spammy spells
	loot_table = list(
		/obj/item/weapon/ranged/spellgem/blackflame = 1,
		/obj/item/weapon/ranged/spellgem/fireball = 1,
		/obj/item/weapon/ranged/spellgem/frost = 1,
		/obj/item/weapon/ranged/spellgem/inferno = 1,
		/obj/item/weapon/ranged/spellgem/lightning = 1,
		/obj/item/weapon/ranged/spellgem/magic_missile = 1,
	)
	use_value = TRUE

/loot/random/gun/spellgem/ashwalker
	company_type = "Ashwalkers"

/loot/random/support_gem
	base_type = /obj/item/supportgem
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_RARE
	value_min = 1
	value_max = 100000
	quality_min = 75
	quality_max = 125
	quality_mod_min = 0.5