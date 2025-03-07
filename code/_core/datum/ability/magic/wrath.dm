/ability/magic/wrath
	name = "wrath"
	desc = "Call down a lightning bolt that causes an explosion, an EMP, a fire, and smoke in a target area."
	icon_state = "lightning"
	cost = 100
	cooldown = SECONDS_TO_DECISECONDS(30)



/ability/magic/wrath/on_cast(var/mob/activator,var/atom/target,location,params)

	. = ..()

	var/turf/T = get_turf(target)

	play_sound('sound/weapons/magic/electrical_blast.ogg',T)

	for(var/i=1,i<=5,i++)
		var/obj/effect/temp/lightning/L = new(T,20)
		L.pixel_y = (i-1)*TILE_SIZE
		L.alpha = 255 - i*5

	var/desired_loyalty_tag
	if(is_living(activator))
		var/mob/living/L = activator
		desired_loyalty_tag = L.loyalty_tag

	explode(T,2,activator,activator,desired_loyalty_tag)
	emp(T,2,activator,activator,desired_loyalty_tag)
	firebomb(T,2,activator,activator,desired_loyalty_tag)
	smoke(T,10,10,null,activator,100)
