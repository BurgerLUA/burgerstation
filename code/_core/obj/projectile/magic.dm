/obj/projectile/bullet/fireball
	name = "fireball"
	icon = 'icons/obj/projectiles/fire.dmi'
	icon_state = "ball"

/obj/projectile/bullet/chaos
	name = "chaos ball"
	icon = 'icons/obj/projectiles/chaos.dmi'
	icon_state = "ball"

/obj/projectile/bullet/magic_missile
	name = "magic missile"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "arrow"

/obj/projectile/bullet/rift
	name = "magic rift"
	icon = 'icons/obj/projectiles/rift.dmi'
	icon_state = "rift"

/obj/projectile/bullet/rift/post_on_hit(var/atom/hit_atom)
	new /obj/trigger/rift/forest_debug(previous_loc)

/obj/projectile/bullet/lightning_bolt
	name = "holy lightning bolt"
	icon = 'icons/obj/projectiles/holy.dmi'
	icon_state = "lightning"

/obj/projectile/bullet/holy_summon
	name = "holy summon"
	icon = 'icons/obj/projectiles/holy.dmi'
	icon_state = "summon"

	only_hit_target_turf = TRUE

	lifetime = SECONDS_TO_DECISECONDS(2)

/obj/projectile/bullet/holy_summon/post_on_hit(var/atom/hit_atom)
	var/mob/living/simple/npc/summon/holy_warrior/H = new(previous_loc,null,owner,SECONDS_TO_DECISECONDS(60))
	H.say("I RISE TO SERVER MY MASTER.")

/obj/projectile/bullet/mass_heal
	name = "mass heal"
	icon = 'icons/obj/projectiles/holy.dmi'
	icon_state = "heal"

	lifetime = SECONDS_TO_DECISECONDS(1)

/obj/projectile/bullet/mass_heal/post_on_hit(var/atom/hit_atom)
	for(var/mob/living/L in range(3,hit_atom))
		L.to_chat(span("notice","You are hit with a soothing energy..."))
		if(is_advanced(L))
			var/mob/living/advanced/A = L
			for(var/obj/item/organ/O in A.organs)
				O.adjust_brute_loss(-10)
				O.update_health()
			L.update_health()
			L.update_health_element_icons()