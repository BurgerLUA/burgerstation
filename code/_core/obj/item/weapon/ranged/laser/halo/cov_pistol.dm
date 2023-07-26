/obj/item/weapon/ranged/energy/halo/cov_pistol
	name = "Type-25 Directed Energy Pistol"
	desc = "Pew pew pew!"
	desc_extended = "A dual funtionality pistol: It fires bolts of plasma, and when overcharged is capable of emitting a small emp burst at the point of impact."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_pistol.dmi'
	bullet_color = "#00FF00"

	company_type = "Covenant"

	value = 4000

	damage_mod = 1.1

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle/hardlight

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = FALSE
	dan_mode = FALSE
	shoot_sounds = list('sound/weapons/halo/covenant/haloplasmapistol.ogg')

	charge_cost = CELL_SIZE_BASIC / 80

	override_icon_state = TRUE

	heat_max = 0.05

	size = SIZE_3
	weight = 10
	can_wield = FALSE
	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

	rarity = RARITY_LEGENDARY

/obj/item/weapon/ranged/energy/halo/cov_pistol/update_overlays()
	. = ..()
	var/obj/item/powercell/PC = get_battery()
	if(!istype(PC))
		var/image/I = new/image(initial(icon),"charge0")
		add_overlay(I)
	else
		var/image/I = new/image(initial(icon),"charge[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]")
		add_overlay(I)


/obj/item/weapon/ranged/energy/halo/cov_pistol/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/halo/cov_pistol/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/halo/cov_pistol/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()

/obj/item/weapon/ranged/energy/halo/cov_pistol/insurrection
	name = "Modified Type-25 Directed Energy Pistol"
	desc = "Pew pew pew!"
	desc_extended = "A dual funtionality pistol: It fires bolts of plasma, and when overcharged is capable of emitting a small emp burst at the point of impact."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_pistol_ins.dmi'
	company_type = "United Rebel Front"
