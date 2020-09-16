/obj/item/weapon/ranged/energy/recharging/captain
	name = "\improper Captain's laser pistol"
	desc = "All craftsmanship is of the highest quality."
	desc_extended = "A fancier version of the laser rifle that self-charges. It has become innacurate due to its age."
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'
	rarity = RARITY_MYTHICAL

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/carbine

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 7

	automatic = FALSE

	shoot_sounds = list('sound/weapons/laser_carbine/kill.ogg')

	charge_cost = 1000

	override_icon_state = TRUE

	view_punch = 4

	heat_per_shot = 0.07
	heat_max = 0.2

	size = SIZE_3


	value = 2000

/obj/item/weapon/ranged/energy/recharging/captain/update_overlays()
	. = ..()
	if(!battery)
		var/image/I = new/icon(initial(icon),"charge0")
		add_overlay(I)
	else
		var/image/I = new/icon(initial(icon),"charge[FLOOR((battery.charge_current/battery.charge_max) * 4, 1)]")
		add_overlay(I)
	return .


/obj/item/weapon/ranged/energy/recharging/captain/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/energy/recharging/captain/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.6 * L.get_skill_power(SKILL_RANGED)))
