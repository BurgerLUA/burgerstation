/obj/projectile/spray
	name = "spray"
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	icon = 'icons/obj/projectiles/spray.dmi'
	icon_state = "placeholder"
	reagents = /reagent_container/spray/bottle

	hit_target_turf = TRUE
	hit_laying = TRUE

	plane = PLANE_PROJECTILE_NO_EFFECTS

	hostile = FALSE

/obj/projectile/spray/update_sprite()
	. = ..()
	if(reagents)
		color = reagents.color
		hostile = reagents.contains_lethal


/obj/projectile/spray/on_enter_tile(var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && new_loc && reagents)
		reagents.splash(owner,new_loc,2.5,TRUE,0.25)
		if(reagents.volume_current <= 0 && !qdeleting)
			on_projectile_hit(new_loc)
			return FALSE

/obj/projectile/spray/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && hit_atom && reagents.volume_current > 0)
		reagents.splash(owner,hit_atom,reagents.volume_current,TRUE,0.5)

/obj/projectile/spray/update_projectile(var/tick_rate=1)
	. = ..()
	if(.)
		vel_x *= 0.9
		vel_y *= 0.9
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE



/obj/projectile/extinguisher_spray
	name = "spray"
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	icon = 'icons/obj/projectiles/spray.dmi'
	icon_state = "spray"
	reagents = /reagent_container/spray/bottle

	plane = PLANE_PROJECTILE_NO_EFFECTS

	hit_target_turf = TRUE
	hit_laying = TRUE

/obj/projectile/extinguisher_spray/on_enter_tile(var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && new_loc && reagents)
		reagents.splash(owner,new_loc,1,TRUE,0.25)
		if(reagents.volume_current <= 0 && !qdeleting)
			on_projectile_hit(new_loc)
			return FALSE

/obj/projectile/extinguisher_spray/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && hit_atom && reagents.volume_current)
		reagents.splash(owner,hit_atom,reagents.volume_current,TRUE,0.5)


/obj/projectile/extinguisher_spray/update_projectile(var/tick_rate=1)
	. = ..()
	if(.)
		vel_x *= 0.95
		vel_y *= 0.95
		alpha = clamp(reagents.volume_current*20,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE
