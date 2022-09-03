/particles/cannon_fuse
	width = 4
	height = 4
	count = 100
	spawning = 0
	lifespan = 30
	fade = 20
	position = generator("box",list(17,-13,0),list(18,-14,0))
	friction = 0.1
	gradient = list(0,"yellow",1,"red")
	color = 0
	color_change = 0.2
	drift = generator("sphere", -8, 8)



/obj/structure/interactive/cannon
	name = "giant smoothbore cannon"
	desc = "Can't hit shit."
	desc_extended = "An extremely primitive smoothbore cannon designed to be shot at massive objects, like ships. Note that this fact really doesn't stop most people."

	icon = 'icons/obj/structure/cannon.dmi'
	icon_state = "map"

	var/has_fuse = TRUE

	pixel_x = -4
	pixel_y = -4

	density = TRUE
	anchored = FALSE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	collision_dir = NORTH | EAST | SOUTH | WEST

	interaction_flags = FLAG_INTERACTION_LIVING

	particles = new/particles/cannon_fuse

	var/total_size = 0

/obj/structure/interactive/cannon/New(var/desired_loc)
	. = ..()
	icon_state = "idle"

/obj/structure/interactive/cannon/Finalize()
	. = ..()

	for(var/obj/item/I in loc.contents)
		if(!src.can_insert_item(null,I))
			continue
		src.insert_item(null,I)

	update_sprite()

/obj/structure/interactive/cannon/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		var/matrix/M = matrix()
		M.Turn(dir2angle(src.dir) + 180)
		transform = M


/obj/structure/interactive/cannon/proc/insert_item(var/mob/living/caller,var/obj/item/I)
	I.drop_item(src)
	total_size += I.size
	caller?.visible_message(span("notice","\The [caller.name] inserts \the [I.name] into \the [src.name]."),span("notice","You insert \the [I.name] into \the [src.name]."))
	return TRUE

/obj/structure/interactive/cannon/proc/fire(var/mob/living/caller)

	var/turf/T = get_step(src,dir)
	if(!T)
		return TRUE //Heh

	var/loyalty_tag_to_use = caller ? caller.loyalty_tag : "Pirate"

	var/main_angle = dir2angle(dir)
	for(var/k in contents)
		var/atom/movable/M = k
		var/desired_angle = main_angle + rand(-10,10)
		var/offset_x = sin(desired_angle)
		var/offset_y = cos(desired_angle)
		M.throw_self(caller,null,16,16,offset_x*(TILE_SIZE-1),offset_y*(TILE_SIZE-1),SECONDS_TO_DECISECONDS(4),VIEW_RANGE*3,loyalty_tag_to_use,10)

	total_size = 0

	play_sound('sound/weapons/cannon_shot.ogg',T)

	//Explosion effects.
	explode(T,100,caller,src,loyalty_tag_to_use,src.dir,3)
	smoke(T,3,SECONDS_TO_DECISECONDS(3),null,caller,100)

	has_fuse = FALSE
	particles.spawning = 0
	update_sprite()

	flick("fire",src)

	if(!anchored)
		var/turf/BT = get_step(src,turn(dir,180))
		if(BT) src.Move(BT)


/obj/structure/interactive/cannon/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	DEFER_OBJECT

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/mob/living/L = caller

	if(is_item(defer_object))
		var/obj/item/I = defer_object
		if(istype(I,/obj/item/cannon_fuse))
			if(has_fuse)
				caller.to_chat(span("warning","\The [src.name] already has a fuse!"))
				return TRUE
			caller.visible_message(span("notice","\The [caller.name] inserts \the [I.name] into \the [src.name]."),span("notice","You insert \the [I.name] into \the [src.name]."))
			has_fuse = TRUE
			qdel(I)
			update_sprite()
			return TRUE
		if(L.intent == INTENT_DISARM || istype(I,/obj/item/cannonball))
			if(!can_insert_item(caller,object))
				return TRUE
			caller.visible_message(span("notice","\The [caller.name] starts to insert \the [I.name] into \the [src.name]..."),span("notice","You start to insert \the [I.name] into \the [src.name]..."))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/insert_item,caller,I)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_insert_item,caller,I)
			return TRUE
		var/damagetype/desired_damage_type = I.get_damage_type(caller,src)
		if(desired_damage_type)
			var/damagetype/DT = all_damage_types[desired_damage_type]
			if(DT && DT.attack_damage_base[HEAT])
				caller.visible_message(span("danger","\The [caller.name] starts to light the fuse of \the [src.name] with \the [I.name]!"),span("warning","You start to light the fuse of \the [src.name] with \the [I.name]..."))
				PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/light_fuse,caller,I)
				PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_light_fuse,caller,I)
				return TRUE



/obj/structure/interactive/cannon/proc/can_insert_item(var/mob/caller,var/obj/item/I)

	if(caller)
		INTERACT_CHECK_NO_DELAY(src)

	if(!has_fuse)
		caller?.to_chat(span("warning","\The [src.name] requires a fuse first!"))
		return FALSE

	if(I.size > SIZE_2)
		caller?.to_chat(span("warning","\The [I.name] is too large to be put into \the [src.name]!"))
		return FALSE

	if(total_size + I.size >= SIZE_2 + SIZE_1)
		caller?.to_chat(span("warning","\The [src.name] is too full to accept \the [I.name]!"))
		return FALSE

	if(length(contents) >= 5)
		caller?.to_chat(span("warning","\The [src.name] is too full to accept \the [I.name]!"))
		return FALSE

	if(caller)
		var/obj/hud/inventory/INV = I.loc
		if(!istype(INV))
			caller.to_chat(span("warning","You need to be holding \the [I.name] to insert it into \the [src.name]!"))
			return FALSE
		if(INV.owner != caller || !INV.click_flags) //Must be holding.
			caller.to_chat(span("warning","You need to be holding \the [I.name] to insert it into \the [src.name]!"))
			return FALSE

	return TRUE

/obj/structure/interactive/cannon/update_overlays()
	. = ..()
	if(has_fuse && !CALLBACK_EXISTS("\ref[src]_fire_cannon"))
		var/image/I = new/image(icon,"fuse")
		add_overlay(I)

/obj/structure/interactive/cannon/proc/light_fuse(var/mob/living/caller)
	caller.visible_message(span("danger","\The [caller.name] lights the fuse of \the [src.name]!"),span("danger","You light the fuse of \the [src.name]!"))
	CALLBACK("\ref[src]_fire_cannon",SECONDS_TO_DECISECONDS(3),src,.proc/fire,caller)
	update_sprite()
	particles.spawning = 10
	play_sound('sound/effects/fuse.ogg',get_turf(src))
	return TRUE

/obj/structure/interactive/cannon/proc/can_light_fuse(var/mob/caller,var/obj/item/I)

	INTERACT_CHECK_NO_DELAY(src)

	if(CALLBACK_EXISTS("\ref[src]_fire_cannon"))
		caller?.to_chat(span("warning","\The [src.name] is already lit!"))
		return FALSE

	if(!has_fuse)
		caller?.to_chat(span("warning","\The [src.name] has no fuse to fire!"))
		return FALSE

	var/obj/hud/inventory/INV = I.loc
	if(!istype(INV))
		caller.to_chat(span("warning","You need to be holding \the [I.name] to light \the [src.name]!"))
		return FALSE
	if(INV.owner != caller || !INV.click_flags) //Must be holding.
		caller.to_chat(span("warning","You need to be holding \the [I.name] to light \the [src.name]!"))
		return FALSE

	return TRUE