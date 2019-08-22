/obj/item/weapon/ranged/laser/recharging
	charge_max = 4000
	charge_current = 4000
	charge_cost = 1000


/obj/item/weapon/ranged/laser/recharging/think()
	charge_current = min(charge_current + charge_cost*0.25,charge_max)
	update_icon()
	return ..()