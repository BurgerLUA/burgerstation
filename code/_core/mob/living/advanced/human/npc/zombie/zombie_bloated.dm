//Bloated zombies create spores on death. Move very slowly. Has a lot of HP.

/mob/living/advanced/npc/zombie/bloated
	name = "zombie bloater"
	loadout = /loadout/zombie/bloated

	level = 15

	health_base = 400
	stamina_base = 50
	mana_base = 100

	movement_delay = DS2TICKS(8)

	sex = MALE
	gender = MALE


/mob/living/advanced/npc/zombie/bloated/Finalize()
	. = ..()
	add_status_effect(FAT,100,-1, force = TRUE)


/mob/living/advanced/npc/zombie/bloated/post_death()
	. = ..()
	if(.)
		var/turf/T = get_turf(src)
		src.visible_message(span("danger","\The [src.name] explodes into blob spores!"))
		if(T)
			var/list/valid_directions = DIRECTIONS_ALL
			for(var/i=1,i<=rand(2,4),i++)
				var/mob/living/simple/blob_spore/BS = new(T)
				INITIALIZE(BS)
				GENERATE(BS)
				FINALIZE(BS)
				if(BS.ai)
					BS.ai.set_active(TRUE)
				BS.Move(get_step(T,pick(valid_directions)))
		gib()
