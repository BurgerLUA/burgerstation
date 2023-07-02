/gamemode/mission/syndicate
	name = "Mission - Syndicate"
	gamemode_horde_data = /horde_data/syndicate

	interior_corpse_type = /mob/living/advanced/citizen
	exterior_corpse_type = /mob/living/advanced/npc/nanotrasen

/gamemode/mission/syndicate/add_objectives()
	. = ..()
	add_objective(/objective/hostage)
	add_objective(/objective/hostage)


/gamemode/mission/zombie
	name = "Mission - Zombies + Blob"
	gamemode_horde_data = /horde_data/zombies

	interior_corpse_type = /mob/living/advanced/npc/zombie/normal/decapitated
	exterior_corpse_type = /mob/living/advanced/npc/zombie/worker/decapitated

/gamemode/mission/zombie/add_objectives()
	. = ..()
	var/player_count = length(all_clients)

	var/blobs_to_spawn = min(3+(player_count/10),length(possible_blob_locations))

	for(var/i=1,i<=blobs_to_spawn,i++)
		if(!add_objective(/objective/kill_blob))
			break

/gamemode/mission/xeno
	name = "Mission - Xenomorphs + Soldiers"
	gamemode_horde_data = /horde_data/xeno_plus_soliders

	interior_corpse_type = /mob/living/advanced/citizen
	exterior_corpse_type = /mob/living/advanced/npc/space_soldier

/gamemode/mission/xeno/add_objectives()
	. = ..()
	add_objective(/objective/hostage)
	add_objective(/objective/artifact)

/gamemode/mission/revolutionaries
	name = "Mission - Revolutionaries"
	gamemode_horde_data = /horde_data/revolutionary

	interior_corpse_type = /mob/living/advanced/citizen
	exterior_corpse_type = /mob/living/advanced/npc/space_soldier

/gamemode/mission/revolutionaries/add_objectives()
	. = ..()
	add_objective(/objective/artifact)
	add_objective(/objective/artifact)