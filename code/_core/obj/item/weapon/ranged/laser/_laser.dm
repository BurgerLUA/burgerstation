/obj/item/weapon/ranged/laser
	var/charge_max = 1000
	var/charge_current = 1000
	var/charge_cost = 100

	bullet_color = "#FF0000"

/obj/item/weapon/ranged/laser/get_ammo_count()
	return floor(charge_current/charge_cost)

/obj/item/weapon/ranged/laser/handle_ammo(caller)
	charge_current -= charge_cost
	return null

/obj/item/weapon/ranged/laser/can_gun_shoot()

	if(!..())
		return FALSE

	if(charge_current - charge_cost < 0)
		handle_empty()
		return FALSE


	return TRUE
