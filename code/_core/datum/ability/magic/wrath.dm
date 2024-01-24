/ability/magic/wrath
	name = "wrath"
	desc = "Call down a lightning bolt that causes an explosion, an EMP, a fire, and smoke in a target area."
	icon_state = "lightning"
	cost = 100
	cooldown = 30 SECONDS



/ability/magic/wrath/on_cast(var/mob/caller,var/atom/target,location,params)

	. = ..()

	var/turf/T = get_turf(target)

	play_sound('sound/weapons/magic/electrical_blast.ogg',T)

	for(var/i=1,i<=5,i++)
		var/obj/effect/temp/lightning/L = new(T,20)
		L.pixel_y = (i-1)*TILE_SIZE
		L.alpha = 255 - i*5

	var/desired_loyalty_tag
	if(is_living(caller))
		var/mob/living/L = caller
		desired_loyalty_tag = L.loyalty_tag

	explode(T,2,caller,caller,desired_loyalty_tag)
	emp(T,2,caller,caller,desired_loyalty_tag)
	firebomb(T,2,caller,caller,desired_loyalty_tag)
	smoke(T,10,10,null,caller,100)
