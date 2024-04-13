/obj/item/weapon/ranged/spellgem/pillar
    name = "pillar spell gem"
    desc = "The source of all... taxes?"
    desc_extended = "Shoots an massive slow-moving pillar that penetrates everything in its path."
    icon_state = "damage"

    rarity = RARITY_LEGENDARY

    shoot_delay = 17

    bullet_count = 1
    projectile_speed = TILE_SIZE*0.3 - 1

    projectile = /obj/projectile/magic/pillar
    ranged_damage_type = /damagetype/ranged/magic/pillar

    shoot_sounds = list('sound/weapons/magic/magic.ogg')

    color = "#ebbd27"
    color_2 = "#000000"

    value = 8000

/obj/item/weapon/ranged/spellgem/pillar/get_base_value()
	. = ..() //Penetrations
	. *= 3

/obj/item/weapon/ranged/spellgem/pillar/calculate_mana_cost()
	. = ..() //Penetrations
	. *= 3
