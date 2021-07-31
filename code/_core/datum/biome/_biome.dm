/biome/
	var/name = "biome name"

	var/surface_turf
	var/surface_path_turf
	var/cave_turf
	var/cave_path_turf

	var/surface_area
	var/cave_area

	var/list/horde_weights = list(
		"syndicate" = 100,
		"revolutionaries" = 75
	)

	var/list/horde_types = list(
		"syndicate" = list(
			/mob/living/advanced/npc/syndicate = 10,
			/mob/living/simple/silicon/syndieborg = 1
		),
		"revolutionaries" = list(
			/mob/living/advanced/npc/rev = 10,
			/mob/living/simple/bear/armored/revolutionary = 1
		)


	)

/biome/forest
	name = "Forest"
	surface_turf = /turf/unsimulated/generation/forest
	surface_path_turf = /turf/unsimulated/generation/forest/path
	cave_turf = /turf/unsimulated/generation/forest_cave
	cave_path_turf = /turf/unsimulated/generation/forest_cave/path

/biome/snow
	name = "Snow"
	surface_turf = /turf/unsimulated/generation/snow
	surface_path_turf = /turf/unsimulated/generation/snow/path
	cave_turf = /turf/unsimulated/generation/snow_cave
	cave_path_turf = /turf/unsimulated/generation/snow_cave/path