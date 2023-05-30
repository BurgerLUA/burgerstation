/area/burgerstation
	name = "\improper NSS Burger"
	icon_state = "ship"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION

	sound_environment = ENVIRONMENT_STONEROOM

	ambient_sound = 'sound/ambient/station_loop.ogg'
	random_sounds = list(
		'sound/ambient/station_1.ogg',
		'sound/ambient/station_2.ogg',
		'sound/ambient/station_3.ogg',
		'sound/ambient/station_4.ogg',
		'sound/ambient/station_5.ogg',
		'sound/ambient/station_6.ogg',
		'sound/ambient/station_7.ogg',
		'sound/ambient/station_8.ogg',
		'sound/ambient/station_9.ogg',
		'sound/ambient/station_10.ogg',
		'sound/ambient/station_11.ogg',
		'sound/ambient/station_12.ogg',
		'sound/ambient/station_13.ogg'
	)

	trackable = TRUE

	area_identifier = "Burgerstation"

	safe_storage = TRUE

	allow_ghost = TRUE

	map_color = COLOR_WHITE

	dynamic_lighting = TRUE

	interior = TRUE

	requires_power = TRUE

	default_state_power_lights = ON|AUTO
	default_state_power_machines = ON|AUTO
	default_state_power_doors = ON|AUTO

/area/burgerstation/hall
	name = "\improper Hallway"
	icon_state = "hall"

	sound_environment = ENVIRONMENT_ALLEY

	map_color = COLOR_GREY_LIGHT

/area/burgerstation/hall/north
	name = "\improper North Hallway"
	icon_state = "hall_n"

/area/burgerstation/hall/east
	name = "\improper East Hallway"
	icon_state = "hall_e"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

/area/burgerstation/hall/south
	name = "\improper South Hallway"
	icon_state = "hall_s"

/area/burgerstation/hall/west
	name = "\improper West Hallway"
	icon_state = "hall_w"

/area/burgerstation/hall/central
	name = "\improper Central Primary Hallway"
	icon_state = "hall_c"

/area/burgerstation/hall/dorms
	name = "\improper Dorms Hallway"
	icon_state = "dorms_hall"

/area/burgerstation/bathrooms
	name = "\improper Bathrooms"
	icon_state = "bath"

	sound_environment = ENVIRONMENT_ROOM

	map_color = COLOR_CYAN

/area/burgerstation/merchant
	name = "\improper Merchant's Store"
	icon_state = "village"

	map_color = COLOR_GOLD

/area/burgerstation/cafe
	name = "\improper Cafe"
	icon_state = "cafe"

	map_color = COLOR_CYAN

/area/burgerstation/cafe/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"

	map_color = COLOR_BLUE

	default_state_power_lights = OFF

/area/burgerstation/cafe/kitchen/freezer
	name = "\improper Kitchen Freezer"
	icon_state = "cryo"

	map_color = COLOR_BLUE

/area/burgerstation/cafe/bar
	name = "\improper Bar"
	icon_state = "bar"

	map_color = COLOR_CYAN

	default_state_power_lights = OFF

/area/burgerstation/cafe/botany
	name = "\improper Botany"
	icon_state = "hydro"

	map_color = COLOR_GREEN

/area/burgerstation/dressing
	name = "\improper Dressing Room"
	icon_state = "dressing"

	map_color = COLOR_RED

	sound_environment = ENVIRONMENT_BATHROOM

/area/burgerstation/dorm
	name = "\improper Dorm"
	icon_state = "dorm"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_SAVEZONE

	sound_environment = ENVIRONMENT_ROOM

	map_color = COLOR_BLUE

/area/burgerstation/contractor
	name = "Mr. Scratch's Office"
	icon_state = "dorm"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_SAVEZONE

	map_color = COLOR_RED

	sound_environment = ENVIRONMENT_ROOM

/area/burgerstation/prestige
	name = "\improper Prestige Center"
	icon_state = "dorm"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_GREEN

/area/burgerstation/soccer
	name = "\improper Soccer Field"
	icon_state = "dorm"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_GREEN

/area/burgerstation/vr
	name = "\improper VR Rooms"
	icon_state = "dorm"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_GREEN

/area/burgerstation/help_desk
	name = "\improper Help Desk"
	icon_state = "help"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_GREEN

/area/burgerstation/hop_office
	name = "\improper Head of Personnel's Office"
	icon_state = "cmd"

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_COMMAND

/area/burgerstation/cloning
	name = "\improper Cloning"
	icon_state = "clone"

	map_color = COLOR_MEDICAL

/area/burgerstation/science
	name = "\improper Mining Science"
	icon_state = "science"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_SCIENCE

/area/burgerstation/science/research_director
	name = "\improper Research Director's Office"
	icon_state = "cmd"

/area/burgerstation/science/containment
	name = "\improper Science Containment Area"
	icon_state = "red"

/area/burgerstation/cryo
	name = "\improper Cryogenic Storage"
	icon_state = "cryo"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_SAVEZONE | FLAG_AREA_NO_EVENTS

	map_color = COLOR_GREEN

/area/burgerstation/cryo/locker_room
	name = "\improper Changing Room"
	icon_state = "armory"

	map_color = COLOR_GREEN_DARK

/area/burgerstation/arrivals
	name = "\improper Arrivals Dock"
	icon_state = "ariv"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS

	map_color = COLOR_YELLOW

	sound_environment = ENVIRONMENT_STONEROOM

/area/burgerstation/arrivals/north
	name = "\improper North Arrivals Dock"
	map_color = COLOR_YELLOW
	color = COLOR_YELLOW

/area/burgerstation/arrivals/south
	name = "\improper South Arrivals Dock"
	map_color = COLOR_ORANGE
	color = COLOR_RED

/area/burgerstation/chapel
	name = "\improper Chapel"
	icon_state = "chapel"

	sound_environment = ENVIRONMENT_STONEROOM

	map_color = COLOR_BROWN

/area/burgerstation/chapel/office
	name = "\improper Chapel Office"
	icon_state = "cmd"


/area/burgerstation/library
	name = "\improper Library"
	icon_state = "library"

	sound_environment = ENVIRONMENT_CARPETTED_HALLWAY

	map_color = COLOR_RED_DARK

/area/burgerstation/janitor
	name = "\improper Janitor's Closet"
	icon_state = "janitor"

	sound_environment = ENVIRONMENT_ROOM

	map_color = COLOR_PURPLE

/area/burgerstation/engineering
	name = "\improper Engineering"
	icon_state = "eng"

	sound_environment = ENVIRONMENT_STONEROOM

	map_color = COLOR_ENGINEERING

/area/burgerstation/engineering/solars
	name = "\improper Solars"
	icon_state = "solars"

	map_color = COLOR_YELLOW

/area/burgerstation/engineering/solars/ne
	name = "\improper Starboard Bow Solars"

/area/burgerstation/engineering/solars/se
	name = "\improper Starboard Quarter Solars"

/area/burgerstation/engineering/solars/nw
	name = "\improper Port Bow Solars"

/area/burgerstation/engineering/solars/sw
	name = "\improper Port Quarter Solars"

/area/burgerstation/engineering/lobby
	name = "\improper Engineering Lobby"
	icon_state = "eng"
	color = "#00FF00"

/area/burgerstation/engineering/ce
	name = "\improper Chief Engineer's Office"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	map_color = COLOR_ENGINEERING

/area/burgerstation/engineering/telecomms
	name = "\improper Telecomms"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	map_color = COLOR_ENGINEERING

/area/burgerstation/engineering/supermatter
	name = "\improper Supermatter"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	map_color = COLOR_ENGINEERING

/area/burgerstation/medical
	name = "\improper Medical"
	icon_state = "med"

	map_color = COLOR_MEDICAL

/area/burgerstation/medical/cmo
	name = "\improper Chief Medical Officer's Office"
	icon_state = "cmd"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	map_color = COLOR_MEDICAL_LIGHT

/area/burgerstation/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

	map_color = COLOR_CHEMISTRY

/area/burgerstation/medical/lobby
	name = "\improper Medical Lobby"
	icon_state = "lobby"

/area/burgerstation/briefing
	name = "\improper Briefing"
	icon_state = "brief"

	map_color = COLOR_BROWN

/area/burgerstation/bait_shop
	name = "\improper Bait Shop"
	icon_state = "bait"

	map_color = COLOR_BLUE

/area/burgerstation/goblin_shop
	name = "\improper Bawse Loot"
	icon_state = "bait"

	map_color = COLOR_GREEN

/area/burgerstation/mining
	name = "\improper Mining"
	icon_state = "mining"

	map_color = COLOR_BROWN

/area/burgerstation/mining/lobby
	name = "\improper Mining Lobby"
	icon_state = "lobby"

/area/burgerstation/mining/foreman
	name = "\improper Mining Foreman's Office"
	icon_state = "cmd"

	map_color = COLOR_COMMAND

/area/burgerstation/tax
	name = "\improper Tax Room"
	icon_state = "tax"

	map_color = COLOR_GREEN

/area/burgerstation/armory
	name = "\improper Armory"
	icon_state = "armory"

	map_color = COLOR_NANOTRASEN

/area/burgerstation/armory/special
	name = "\improper Armory - Special Operations"
	icon_state = "armory_special"

/area/burgerstation/armory/shooting_range
	name = "\improper Shooting Range"
	icon_state = "shooting_range"

	sound_environment = ENVIRONMENT_STONEROOM

/area/burgerstation/hanger
	name = "\improper Hanger"
	icon_state = "hanger"

	sound_environment = ENVIRONMENT_CONCERT_HALL

	map_color = COLOR_BLUE

/area/burgerstation/hanger/blue
	name = "\improper Blue Hanger Bay"
	color = COLOR_BLUE

/area/burgerstation/hanger/red
	name = "\improper Red Hanger Bay"
	color = COLOR_RED

/area/burgerstation/hanger/green
	name = "\improper Green Hanger Bay"
	color = COLOR_GREEN

/area/burgerstation/hanger/drop_pod_bay
	name = "\improper Drop Pod Bay"
	color = COLOR_ORANGE

/area/burgerstation/cargo
	name = "\improper Cargo"
	icon_state = "cargo"

	map_color = COLOR_CARGO

/area/burgerstation/cargo/lobby
	name = "\improper Cargo Lobby"
	icon_state = "lobby"

/area/burgerstation/maint
	name = "\improper Maint"
	icon_state = "maint"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

	map_color = COLOR_GREY_DARK

	sound_environment = ENVIRONMENT_BATHROOM

	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_DIRTY

/area/burgerstation/maint/north
	name = "\improper North Maintenance"
	icon_state = "maint_n"

/area/burgerstation/maint/east
	name = "\improper East Maintenance"
	icon_state = "maint_e"

/area/burgerstation/maint/south
	name = "\improper South Maintenance"
	icon_state = "maint_s"

/area/burgerstation/maint/west
	name = "\improper West Maintenance"
	icon_state = "maint_w"

/area/burgerstation/maint/disposals
	name = "\improper Disposals Maintenance"
	icon_state = "disposals"

/area/burgerstation/chess
	name = "\improper Chess"
	icon_state = "disposals"
	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

	default_state_power_lights = OFF

	map_color = COLOR_ORANGE

	sound_environment = ENVIRONMENT_BATHROOM

/area/burgerstation/maint/pvp

	ambient_sound = 'sound/ambient/vents_loop.ogg'

	random_sounds = list(
		'sound/ambient/maint_1.ogg',
		'sound/ambient/maint_2.ogg'
	)

	map_color = COLOR_ORANGE
	sound_environment = ENVIRONMENT_BATHROOM



/area/burgerstation/maint/pvp/table
	name = "ERROR"
	icon_state = "pvp"
	flags_area = FLAG_AREA_NO_TELEPORT | FLAG_AREA_NO_CONSTRUCTION | FLAG_AREA_NO_LOYALTY | FLAG_AREA_NO_EVENTS | FLAG_AREA_NO_TELEPORT

	sound_environment = ENVIRONMENT_ALLEY

	map_color = COLOR_ORANGE

	link_to_parent_apc = TRUE
