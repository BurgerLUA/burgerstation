/obj/item/weapon/ranged/energy
	var/charge_max = 1000
	var/charge_current = 1000
	var/charge_cost = 100

	bullet_color = "#FF0000"

	var/mech_only = FALSE

/obj/item/weapon/ranged/energy/New(var/desired_loc)
	charge_cost = FLOOR(charge_cost, 1)
	return ..()

/obj/item/weapon/ranged/energy/Generate()
	charge_current = charge_max
	return ..()

/obj/item/weapon/ranged/energy/get_ammo_count()
	return FLOOR(charge_current/charge_cost, 1)

/obj/item/weapon/ranged/energy/handle_ammo(var/mob/caller,var/bullet_position=1)
	charge_current -= charge_cost
	return null

/obj/item/weapon/ranged/energy/can_gun_shoot(var/mob/caller)

	if(!..())
		return FALSE

	if(charge_current - charge_cost < 0)
		handle_empty(caller)
		return FALSE

	return TRUE