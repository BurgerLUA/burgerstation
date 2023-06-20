/area/mission/prefab/boss
	icon_state = "red"
	flags_area = FLAG_AREA_NO_HORDE | FLAG_AREA_IMPORTANT

/area/mission/prefab/boss/colossus
	name = "snow containment biome"
	requires_power = FALSE //TODO: Add power to this prefab.
	interior = TRUE
	default_state_power_lights = ON|AUTO
	default_state_power_machines = ON|AUTO
	default_state_power_doors = ON|AUTO

/area/mission/prefab/boss/leaper
	name = "leaper's hideout"
	interior = TRUE


/area/mission/prefab/boss/herald
	name = "herald's arena"
	interior = TRUE

/area/mission/prefab/boss/gabber
	name = "Zechariah's Lair"
	interior = TRUE


/area/mission/prefab/boss/slime_king
	name = "Slime King's throne"
	interior = FALSE

	sunlight_freq = 16
	sunlight_color = "#CCB06A"


/area/mission/prefab/boss/canman
	name = "\improper Syndicate Experimentation Building"
	interior = TRUE
	requires_power = TRUE //TODO: Add power to this prefab.
	default_state_power_lights = ON|AUTO
	default_state_power_machines = ON|AUTO
	default_state_power_doors = ON|AUTO
	flags_area = FLAG_AREA_NO_HORDE | FLAG_AREA_IMPORTANT | FLAG_AREA_DIRTY

/area/mission/prefab/boss/canman/lobby
	icon_state = "lobby"

/area/mission/prefab/boss/canman/containment
	icon_state = "science"

/area/mission/prefab/boss/canman/left_wing
	icon_state = "library"

/area/mission/prefab/boss/canman/right_wing
	icon_state = "chapel"

/area/mission/prefab/boss/canman/cave
	icon_state = "cave"
	requires_power = FALSE