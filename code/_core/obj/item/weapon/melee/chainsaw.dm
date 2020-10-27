/obj/item/weapon/melee/energy/chainsaw/
	name = "chainsaw"
	desc = "When you solve your problems with a chainsaw, you never have the same problem twice!"
	desc_extended =  "It's a chainsaw. Turn it on and watch as everything you hit with it becomes chunky soup."
	icon = 'icons/obj/item/weapons/melee/swords/chainsaw.dmi'
	damage_type = /damagetype/melee/sword/chainsaw

	can_wield = TRUE

	size = SIZE_4
	weight = 20

/obj/item/weapon/melee/energy/chainsaw/click_self(var/mob/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/energy/energy_on.ogg',src)
		damage_type = /damagetype/melee/sword/chainsaw/on
	else
		play('sound/weapons/energy/energy_off.ogg',src)
		damage_type = /damagetype/melee/sword/chainsaw
	return .

/obj/item/weapon/melee/energy/chainsaw/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)

	if(enabled && wielded)
		return TRUE

	return ..()