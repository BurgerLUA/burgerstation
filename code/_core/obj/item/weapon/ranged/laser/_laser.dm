/obj/item/weapon/ranged/laser
	var/charge_max = 1000
	var/charge_current = 1000
	var/charge_cost = 100

	bullet_color = "#FF0000"

	var/mech_only = FALSE

/obj/item/weapon/ranged/laser/get_ammo_count()
	return floor(charge_current/charge_cost)

/obj/item/weapon/ranged/laser/handle_ammo(var/mob/caller,var/bullet_position=1)
	charge_current -= charge_cost
	return null

/obj/item/weapon/ranged/laser/can_gun_shoot(var/mob/caller)

	if(!..())
		return FALSE

	if(charge_current - charge_cost < 0)
		handle_empty(caller)
		return FALSE


	return TRUE
