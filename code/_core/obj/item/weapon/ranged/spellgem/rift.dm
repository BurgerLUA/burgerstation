/obj/item/weapon/ranged/spellgem/rift
	name = "rift spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a rift something-something that heals allies and biologically hurts enemies. Damage's unaffected by your magic skill."
	icon_state = "damage"

	cost_mana = 40
	shoot_delay = 2
	burst_delay = 12
	max_bursts = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.25 - 1

	projectile = /obj/projectile/magic/rift
	ranged_damage_type = /damagetype/ranged/bullet/syringe

	shoot_sounds = list('sound/weapons/magic/heal.ogg')

	color = "#FFD800"
	color_2 = "#917E1F"
	color_3 = "#7F0000"

	value = 1800
	value_burgerbux = 1

/obj/item/weapon/ranged/spellgem/rift/revive
	name = "revival rift spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a rift something-something that revives allies and biologically hurts enemies. Damage's unaffected by your magic skill."
	icon_state = "damage"

	cost_mana = 200
	shoot_delay = 5
	burst_delay = 15
	max_bursts = 1

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.25 - 1

	projectile = /obj/projectile/magic/rift
	ranged_damage_type = /damagetype/ranged/bullet/syringe

	shoot_sounds = list('sound/weapons/magic/heal.ogg')

	color = "#FFD800"
	color_2 = "#917E1F"
	color_3 = "#7F0000"

	value = 3600
	value_burgerbux = 1
