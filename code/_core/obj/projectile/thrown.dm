/obj/projectile/bullet/thrown/
	name = "thrown object"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	collision_flags_special = FLAG_COLLISION_WALKING | FLAG_COLLISION_CRAWLING

	hit_target_turf = TRUE

	impact_effect_turf = null
	impact_effect_movable = null

	muzzleflash_effect = null

/obj/projectile/bullet/thrown/on_projectile_hit(var/atom/hit_atom)

	. = ..()

	if(.)
		for(var/k in src.contents)
			CHECK_TICK(75,FPS_SERVER)
			var/atom/movable/A = k
			if(A.qdeleting)
				A.force_move(null)
				continue
			A.set_dir(dir)
			if(is_item(A))
				var/obj/item/I = A
				I.drop_item(previous_loc)
			else
				A.force_move(previous_loc)
			var/atom/hit_wall
			if(current_loc)
				if(!A.Move(current_loc))
					hit_wall = current_loc
			A.on_thrown(owner,hit_atom,hit_wall)