/obj/item/weapon/ranged/laser
	var/charge_max = 1000
	var/charge_current = 1000
	var/charge_cost = 100

/obj/item/weapon/ranged/laser/get_ammo_count()
	return floor(charge_current/charge_cost)