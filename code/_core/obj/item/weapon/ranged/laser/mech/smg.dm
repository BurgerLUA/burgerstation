
/obj/item/weapon/ranged/energy/mech/smg/
	bullet_color = COLOR_BULLET

	heat_per_shot = 0.01
	heat_max = 0.03

/obj/item/weapon/ranged/energy/mech/smg/get_static_spread() //Base spread
	return 0.005

/obj/item/weapon/ranged/energy/mech/smg/get_skill_spread(var/mob/living/L) //Base spread
	return 0

/obj/item/weapon/ranged/energy/mech/smg/mk1
	name = "9x19mm SMG"
	icon = 'icons/obj/item/weapons/ranged/mech/mk1_smg.dmi'

	automatic = TRUE

	shoot_delay = 1.5

	charge_max = 250*300
	charge_current = 250*300
	charge_cost = 250

	projectile = /obj/projectile/bullet/firearm/pistol
	ranged_damage_type = /damagetype/ranged/bullet/pistol_9mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

/obj/item/weapon/ranged/energy/mech/smg/mk2
	name = "5.56mm LMG"
	icon = 'icons/obj/item/weapons/ranged/mech/mk2_smg.dmi'

	automatic = TRUE

	shoot_delay = 2

	charge_max = 500*240
	charge_current = 500*240
	charge_cost = 500

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

/obj/item/weapon/ranged/energy/mech/smg/mk3
	name = "7.62mm HMG"
	icon = 'icons/obj/item/weapons/ranged/mech/mk3_smg.dmi'

	automatic = TRUE

	shoot_delay = 3

	charge_max = 1000*120
	charge_current = 1000*120
	charge_cost = 1000

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_762mm

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	shoot_sounds = list('sound/weapons/308/shoot_alt.ogg')