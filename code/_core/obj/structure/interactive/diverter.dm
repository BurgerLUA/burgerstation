#define MODE_NONE "none"
#define MODE_VALUE "value"
#define MODE_DENSITY "density"
#define MODE_MATERIAL "material"
#define MODE_LIVING "living"
#define MODE_WEAPON "weapon"
#define MODE_BUTCHERABLE "butcherable"
#define MODE_CRATE "crate"

/obj/structure/interactive/diverter/
	name = "airjet diverter"
	desc = "Pssssh."
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions."
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "diverter"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = 0x0

	var/think_timer = 0

	var/list/atom/movable/tracked_movables = list()

	var/mode = MODE_NONE
	var/value_threshold = 50

	density = TRUE

/obj/structure/interactive/diverter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the diverter."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the diverter."))
				anchored = TRUE
		else if(T.flags_tool & FLAG_TOOL_MULTITOOL && mode == MODE_VALUE) // Should I REALLY make it need a multitool?
			value_threshold = clamp(input(caller, "What do you want to set the threshold to?","[src]",value_threshold),-1,50000)
			caller.to_chat(span("notice","You set the threshold to [value_threshold]."))
	else
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			var/modes = list(MODE_NONE,MODE_VALUE,MODE_DENSITY,MODE_MATERIAL,MODE_LIVING,MODE_WEAPON,MODE_CRATE,MODE_BUTCHERABLE,"CANCEL")
			var/whatmode = input(caller, "What do you want to set the mode to?","[src]",mode) as null|anything in modes
			if(whatmode == null || whatmode == "CANCEL")
				return
			mode = whatmode
			name = "[initial(name)] ([mode])"
		else
			caller.visible_message(span("notice","\The [caller.name] rotates \the [src.name]."),span("notice","You rotate \the [src.name]."))
			set_dir(turn(dir,90))

			update_sprite()

	return TRUE

/obj/structure/interactive/diverter/Initialize()

	if(.)
		collision_dir = turn(dir,180)

	return ..()

/obj/structure/interactive/diverter/PostInitialize()
	. = ..()
	name = "[initial(name)] ([mode])"
	update_sprite()

/obj/structure/interactive/diverter/update_icon()
	. = ..()
	icon_state = "diverter_on"

/obj/structure/interactive/diverter/proc/should_push(var/atom/movable/M)
	if(!anchored)
		return FALSE
	switch(mode)
		if(MODE_NONE)
			return TRUE
		if(MODE_VALUE)
			if(is_item(M)) // Can't put this in the "if" right above it...
				var/obj/item/I = M
				return I.get_value() >= value_threshold
		if(MODE_DENSITY)
			return M.density && M.collision_flags != FLAG_COLLISION_NONE
		if(MODE_MATERIAL)
			return istype(M,/obj/item/material) && !istype(M,/obj/item/material/shard)
		if(MODE_LIVING)
			if(is_living(M))
				var/mob/living/L = M
				if(!L.dead || L.ckey_last)
					return TRUE
		if(MODE_WEAPON)
			return istype(M,/obj/item/weapon)
		if(MODE_BUTCHERABLE)
			if(is_living(M))
				var/mob/living/L = M
				if(L.override_butcher || length(L.butcher_contents))
					return TRUE
		if(MODE_CRATE)
			return istype(M,/obj/structure/interactive/crate)


/obj/structure/interactive/diverter/think()

	for(var/k in tracked_movables)
		var/v = tracked_movables[k]
		if(v > world.time)
			continue
		var/atom/movable/M = k
		if(!M.anchored && !M.grabbing_hand && should_push(M) && M.loc == src.loc)
			M.Move(get_step(src,dir))
		tracked_movables -= k

	think_timer--

	return think_timer

/obj/structure/interactive/diverter/Crossed(atom/movable/O,atom/OldLoc)

	tracked_movables[O] = world.time + 4

	if(!think_timer)
		START_THINKING(src)

	think_timer = 10

	return ..()

/obj/structure/interactive/diverter/get_examine_list(mob/examiner)
	. = ..()
	if(mode == MODE_VALUE)
		. += div("notice","It's set to divert anything with a value equal or higher to [value_threshold].")

/obj/structure/interactive/diverter/high_value
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one scans the value of the object and pushes it if it exceeds a certain amount."
	mode = MODE_VALUE

/obj/structure/interactive/diverter/density
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one measures the density of the object."
	mode = MODE_DENSITY

/obj/structure/interactive/diverter/material
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one checks whether or not the object is a raw material."
	mode = MODE_MATERIAL

/obj/structure/interactive/diverter/living
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one checks whether or not the object is a living person or a creature, or is able to be revived."
	mode = MODE_LIVING

/obj/structure/interactive/diverter/weapon
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one checks if it's a weapon."
	mode = MODE_WEAPON

/obj/structure/interactive/diverter/butcherable
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one checks whether or not the object can be butchered for food."
	mode = MODE_BUTCHERABLE

/obj/structure/interactive/diverter/crate
	desc_extended = "A special conveyor diverter that uses powerful jets of air to push objects off the conveyor belt based on the conditions. This one checks if it's a crate."
	mode = MODE_CRATE

#undef MODE_NONE
#undef MODE_VALUE
#undef MODE_DENSITY
#undef MODE_MATERIAL
#undef MODE_LIVING
#undef MODE_WEAPON
#undef MODE_BUTCHERABLE
#undef MODE_CRATE
