/obj/item/weapon/ranged/energy/fed/plasma_cutter
	name = "plasma cutter"
	desc = "Fed action!"
	desc_extended = "An advanced mining tool that uses phorogenic plasma bursts to penetrate up to 4 meters of rocks and other foes. Not very effective against smaller objects."
	icon = 'icons/obj/item/weapons/ranged/laser/plasma_cutter.dmi'

	company_type = "NanoTrasen"

	value = 1400 //One hell of a mining tool go cry in the corner.

	shoot_sounds = list('sound/weapons/ranged/energy/plasma_cutter/shoot.ogg')

	projectile = /obj/projectile/bullet/laser/plasma_cutter
	ranged_damage_type = /damagetype/ranged/laser/plasma_cutter

	var/charge_per_feed = 100
	var/list/fed_item = list(/obj/item/material/ingot,/obj/item/material/ore)
	var/feed_delay = 5
	shoot_delay = 12

	charge_cost = 10 //I couldn't figure out how to make the get_charge_cost() proc in _laser.dm return this value, if you wanna add a fed laser gun with a funky charge cost, you gotta fix it. For now, it always returns 10 for fed laser guns
	battery = /obj/item/powercell/dummy

	projectile_speed = TILE_SIZE*0.5

	bullet_color = null

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/energy/fed/plasma_cutter/proc/get_charge_cost_fed()
	return (charge_cost)

/obj/item/weapon/ranged/energy/fed/plasma_cutter/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(get_ammo_count() < 1)
		icon_state = "[icon_state]_empty"
	else
		icon_state = "[icon_state]"

/obj/item/weapon/ranged/energy/fed/plasma_cutter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	var/obj/item/I = object
	if((I.type in fed_item) && (battery.charge_current <= battery.charge_max))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)

		if(battery.charge_current >= battery.charge_max)
			caller.to_chat(span("warning","The battery power's already full!"))
			return
		if((battery.charge_current + charge_per_feed) > battery.charge_max)
			battery.charge_current = battery.charge_max //Since this only happens when adding the charge_per_feed would exceed the max charge, we're good
		else
			battery.charge_current += charge_per_feed
		caller.to_chat(span("notice","You've recharged \the [src.name] using the [I.name]."))
		qdel(object)

		return

	if(I.flags_tool & FLAG_TOOL_CROWBAR)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(battery)
			caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
		else
			caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))

		return TRUE

	if(!(I.type in fed_item))
		caller.to_chat(span("warning","You can't use this for refilling!"))

