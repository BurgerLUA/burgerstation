/obj/item/weapon/melee/energy/chainsaw/
	name = "chainsaw"
	desc = "A blade made out of ENERGY. Please do not sue."
	icon = 'icons/obj/items/weapons/melee/swords/chainsaw.dmi'
	damage_type = "chainsaw_off"

	attack_delay = 10
	attack_delay_max = 15

	value = 50

/obj/item/weapon/melee/energy/chainsaw/click_self(var/atom/caller)
	. = ..()
	if(enabled)
		play('sounds/weapons/energy/energy_on.ogg',src)
		damage_type = "chainsaw_on"
	else
		play('sounds/weapons/energy/energy_off.ogg',src)
		damage_type = "chainsaw_off"
	return .

