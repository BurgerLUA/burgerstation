/obj/item/weapon/ranged/spellgem/lightning
	name = "holy lightning bolt spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a fast moving holy lightning bolt that deals damage to other living targets in an area if it hits another living target."
	icon_state = "damage"
	shoot_delay = 2

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.8 - 1

	projectile = /obj/projectile/magic/lightning_bolt
	ranged_damage_type = /damagetype/ranged/magic/lightning

	color = "#FFD846"
	color_2 = "#C6FFE1"
	color_3 = "#FFFFBE"

	shoot_sounds = list('sound/weapons/magic/zap_large.ogg')
	value = 800

/obj/item/weapon/ranged/spellgem/lightning/calculate_mana_cost()
	. = ..()
	. *= 1.5 //For the AOE damage.
	. = CEILING(.,1)