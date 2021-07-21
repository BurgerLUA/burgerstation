/obj/item/weapon/ranged/energy/temporary/revolver
	name = "Ocelot Revolver"
	desc = "Six shots."
	desc_extended = "Reloading like this is a revolution!"
	icon = 'icons/obj/item/weapons/ranged/revolver/38_2.dmi'
	icon_state = "inventory"
	rarity = RARITY_COMMON
	value = 0

	shoot_sounds = list('sound/weapons/308/big_game.ogg')

	projectile = /obj/projectile/bullet/firearm/revolver/
	ranged_damage_type = /damagetype/ranged/bullet/revolver_38

	charge_cost = 5000
	battery = /obj/item/powercell/

	shoot_delay = 1

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	bullet_color = COLOR_BULLET

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.04

/obj/item/weapon/ranged/energy/temporary/revolver/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/temporary/revolver/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))