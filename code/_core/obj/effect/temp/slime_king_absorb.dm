/obj/effect/temp/slime_king_absorb
	name = "absorb"
	icon = 'icons/mob/living/simple/slime_king_new.dmi'
	icon_state = "absorb"
	pixel_x = -32
	pixel_y = -32

	var/atom/movable/king_to_follow

/obj/effect/temp/slime_king_absorb/New(desired_loc,desired_time)
	. = ..()
	filters += filter(type="ripple",x=0,y=0,size=10,repeat=4,radius=0,falloff=0.5,flags=WAVE_BOUNDED)
	animate(filters[length(filters)],radius=0,size=10,easing=SINE_EASING,time=2,loop=-1,flags=ANIMATION_PARALLEL)
	animate(radius=10,size=0,easing=SINE_EASING,time=2)
	animate(radius=5,size=10,easing=SINE_EASING,time=2)
	START_THINKING(src)

/obj/effect/temp/slime_king_absorb/think()

	if(src.loc != king_to_follow.loc)
		src.force_move(king_to_follow.loc)

	. = ..()