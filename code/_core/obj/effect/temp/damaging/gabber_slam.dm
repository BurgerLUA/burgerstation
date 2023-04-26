/obj/effect/gabber_slam
	alpha = 0

	var/mob/living/owner
	hazardous = TRUE

	damage_type = /damagetype/unarmed/holy/slam

	pixel_x = -32
	pixel_y = -32

	icon = 'icons/obj/effects/gabber_slam.dmi'
	icon_state = "slam"

	plane = PLANE_WALL_ATTACHMENT
	layer = -1000

	blend_mode = BLEND_ADD

	var/animate_caster = TRUE

/obj/effect/gabber_slam/proc/charge()
	play_sound('sound/weapons/magic/repulse_fast_charge.ogg',get_turf(src))
	animate(src,alpha=100,time=2)
	if(animate_caster)
		animate(owner,pixel_z=20,time=8,easing=BACK_EASING|EASE_OUT)
	CALLBACK("\ref[src]_slam",8,src,src::slam())

/obj/effect/gabber_slam/proc/slam()
	play_sound('sound/weapons/magic/repulse_fast.ogg',get_turf(src))
	var/matrix/M = matrix()
	M.Scale(0)
	transform = M
	animate(src,alpha=255,transform=get_base_transform(),time=2)
	if(animate_caster)
		animate(owner,pixel_z=initial(owner.pixel_z)-5,time=1,easing=BACK_EASING|EASE_OUT)
	flick("slam_anim",src)
	for(var/k in DIRECTIONS_ALL + 0x0)
		var/turf/T = get_step(src,k)
		if(!T.has_dense_atom)
			continue
		for(var/j in T.contents)
			var/atom/movable/M2 = j
			if(!M2.density || !M2.health)
				continue
			do_damage(M2)

	CALLBACK("\ref[src]_end",5,src,src::end())

/obj/effect/gabber_slam/proc/end()
	animate(src,alpha=0,time=5)
	if(animate_caster)
		animate(owner,pixel_z=initial(owner.pixel_z),time=5,easing=BACK_EASING|EASE_OUT)
	CALLBACK("\ref[src]_delete",5,src,/datum/proc/delete)


/obj/effect/gabber_slam/proc/get_params(var/atom/victim)
	. = list()
	.[PARAM_ICON_X] = 16
	.[PARAM_ICON_Y] = 16

/obj/effect/gabber_slam/proc/do_damage(var/atom/victim)

	if(is_living(victim) && is_living(owner) && owner != victim)
		var/mob/living/L = victim
		var/mob/living/L2 = owner
		if(!allow_hostile_action(L2.loyalty_tag,L))
			return FALSE

	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(owner,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,damage_type,params,TRUE,TRUE)
	return DT.process_damage(owner,victim,src,object_to_damage,owner,1)