/obj/item/weapon/ranged/energy/pump/kinetic_accelerator
	name = "kinetic accelerator"
	desc = "Pump action!"
	desc_extended = "An advanced mining tool that uses magnetic kinetic force to pulverize rocks and other foes. Not very effective against smaller objects."
	icon = 'icons/obj/item/weapons/ranged/laser/kinetic_accelerator.dmi'

	company_type = "NanoTrasen"

	value = 800

	shoot_sounds = list('sound/weapons/ranged/energy/kinetic/shoot.ogg')
	pump_sound = 'sound/weapons/ranged/energy/kinetic/reload.ogg'

	projectile = /obj/projectile/bullet/laser/kinetic
	ranged_damage_type = /damagetype/ranged/laser/kinetic

	pump_delay = 5
	shoot_delay = 8

	projectile_speed = TILE_SIZE*0.75

	bullet_color = "#FFFFFF"

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/energy/pump/kinetic_accelerator/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(get_ammo_count() < 1)
		icon_state = "[icon_state]_empty"
