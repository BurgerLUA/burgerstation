/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	var/damage_type_on
	var/damage_type_off

/obj/item/weapon/melee/energy/click_self(var/atom/caller)
	enabled = !enabled
	update_icon()
	return TRUE

/obj/item/weapon/melee/energy/can_parry()
	return enabled ? src : null

/obj/item/weapon/melee/energy/can_block()
	return enabled ? src : null

/obj/item/weapon/melee/energy/update_icon()
	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		damage_type = "[initial(damage_type)]_on"
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		damage_type = initial(damage_type)

	update_held_icon()

	..()

/obj/item/weapon/melee/energy/sword/
	name = "energy sword"
	desc = "A blade made out of ENERGY. Please do not sue."
	icon = 'icons/obj/items/weapons/melee/laser/sword.dmi'
	damage_type = "sword_energy"

	attack_delay = 4
	attack_delay_max = 8

	value = 80

/obj/item/weapon/melee/energy/sword/click_self(var/atom/caller)
	. = ..()
	var/area/A = get_area(caller.loc)
	if(enabled)
		play_sound('sounds/weapons/energy/energy_on.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment,alert = ALERT_LEVEL_CAUTION)
	else
		play_sound('sounds/weapons/energy/energy_off.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment,alert = ALERT_LEVEL_NOISE)
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
	damage_type = "shield_energy"

	value = 60

/obj/item/weapon/melee/energy/shield/blue
	color = "#0000FF"

/obj/item/weapon/melee/energy/shield/green
	color = "#00FF00"

/obj/item/weapon/melee/energy/shield/red
	color = "#FF0000"

/obj/item/weapon/melee/energy/shield/yellow
	color = "#FFFF00"

/obj/item/weapon/melee/energy/sword/katana
	name = "energy katana"
	icon = 'icons/obj/items/weapons/melee/laser/katana.dmi'
	damage_type = "energy_katana"
	color = "#FFFFFF"