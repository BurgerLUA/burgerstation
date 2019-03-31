/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

/obj/item/weapon/melee/energy/click_self(var/atom/caller)
	enabled = !enabled
	update_icon()
	return TRUE

/obj/item/weapon/melee/energy/can_parry()
	return enabled

/obj/item/weapon/melee/energy/can_block()
	return enabled

/obj/item/weapon/melee/energy/can_attack()
	if(!enabled)
		return FALSE
	return ..()

/obj/item/weapon/melee/energy/update_icon()
	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)

	..()

/obj/item/weapon/melee/energy/sword/
	name = "energy sword"
	desc = "A blade made out of ENERGY. Please do not sue."
	icon = 'icons/obj/items/weapons/melee/laser/sword.dmi'
	damage_type = "sword_energy_off"

	block_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 1,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

/obj/item/weapon/melee/energy/sword/click_self(var/atom/caller)
	. = ..()
	var/area/A = get_area(caller.loc)
	if(enabled)
		play_sound('sounds/weapon/melee/saberon.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
		damage_type = "sword_energy_on"
	else
		play_sound('sounds/weapon/melee/saberoff.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
		damage_type = "sword_energy_off"
	return .

/obj/item/weapon/melee/energy/sword/blue
	color = "#0000FF"

/obj/item/weapon/melee/energy/sword/green
	color = "#00FF00"

/obj/item/weapon/melee/energy/sword/red
	color = "#FF0000"

/obj/item/weapon/melee/energy/sword/yellow
	color = "#FFFF00"

/obj/item/weapon/melee/energy/shield/
	name = "energy shield"
	desc = "A shield made out of ENERGY. Please do not sue."
	icon = 'icons/obj/items/weapons/melee/laser/shield.dmi'
	damage_type = /damagetype/shield/energy

	block_mul = list(
		ATTACK_TYPE_MELEE = 3,
		ATTACK_TYPE_RANGED = 3,
		ATTACK_TYPE_MAGIC = 3
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

/obj/item/weapon/melee/energy/shield/blue
	color = "#0000FF"

/obj/item/weapon/melee/energy/shield/green
	color = "#00FF00"

/obj/item/weapon/melee/energy/shield/red
	color = "#FF0000"

/obj/item/weapon/melee/energy/shield/yellow
	color = "#FFFF00"
