/obj/item/weapon/ranged/energy/recharging
	charge_max = 4000
	charge_current = 4000
	charge_cost = 1000
	var/recharge_rate = 100

/obj/item/weapon/ranged/energy/recharging/think()

	. = ..()

	if(next_shoot_time + 1 <= world.time)
		charge_current = min(charge_current + recharge_rate,charge_max)
		update_sprite()

	return .

