/obj/effect/temp/soul
	name = "soul"
	mouse_opacity = 1
	duration = SECONDS_TO_DECISECONDS(10)

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = "preview"

	var/soul_size = 0

/obj/effect/temp/soul/Finalize()

	filters += filter(type="wave",x=rand(-30,30),y=rand(-30,30),offset=10)
	var/f1 = filters[length(filters)]
	animate(f1,offset=f1:offset,time=0,loop=-1,flags=ANIMATION_PARALLEL)
	animate(offset=f1:offset-1,time=rand(20,30))

	filters += filter(type="angular_blur",x=0,y=60,size=3)
	var/f2 = filters[length(filters)]
	animate(f2,x=f2:x,time=0,loop=-1,flags=ANIMATION_PARALLEL)
	animate(x=f2:x-5,time=rand(20,30))

	animate(src,pixel_z=TILE_SIZE,time=duration)

	CALLBACK("remove_effect_fade_\ref[src]",duration-SECONDS_TO_DECISECONDS(1),src,.proc/remove_effect_fade)

	color = "#000000"

	return ..()

/obj/effect/temp/soul/proc/remove_effect_fade()
	animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(1))
	return TRUE