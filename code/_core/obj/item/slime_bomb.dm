/obj/item/slime_bomb
	name = "bomb"
	desc = "LATERNS, LAMP OIL, ROPE."
	desc_extended = "A strange looking black powder bomb."
	icon = 'icons/obj/item/old_bomb.dmi'
	icon_state = "bomb"

	var/lit = FALSE
	var/bomb_range = 3
	var/bomb_multiplier = 2
	var/stage_speed = 3 //Has 9 stages, so a speed of 1 would be 9 deciseconds.
	var/atom/owner
	var/loyalty_tag

	value_burgerbux = 1

	value = 100

/obj/item/slime_bomb/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(!lit)
		var/damagetype/DT = SSdamagetype.all_damage_types[object.get_damage_type(caller,src)]
		if(DT.attack_damage_base[HEAT] || DT.attack_damage_base[LASER])
			light()
			return TRUE
	. = ..()

/obj/item/slime_bomb/proc/light(var/stage=9)

	stage--
	lit = TRUE

	if(stage < 0)
		explode(get_turf(src),bomb_range,owner,src,loyalty_tag,0x0,bomb_multiplier)
		qdel(src)
		return TRUE

	icon_state = "fuse_[stage]"

	CALLBACK("\ref[src]_bomb_stage_[stage]",stage_speed,src,src::light(),stage)

	return TRUE

