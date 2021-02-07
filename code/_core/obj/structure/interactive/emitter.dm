/obj/structure/interactive/emitter
	name = "supermatter emitter"
	desc = "Pew pew!"
	desc_extended = "Sends concetrated beams of pure energy intended to power up the supermatter. Keep this on to win."

	icon = 'icons/obj/structure/emitter.dmi'
	icon_state = "emitter"

	var/active = FALSE

	var/next_fire = 0

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	bullet_block_chance = 50

	density = TRUE


/obj/structure/interactive/emitter/Finalize()
	if(active)
		start_thinking(src)
		update_sprite()
	return ..()

/obj/structure/interactive/emitter/update_icon()
	icon_state = initial(icon_state)
	if(active) icon_state = "[icon_state]_on"
	return ..()

/obj/structure/interactive/emitter/think()

	if(next_fire <= world.time)

		shoot_projectile(
			src,
			get_step(src,dir),
			null,
			null,
			/obj/projectile/bullet/laser/emitter,
			/damagetype/ranged/laser/emitter,
			16,
			16,
			0,
			TILE_SIZE*0.75,
			1,
			"#FF00DC",
			0,
			0,
			1,
			null,
			null
		)
		play_sound('sound/weapons/emitter/emitter.ogg',get_turf(src))

		next_fire = world.time + SECONDS_TO_DECISECONDS(6)
		flick("[initial(icon_state)]_fire",src)


	. = ..()

	if(!active)
		return FALSE

	if(!.)
		active = FALSE

	return .


/obj/structure/interactive/emitter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		active = !active
		caller.visible_message(span("warning","\The [caller.name] turns \the [src.name] [active ? "on" : "off"]."),span("warning","You turn \the [src.name] [active ? "on" : "off"]."))
		if(active) start_thinking(src)
		update_sprite()

	return ..()