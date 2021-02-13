/obj/item/weapon/ranged/magic/spellblade/
	name = "spellblade"
	var/active = FALSE
	var/damagetype/damage_type_on

	override_icon_state = TRUE
	override_icon_state_held = TRUE

/obj/item/weapon/ranged/magic/spellblade/update_icon() //Stolen from energy sword code.

	if(active)
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

	update_held_icon()

	return ..()


/obj/item/weapon/ranged/magic/spellblade/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	active = !active

	if(active)
		caller.to_chat(span("notice","You activate \the [src.name]."))
	else
		caller.to_chat(span("notice","You deactivate \the [src.name]."))

	update_sprite()

	return TRUE

/obj/item/weapon/ranged/magic/spellblade/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)

	if(get_dist(caller,object) <= 1)
		return FALSE

	if(!active)
		return FALSE

	. = ..()

	if(.)
		caller.attack_next = max(caller.attack_next,world.time + shoot_delay)

	return .

/obj/item/weapon/ranged/magic/spellblade/can_gun_shoot(var/mob/caller,var/atom/object,location,params)
	if(caller.attack_next > world.time)
		return FALSE
	if(!active)
		return FALSE
	return ..()


/obj/item/weapon/ranged/magic/spellblade/runesword
	name = "rune sword"
	desc = "This sword was made for those who are too lazy to walk up to people to stab them."
	desc_extended = "A force-blade that was forged by Dwarven runesmiths, in a time long forgotten. It is capable of firing a potent long-range beam."
	icon = 'icons/obj/item/weapons/ranged/magic/runesword.dmi'
	icon_state = "inventory"

	value = 1500
	rarity = RARITY_RARE

	projectile = /obj/projectile/magic/blade
	damage_type = /damagetype/melee/sword/claymore
	damage_type_on = /damagetype/melee/sword/spellblade
	ranged_damage_type = /damagetype/ranged/magic/spellblade

	size = SIZE_4
	weight = 20

	shoot_delay = SECONDS_TO_DECISECONDS(3)

	shoot_sounds = list('sound/weapons/freeze.ogg')

	value = 4000


