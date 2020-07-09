/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	damage_type = /damagetype/melee/sword/energy
	var/damage_type_on = /damagetype/melee/sword/energy/on

	block_difficulty = list( //Also affects parry. High values means more difficult to block. Generally 0 = level 0, 1 = level 100.
		ATTACK_TYPE_MELEE = 0,
		ATTACK_TYPE_RANGED = 0.5,
		ATTACK_TYPE_MAGIC = 0.5,
		ATTACK_TYPE_UNARMED = 0
	)

	value = 50

/obj/item/weapon/melee/energy/click_self(var/atom/caller)
	enabled = !enabled
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/can_parry()
	return enabled ? ..() : null

/obj/item/weapon/melee/energy/can_block()
	return enabled ? ..() : null

/obj/item/weapon/melee/energy/update_icon()

	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		damage_type = damage_type_on
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		damage_type = initial(damage_type)

	update_held_icon()

	return ..()

/obj/item/weapon/melee/energy/sword/
	name = "energy sword"
	desc = "A blade made out of ENERGY. Please do not sue."
	desc_extended = "A lightweight energy blade that has become the standard issue melee pretty much everywhere. It's main issue is that it's not usable as a bayonet due to it's lack of weight and it's complex mechanisms."
	icon = 'icons/obj/item/weapons/melee/laser/sword.dmi'

	attack_delay = 4
	attack_delay_max = 8

	value = 80

	damage_type = /damagetype/melee/sword/energy
	damage_type_on = /damagetype/melee/sword/energy/on

/obj/item/weapon/melee/energy/sword/click_self(var/atom/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/energy/energy_on.ogg',src)
	else
		play('sound/weapons/energy/energy_off.ogg',src)
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
	icon = 'icons/obj/item/weapons/melee/laser/shield.dmi'

	damage_type = /damagetype/melee/club/shield/energy
	damage_type_on = /damagetype/melee/club/shield/energy/on

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
	name = "high frequency blade"
	icon = 'icons/obj/item/weapons/melee/laser/katana.dmi'
	color = "#FFFFFF"

	damage_type = /damagetype/melee/sword/energy_katana
	damage_type_on = /damagetype/melee/sword/energy_katana/on

	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#A5FF7F",
		"blade" = "#4CFF00"
	)

/obj/item/weapon/melee/energy/sword/katana/black
	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#000000",
		"blade" = "#FFFFFF"
	)