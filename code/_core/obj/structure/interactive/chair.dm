obj/structure/interactive/chair
	name = "chair"
	desc = "You will sit in this. By will or by force."
	desc_extended = "A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person. Buckling is automatic and will be attempted upon walking over something you can buckle into."
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

	bullet_block_chance = 25

	density = TRUE
	anchored = FALSE

	var/armrest = FALSE

obj/structure/interactive/chair/update_overlays()
	. = ..()
	if(armrest)
		var/image/I = new/image(icon,"[icon_state]_armrest")
		I.appearance_flags = src.appearance_flags
		I.plane = PLANE_MOVABLE
		I.layer = LAYER_MOB_ABOVE + 1
		add_overlay(I)

obj/structure/interactive/chair/Finalize()
	. = ..()
	if(armrest)
		update_sprite()
	set_dir(dir,TRUE)

obj/structure/interactive/chair/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(. || force)
		if(dir == NORTH)
			plane = PLANE_MOVABLE
			layer = LAYER_MOB_ABOVE
		else
			plane = initial(plane)


obj/structure/interactive/chair/Crossed(atom/movable/O,atom/OldLoc)

	. = ..()

	if(is_living(O))
		CALLBACK("sit_down_\ref[src]",SECONDS_TO_DECISECONDS(1),src,src::sit_your_ass_down(),O)


obj/structure/interactive/chair/proc/sit_your_ass_down(var/mob/living/L)

	if(L.loc != src.loc)
		return FALSE

	L.set_dir(src.dir)

	return TRUE

/obj/structure/interactive/chair/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller.loc == src.loc)
		src.buckle(caller)
		return TRUE

	. = ..()

obj/structure/interactive/chair/stool
	name = "stool"
	desc = "Apply butt."
	desc_extended = "A chair without back or arm rests, also known as a stool."
	icon_state = "stool"

	bullet_block_chance = 5

obj/structure/interactive/chair/stool/bar
	name = "bar stool"
	desc = "Apply butt."
	desc_extended = "A chair without back or arm rests, also known as a stool. This one is raised up, therefore it classifies as a bar stool."
	icon_state = "bar"


obj/structure/interactive/chair/wood
	name = "wooden chair"
	desc = "You will sit in this. By will or by force."
	desc_extended = "A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person."
	icon_state = "wooden_chair"

	bullet_block_chance = 10

obj/structure/interactive/chair/office
	name = "office chair"
	icon_state = "officechair_white"

obj/structure/interactive/chair/office/dark
	name = "office chair"
	icon_state = "officechair_dark"

obj/structure/interactive/chair/comfy
	name = "comfy chair"
	icon_state = "comfychair"

	armrest = TRUE


obj/structure/interactive/chair/shuttle
	name = "shuttle chair"
	icon_state = "shuttle_chair"

	armrest = TRUE

	pixel_y = 2

obj/structure/interactive/chair/shuttle/dark
	color = COLOR_GREY_LIGHT
