/obj/item/weapon/ranged/energy/abductor
	name = "alien ray gun"
	desc = "Pew pew."
	desc_extended = "A highly advanced self-recharging laser ray gun that fires non-lethal lasers. Capable of destroying both your neurons and stamina."
	icon = 'icons/obj/item/weapons/ranged/laser/abductor_new.dmi'

	company_type = "Abductor"

	value = 2000

	bullet_color = "#FF66E5"

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/abductor

	projectile_speed = TILE_SIZE*0.75 - 1
	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/energy/alien/shoot.ogg')

	charge_cost = CELL_SIZE_BASIC / 60

	override_icon_state = TRUE

	heat_max = 0.02

	size = SIZE_3
	weight = 12

	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

	rarity = RARITY_RARE

	charge_icon_state_count = 5

/obj/item/weapon/ranged/energy/abductor/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/abductor/get_skill_spread(var/mob/living/L)
	return max(0,0.05 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/abductor/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				activator.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				activator.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()
