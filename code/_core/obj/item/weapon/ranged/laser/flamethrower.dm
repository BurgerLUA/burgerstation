/obj/item/weapon/ranged/energy/flamethrower //I sure hope this doesn't break anything. If it does, well... uhhhhhhhhh
	name = "flamethrower"
	desc = "W + M1"
	desc_extended = "Bioweapons are fun, but they leave one hell of a mess. Why not make the cleanup fun too?"
	icon = 'icons/obj/item/weapons/ranged/flamethrower.dmi'
	rarity = RARITY_UNCOMMON
	value = 0 //This is, after all, part of the Flamethrower Pack
	value_burgerbux = 1

	shoot_sounds = list('sound/weapons/magic/fractal.ogg') //sounds more fire-y

	projectile = /obj/projectile/bullet/flamer
	ranged_damage_type = /damagetype/ranged/laser/flamethrower

	shoot_delay = 2
	charge_cost = CELL_SIZE_BASIC / 400

	projectile_speed = TILE_SIZE*0.3

	bullet_color = null

	automatic = TRUE

	can_wield = TRUE
	wield_only = TRUE //sorting is hell

	battery = /obj/item/powercell/recharging //I'm sorry!


/obj/item/weapon/ranged/energy/flamethrower/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

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
