/mob/living/simple/exploding_frog
	name = "frog?"
	desc = "*Frog explosion Sounds*"
	desc_extended = "A less than docile frog."
	icon = 'icons/mob/living/simple/frog.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/bite/


	health_base = 20

	stun_angle = 0

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	size = SIZE_CRITTER

	blood_type = /reagent/blood/reptile
	blood_volume = 50

	health_base = 25
	stamina_base = 50
	mana_base = 25

	var/exploded = FALSE

	level = 1

	movement_delay = DECISECONDS_TO_TICKS(3)

/mob/living/simple/exploding_frog/death()

	. = ..()

	if(. && !exploded)
		exploded = TRUE
		var/turf/T = get_turf(src)
		if(T)
			play_sound('sound/effects/frog_explode.ogg',T)
			var/damagetype/DT = all_damage_types[/damagetype/voice_of_god/harm]
			for(var/d in DIRECTIONS_ALL_CENTER)
				var/turf/T2 = get_step(T,d)
				for(var/k in T2.contents)
					var/atom/movable/M = k
					if(M.health)
						var/atom/object_to_damage = M.get_object_to_damage(src,src,DT.type,null,TRUE,TRUE)
						DT.process_damage(src,M,src,object_to_damage,src,1)
				if(T2.health)
					var/atom/object_to_damage = T2.get_object_to_damage(src,src,DT.type,null,TRUE,TRUE)
					DT.process_damage(src,T2,src,object_to_damage,src,1)
			gib(src)