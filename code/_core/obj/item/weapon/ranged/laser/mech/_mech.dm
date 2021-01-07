/obj/item/weapon/ranged/energy/mech
	name = "mech gun"
	desc = "A gun, but bigger."
	desc_extended = "A weapon for your mech."
	icon = 'icons/obj/item/weapons/ranged/mech.dmi'

	projectile = /obj/projectile/bullet/laser
	projectile_speed = 8
	shoot_delay = 20
	automatic = FALSE
	bullet_color = "#0000FF"

	charge_cost = 1000

	view_punch = 0

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	mech_only = TRUE

	size = SIZE_6
	weight = 50

/obj/item/weapon/ranged/energy/mech/can_owner_shoot(var/mob/caller,var/atom/object,location,params)

	if(!istype(src.loc,/mob/living/vehicle/))
		caller?.to_chat(span("warning","This weapon can only be fired in a vehicle!"))
		return FALSE

	return ..()

/obj/item/weapon/ranged/energy/mech/get_battery()

	if(istype(loc,/obj/item/mech_part))
		var/obj/item/mech_part/MP = loc
		if(istype(MP.loc,/mob/living/vehicle/mech/modular))
			var/mob/living/vehicle/mech/modular/MM = MP.loc
			return MM.battery

	return ..()

/obj/item/weapon/ranged/energy/mech/smg
	name = "9x19mm SMG"
	desc = "Bullet hose."
	desc_extended = "An SMG-caliber mech weapon that manufactures bullets using battery power. Pretend you have infinite ammo and spray, until the power runs out. Also mounts in the shoulder slot."
	icon_state = "mech_ballistic"

	automatic = TRUE

	shoot_delay = 1.5

	charge_cost = CELL_SIZE_VEHICLE / 600

	projectile = /obj/projectile/bullet/firearm/pistol
	ranged_damage_type = /damagetype/ranged/bullet/pistol_9mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

	bullet_color = COLOR_BULLET

	heat_per_shot = 0.01
	heat_max = 0.03

	value = 500

/obj/item/weapon/ranged/energy/mech/smg/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/energy/mech/smg/get_skill_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/energy/mech/lmg
	name = "5.56mm LMG"
	desc = "Not a real autocannon."
	desc_extended = "Mounted machineguns are classic, and now you have one for your mech, too. Moderate energy use and fire rate with good damage make this a solid choice for any situation."
	icon_state = "mech_uac2"

	automatic = TRUE

	shoot_delay = 2

	charge_cost = CELL_SIZE_VEHICLE / 500

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

	value = 1000

	bullet_color = COLOR_BULLET

	heat_per_shot = 0.005
	heat_max = 0.04

/obj/item/weapon/ranged/energy/mech/lmg/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/energy/mech/lmg/get_skill_spread(var/mob/living/L)
	return 0


/obj/item/weapon/ranged/energy/mech/laser
	name = "AER14 Laser Rifle"
	desc = "Pew pew pew!"
	desc_extended = "Modular NT laser rifle fitted for mechs. Uses the standard beam, and runs on mech battery power. Better performance than bullets against certain targets, with a slower fire rate."
	icon_state = "mech_lasercarbine"

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 4

	automatic = TRUE

	charge_cost = CELL_SIZE_VEHICLE / 600

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	size = SIZE_4

	value = 1400

	bullet_color = "#FF0000"

	heat_per_shot = 0.004
	heat_max = 0.03

/obj/item/weapon/ranged/energy/mech/laser/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/mech/laser/get_skill_spread(var/mob/living/L)
	return 0




/obj/item/weapon/ranged/energy/mech/ion
	name = "AER35 Ion Rifle"
	desc = "THERE CAN ONLY BE ONE (MECH)!"
	desc_extended = "Modular NT laser rifle fitted for mechs. Fires a heavy ion beam for mech-to-mech combat, at a large energy cost."
	icon_state = "mech_ionrifle"

	projectile = /obj/projectile/bullet/laser/ion
	ranged_damage_type = /damagetype/ranged/laser/ion

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 4

	automatic = FALSE

	charge_cost = CELL_SIZE_VEHICLE / 200

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	size = SIZE_4

	value = 1400

	bullet_color = COLOR_BLUE

	heat_per_shot = 0.004
	heat_max = 0.03

/obj/item/weapon/ranged/energy/mech/ion/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/mech/ion/get_skill_spread(var/mob/living/L)
	return 0



/obj/item/weapon/ranged/energy/mech/missile_pod
	name = "RK Missile Pod"
	desc = "Collateral damage in 3..."
	desc_extended = "Shoulder-mounted mech HE rocket pod with a wide blast radius. Uses large amounts of power to restock its rockets. Fired by holding the ALT key. Mount one on each shoulder for double the fun!"
	icon_state = "mech_missile_pod"

	projectile = /obj/projectile/bullet/rocket
	ranged_damage_type = /damagetype/ranged/bullet/gyrojet/

	bullet_color = "#FFFFFF"

	projectile_speed = 16
	shoot_delay = 10

	automatic = FALSE

	charge_cost = CELL_SIZE_VEHICLE / 100

	shoot_sounds = list('sound/weapons/gyrojet/shoot.ogg')

	size = SIZE_4

	value = 1900

	heat_per_shot = 0.004
	heat_max = 0.03

/obj/item/weapon/ranged/energy/mech/missile_pod/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/energy/mech/missile_pod/get_skill_spread(var/mob/living/L)
	return 0