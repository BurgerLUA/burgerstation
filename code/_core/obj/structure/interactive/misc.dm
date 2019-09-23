obj/structure/interactive/misc/
	icon = 'icons/obj/structure/misc.dmi'

obj/structure/interactive/misc/tv
	name = "tv"
	icon_state = "tv"
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC


obj/structure/interactive/misc/dresser
	name = "dresser"
	icon_state = "dresser"
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

obj/structure/interactive/misc/dresser/chargen/clicked_by_object(caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/A = caller

	if(!A.underwear_added)

		if(A.sex == MALE)
			A.add_outfit("new_male",TRUE)
		else
			A.add_outfit("new_female",TRUE)

		A.underwear_added = TRUE

		if(!A.appearance_changed)
			A.to_chat(span("thought","Now that I have underwear on, I should see if I have a case of bedhead in the bathroom mirror."))
			return TRUE

		if(!A.job_changed)
			A.to_chat(span("thought","Now that I have underwear on, I should probably check my emails on my computer for job offers before fully dressing."))
			return TRUE

	if(!A.found_job)
		A.to_chat(span("thought","I should probably check my emails first to see what job offers I have before fully dressing."))
		return TRUE

	if(!A.clothing_changed)
		A.add_outfit("assistant",TRUE)
		A.to_chat(span("thought","I'm ready for work now. I should probably head out before I miss the next shuttle."))
		A.clothing_changed = TRUE
		return TRUE

	A.to_chat(span("thought","I look as good as I can right now. I should catch the shuttle before I miss it."))

	return TRUE


obj/structure/interactive/misc/toilet
	name = "toilet"
	icon_state = "toilet"


obj/structure/interactive/misc/shower
	name = "shower"
	icon_state = "shower"

obj/structure/interactive/misc/mirror
	name = "mirror"
	icon_state = "mirror"


obj/structure/interactive/misc/mirror/chargen/Crossed(var/atom/crosser)
	if(is_advanced(crosser))
		var/mob/living/advanced/A = crosser
		if(!A.appearance_changed)
			A.show_hud(TRUE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=3)
		else
			A.to_chat(span("thought","No. I look beautiful! I don't need to change anything!"))

	return ..()

obj/structure/interactive/misc/mirror/chargen/Uncrossed(var/atom/crosser)
	if(is_advanced(crosser))
		var/mob/living/advanced/A = crosser
		if(!A.appearance_changed)
			A.show_hud(FALSE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=1)
			A.to_chat(span("thought","There. I look perfect!"))
			A.used_mirror = TRUE

	return ..()

obj/structure/interactive/misc/curtain_open
	name = "curtain"
	icon_state = "curtain_open"
	alpha = 175

obj/structure/interactive/misc/sink
	name = "sink"
	icon_state = "sink"