/obj/item/weapon/ranged/energy/mech/smg/mk1
	name = "mk1 machine gun"
	icon = 'icons/obj/item/weapons/ranged/mech/mk1_smg.dmi'
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 3

	charge_max = 250*300
	charge_current = 250*300
	charge_cost = 250

	projectile = /obj/projectile/bullet/firearm/pistol
	ranged_damage_type = /damagetype/ranged/bullet/pistol_9mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	shoot_sounds = list('sound/weapons/pistol/shoot.ogg')

/obj/item/weapon/ranged/energy/mech/smg/mk2
	name = "mk2 machine gun"
	icon = 'icons/obj/item/weapons/ranged/mech/mk2_smg.dmi'
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 4

	charge_max = 500*240
	charge_current = 500*240
	charge_cost = 500

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	shoot_sounds = list('sound/weapons/pistol_medium/shoot.ogg')

/obj/item/weapon/ranged/energy/mech/smg/mk3
	name = "mk3 machine gun"
	icon = 'icons/obj/item/weapons/ranged/mech/mk3_smg.dmi'
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 5

	charge_max = 1000*120
	charge_current = 1000*120
	charge_cost = 1000

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_762mm

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	shoot_sounds = list('sound/weapons/pistol_medium/shoot.ogg')