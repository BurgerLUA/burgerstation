/obj/item/weapon/melee/energy/stunbaton
	name = "harmbaton"
	desc = "A stunbaton, except the stun setting is stuck on lethal."
	icon = 'icons/obj/items/weapons/melee/clubs/stunbaton.dmi'
	damage_type = "stunbaton_off"

	damage_type = "stunbaton_off"

	attack_delay = 5
	attack_delay_max = 10

	value = 20

/obj/item/weapon/melee/energy/stunbaton/click_self(var/atom/caller)
	. = ..()
	var/area/A = get_area(caller.loc)
	if(enabled)
		play_sound('sounds/weapons/energy/energy_on.ogg',src)
		damage_type = "stunbaton_on"
	else
		play_sound('sounds/weapons/energy/energy_off.ogg',src)
		damage_type = "stunbaton_off"

	return .