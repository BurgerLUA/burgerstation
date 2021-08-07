/obj/item/weapon/ranged/energy/fed/plasma_cutter
	name = "plasma cutter"
	desc = "Fed action!"
	desc_extended = "An advanced mining tool that uses phorogenic plasma bursts to penetrate up to 4 meters of rocks and other foes. Not very effective against smaller objects."
	icon = 'icons/obj/item/weapons/ranged/laser/plasma_cutter.dmi'
	rarity = RARITY_RARE
	value = 1400 //One hell of a mining tool go cry in the corner.

	shoot_sounds = list('sound/weapons/cutter/fire.ogg')

	projectile = /obj/projectile/bullet/laser/plasma_cutter
	ranged_damage_type = /damagetype/ranged/laser/plasma_cutter

	charge_per_feed = 100
	fed_item = list(/obj/item/material/ingot,/obj/item/ore)
	feed_delay = 5
	shoot_delay = 12

	projectile_speed = TILE_SIZE*0.5

	bullet_color = null

/obj/item/weapon/ranged/energy/fed/plasma_cutter/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(get_ammo_count() < 1)
		icon_state = "[icon_state]_empty"
	else
		icon_state = "[icon_state]"
