/obj/item/weapon/melee/energy/chainsaw/
	name = "chainsaw"
	desc = "A blade made out of ENERGY. Please do not sue."
	icon = 'icons/obj/items/weapons/melee/swords/chainsaw.dmi'
	damage_type = /damagetype/melee/sword/chainsaw

	attack_delay = 10
	attack_delay_max = 15

	s

/obj/item/weapon/melee/energy/chainsaw/click_self(var/atom/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/energy/energy_on.ogg',src)
		damage_type = /damagetype/melee/sword/chainsaw/on
	else
		play('sound/weapons/energy/energy_off.ogg',src)
		damage_type = /damagetype/melee/sword/chainsaw
	return .

