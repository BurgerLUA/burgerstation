/obj/projectile/bullet/cleaning_shot
	name = "cleaing shot"
	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet_large"

/obj/projectile/bullet/cleaning_shot/on_projectile_hit(atom/hit_atom,turf/old_loc,turf/new_loc)

	. = ..()

	if(. && hit_atom)
		if(hit_atom.reagents && is_living(hit_atom)) //Direct injection.
			hit_atom.reagents.add_reagent(/reagent/space_cleaner,10,caller=owner)
		var/reagent/R = REAGENT(/reagent/nutrition/water)
		R.on_splash(null,owner,hit_atom,20,1)