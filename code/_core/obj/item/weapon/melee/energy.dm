/obj/item/weapon/melee/energy
	var/enabled = FALSE
	override_icon_state = TRUE
	override_icon_state_held = TRUE

	damage_type = /damagetype/melee/sword/energy
	var/damage_type_on = /damagetype/melee/sword/energy/on

/obj/item/weapon/melee/energy/can_block()
	return enabled

/obj/item/weapon/melee/energy/can_parry()
	return enabled

/obj/item/weapon/melee/energy/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(enabled) . += span("notice","It is active.")
	return .

/obj/item/weapon/melee/energy/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	enabled = !enabled
	update_sprite()
	return TRUE

/obj/item/weapon/melee/energy/update_icon()

	if(enabled)
		icon_state = "[initial(icon_state)]_on"
		if(wielded)
			icon_state_held_left = "[initial(icon_state_held_left)]_wielded_on"
			icon_state_held_right = "[initial(icon_state_held_right)]_wielded_on"
		else
			icon_state_held_left = "[initial(icon_state_held_left)]_on"
			icon_state_held_right = "[initial(icon_state_held_right)]_on"
		dan_icon_state = "[initial(dan_icon_state)]_on"
		dan_icon_state_wielded = "[initial(dan_icon_state_wielded)]_on"
		dan_icon_state_back = "[initial(dan_icon_state_back)]_on"
		damage_type = damage_type_on
	else
		icon_state = initial(icon_state)
		if(wielded)
			icon_state_held_left = "[initial(icon_state_held_left)]_wielded"
			icon_state_held_right = "[initial(icon_state_held_right)]_wielded"
		else
			icon_state_held_left = initial(icon_state_held_left)
			icon_state_held_right = initial(icon_state_held_right)
		dan_icon_state = initial(dan_icon_state)
		dan_icon_state_wielded = initial(dan_icon_state_wielded)
		dan_icon_state_back = initial(dan_icon_state_back)
		damage_type = initial(damage_type)

	update_held_icon()

	return ..()


/obj/item/weapon/melee/energy/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(is_item(object) && length(polymorphs))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT

			var/choice = input("What do you want to change the color of \the [src.name]?","Color Selection") as null|anything in polymorphs
			if(!choice)
				caller.to_chat(span("notice","You decide not to change \the [src.name]'s color."))
				return TRUE

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT

			var/choice_color = input("What would you like the new color to be?","Color Selection",color) as color|null

			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)

			if(!choice_color)
				caller.to_chat(span("notice","You decide not to change \the [src.name]'s color."))
				return TRUE

			color = choice_color
			polymorphs[choice] = polymorphs[choice]
			caller.to_chat(span("notice","You change \the [src.name]'s color."))
			update_sprite()

			return TRUE

	return ..()


/obj/item/weapon/melee/energy/sword/
	name = "energy sword"
	desc = "A blade made out of ENERGY. Please do not sue."
	desc_extended = "A lightweight energy blade that has become the standard issue melee pretty much everywhere. It's main issue is that it's not usable as a bayonet due to it's lack of weight and it's complex mechanisms."
	icon = 'icons/obj/item/weapons/melee/laser/sword.dmi'

	value = 80

	damage_type = /damagetype/melee/sword/energy
	damage_type_on = /damagetype/melee/sword/energy/on

	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FFFFFF",
		"core" = "#FFFFFF"
	)

	weight = 5
	size = SIZE_2

/obj/item/weapon/melee/energy/sword/click_self(var/mob/caller)

	. = ..()

	if(.)
		SPAM_CHECK(20)
		if(enabled)
			play_sound('sound/weapons/energy/energy_on.ogg',get_turf(src),range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/energy/energy_off.ogg',get_turf(src),range_max=VIEW_RANGE)
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

	polymorphs = list(base = "#FFFFFF")

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.25,
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0.9,
		ATTACK_TYPE_MAGIC = 0
	)

	weight = 2
	size = SIZE_2

/obj/item/weapon/melee/energy/shield/blue
	polymorphs = list(base = "#0000FF")

/obj/item/weapon/melee/energy/shield/green
	polymorphs = list(base = "#00FF00")

/obj/item/weapon/melee/energy/shield/red
	polymorphs = list(base = "#FF0000")

/obj/item/weapon/melee/energy/shield/yellow
	polymorphs = list(base = "#FFFF00")

/obj/item/weapon/melee/energy/shield/classic
	polymorphs = list(base = "#5EB9FF")

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
	name = "\improper Plightbringer's Sword"
	desc = "A large black steel straightsword with a decorated hilt."
	desc_extended = "A large decorated black steel straightsword. While black steel holds sorceries and magical infusions better than most metals, it is difficult to retain its sharpness. Because of this, Battlemages are the most common to use weapons made with the metal."
	icon = 'icons/obj/item/weapons/melee/swords/plightbringer.dmi'

	value = 1000
	rarity = RARITY_RARE

	damage_type = /damagetype/melee/sword/plightbringer
	damage_type_on = /damagetype/melee/sword/plightbringer/on

	size = SIZE_4
	weight = 25

/obj/item/weapon/melee/energy/plightbringer/click_self(var/mob/caller)

	. = ..()

	if(.)
		SPAM_CHECK(20)
		if(enabled)
			play_sound('sound/weapons/magic/ash.ogg',get_turf(src),range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/magic/ash.ogg',get_turf(src),range_max=VIEW_RANGE)

	return .