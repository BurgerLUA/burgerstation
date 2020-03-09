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
	var/area/A = get_area(caller.loc)
	if(enabled)
		play_sound('sounds/weapons/energy/energy_on.ogg',get_mobs_in_range(caller),vector(caller.x,caller.y,caller.z),environment = A.sound_environment,alert = ALERT_LEVEL_NOISE)
		damage_type = "chainsaw_on"
	else
		play_sound('sounds/weapons/energy/energy_off.ogg',get_mobs_in_range(caller),vector(caller.x,caller.y,caller.z),environment = A.sound_environment,alert = ALERT_LEVEL_NOISE)
		damage_type = "chainsaw_off"
	return .

