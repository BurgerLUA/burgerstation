/obj/projectile/bullet/cleaning_shot
	name = "cleaing shot"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/cleaning_shot/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && is_living(hit_atom))
		var/mob/living/L = hit_atom
		if(L.reagents)
			L.reagents.add_reagent(/reagent/space_cleaner,10,caller=owner)

		if(new_loc)
			var/reagent/R = REAGENT(/reagent/nutrition/water)
			R.on_splash(null,owner,new_loc,20,1)