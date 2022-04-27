/obj/item/weapon/ranged/energy/abductor
	name = "abductor ray gun"
	desc = "Pew pew."
	desc_extended = "A highly advanced self-recharging laser ray gun capable of destroying both armor and flesh."
	icon = 'icons/obj/item/weapons/ranged/laser/abductor.dmi'

	value = 2000

	bullet_color = "#FF66E5"

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/abductor

	projectile_speed = TILE_SIZE*0.75 - 1
	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/raygun.ogg')

	charge_cost = CELL_SIZE_BASIC / 60

	override_icon_state = TRUE

	heat_max = 0.02

	size = SIZE_3
	weight = 12

	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

/obj/item/weapon/ranged/energy/abductor/update_overlays()
	. = ..()
	var/obj/item/powercell/PC = get_battery()
	if(!istype(PC))
		var/image/I = new/icon(initial(icon),"charge_0")
		add_overlay(I)
	else
		var/image/I = new/icon(initial(icon),"charge_[FLOOR((PC.charge_current/PC.charge_max) * 9, 1)]")
		add_overlay(I)

/obj/item/weapon/ranged/energy/abductor/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/abductor/get_skill_spread(var/mob/living/L)
	return max(0,0.05 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/abductor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

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
