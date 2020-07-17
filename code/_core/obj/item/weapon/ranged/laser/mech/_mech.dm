/obj/item/weapon/ranged/energy/mech
	name = "mech gun"

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/chronogun
	projectile_speed = 8
	shoot_delay = 20
	automatic = FALSE
	bullet_color = "#0000FF"

	charge_max = 1000000
	charge_current = 1000000
	charge_cost = 1000

	view_punch = 0

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	mech_only = TRUE

	size = SIZE_6


/obj/item/weapon/ranged/energy/mech/can_gun_shoot(var/mob/caller)
	if(!istype(loc,/mob/living/vehicle/))
		caller.to_chat(span("warning","This gun can only be fired in a vehicle!"))
		return FALSE
	return ..()