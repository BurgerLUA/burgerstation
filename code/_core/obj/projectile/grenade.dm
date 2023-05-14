/obj/projectile/bullet/grenade
	icon = 'icons/obj/projectiles/explosive.dmi'
	hit_target_turf = TRUE



/obj/projectile/bullet/grenade/he
	icon_state = "HE"

/obj/projectile/bullet/grenade/he/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,4,owner,weapon,iff_tag,multiplier = 1.5)

/obj/projectile/bullet/grenade/hv
	icon_state = "HV"

/obj/projectile/bullet/grenade/hv/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,2,owner,weapon,iff_tag)

/obj/projectile/bullet/grenade/du
	icon_state = "DU"

/obj/projectile/bullet/grenade/du/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,6,owner,weapon,iff_tag,multiplier = 1.5)

/obj/projectile/bullet/grenade/incendiary
	icon_state = "INCEN"

/obj/projectile/bullet/grenade/incendiary/on_projectile_hit(atom/hit_atom, turf/old_loc, turf/new_loc)
	. = ..()
	if(. && old_loc)
		firebomb(old_loc,25,owner,weapon,iff_tag,multiplier = 0.8)


/obj/projectile/bullet/grenade/cleaning
	icon_state = "CLEANING"

/obj/projectile/bullet/grenade/cleaning/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,1,owner,weapon,iff_tag,multiplier = 1.5)
		smoke(old_loc,10,20,null,owner,50,list(/reagent/nutrition/water = 100))


/obj/projectile/bullet/grenade/rubber
	icon_state = "RUBBER"
	hit_target_turf = FALSE
