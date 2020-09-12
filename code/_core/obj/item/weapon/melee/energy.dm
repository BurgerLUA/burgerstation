/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	damage_type = /damagetype/melee/sword/energy
	var/damage_type_on = /damagetype/melee/sword/energy/on

	value = 50

/obj/item/weapon/melee/energy/can_block()
	return enabled

/obj/item/weapon/melee/energy/can_parry()
	return enabled

/obj/item/weapon/melee/energy/get_examine_details_list(var/mob/examiner)

	. = ..()

	if(enabled)
		. += span("notice","It is active.")
		. += span("notice","Icon state: [icon_state].")


	return .

/obj/item/weapon/melee/energy/click_self(var/mob/caller)
	enabled = !enabled
	update_sprite()
	update_held_icon()
	return TRUE
/*
/obj/item/weapon/melee/energy/can_parry()
	return enabled ? ..() : null

/obj/item/weapon/melee/energy/can_block()
	return enabled ? ..() : null
*/

/obj/item/weapon/melee/energy/update_icon()

	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		icon_state_held_left = "[initial(icon_state_held_left)]_on"
		icon_state_held_right = "[initial(icon_state_held_right)]_on"
		dan_icon_state = "[initial(dan_icon_state)]_on"
		dan_icon_state_wielded = "[initial(dan_icon_state_wielded)]_on"
		dan_icon_state_back = "[initial(dan_icon_state_back)]_on"
		damage_type = damage_type_on
	else
		icon_state = initial(icon_state)
		icon_state_held_left = initial(icon_state_held_left)
		icon_state_held_right = initial(icon_state_held_right)
		dan_icon_state = initial(dan_icon_state)
		dan_icon_state_wielded = initial(dan_icon_state_wielded)
		dan_icon_state_back = initial(dan_icon_state_back)
		damage_type = initial(damage_type)

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

	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FFFFFF",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/click_self(var/mob/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/energy/energy_on.ogg',src)
	else
		play('sound/weapons/energy/energy_off.ogg',src)
	return .

/obj/item/weapon/melee/energy/sword/blue
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#0000FF",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/green
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#00FF00",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/red
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FF0000",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/yellow
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FFFF00",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/shield/
	name = "energy shield"
	desc = "A shield made out of ENERGY. Please do not sue."
	icon = 'icons/obj/item/weapons/melee/laser/shield.dmi'

	damage_type = /damagetype/melee/club/shield/energy
	damage_type_on = /damagetype/melee/club/shield/energy/on

	value = 400

	dan_mode = TRUE

	block_defense_rating = list(
		BLADE = 75,
		BLUNT = 25,
		PIERCE = 50,
		LASER = 100,
		ARCANE = 100
	)

/obj/item/weapon/melee/energy/shield/blue
	color = "#0000FF"

/obj/item/weapon/melee/energy/shield/green
	color = "#00FF00"

/obj/item/weapon/melee/energy/shield/red
	color = "#FF0000"

/obj/item/weapon/melee/energy/shield/yellow
	color = "#FFFF00"

/obj/item/weapon/melee/energy/shield/classic
	color = "#5EB9FF"

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



/obj/item/weapon/melee/energy/plightbringer
	name = "\improper Plightbringer"
	desc = "A large black steel straightsword with a decorated hilt."
	desc_extended = "A large decorated black steel straightsword. While black steel holds sorceries and magical infusions better than most metals, it is difficult to retain its sharpness. Because of this, Battlemages are the most common to use weapons made with the metal."
	icon = 'icons/obj/item/weapons/melee/swords/plightbringer.dmi'

	attack_delay = 4
	attack_delay_max = 10

	value = 1000
	rarity = RARITY_RARE

	damage_type = /damagetype/melee/sword/plightbringer
	damage_type_on = /damagetype/melee/sword/plightbringer/on

/obj/item/weapon/melee/energy/plightbringer/click_self(var/mob/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/magic/ash.ogg',src)
	else
		play('sound/weapons/magic/ash.ogg',src)
	return .