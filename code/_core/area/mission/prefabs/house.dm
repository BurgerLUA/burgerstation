/area/mission/prefab/house
	horde_data = /horde_data/city

/area/mission/prefab/house/Initialize()
	. = ..()
	if(parent_type == /area/mission/prefab/house)
		name = "\improper [pick(SStext.last_names)] Residence"


/area/mission/prefab/house/Finalize()
	. = ..()
	if(parent_type != /area/mission/prefab/house)
		var/area/A = locate(parent_type)
		name = A.name

//House 01
/area/mission/prefab/house/house_01
	name = "house 01"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_01/bathroom_01
	icon_state = "red"

/area/mission/prefab/house/house_01/bathroom_02
	icon_state = "blue"

/area/mission/prefab/house/house_01/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_01/master_bedroom
	icon_state = "purple"

/area/mission/prefab/house/house_01/boys_bedroom
	icon_state = "cyan"

/area/mission/prefab/house/house_01/girls_bedroom
	icon_state = "pink"

/area/mission/prefab/house/house_01/hallway
	icon_state = "orange"

/area/mission/prefab/house/house_01/entrance
	icon_state = "brown"



//House 02
/area/mission/prefab/house/house_02
	name = "house 02"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_02/bathroom
	icon_state = "red"

/area/mission/prefab/house/house_02/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_02/entrance
	icon_state = "blue"

/area/mission/prefab/house/house_02/bedroom
	icon_state = "purple"

/area/mission/prefab/house/house_02/hallway
	icon_state = "orange"

//House 03
/area/mission/prefab/house/house_03
	name = "house 03"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_03/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_03/bedroom
	icon_state = "purple"

/area/mission/prefab/house/house_03/backroom
	icon_state = "orange"

/area/mission/prefab/house/house_03/entrance
	icon_state = "red"

/area/mission/prefab/house/house_03/closet
	icon_state = "blue"

//House 04
/area/mission/prefab/house/house_04
	name = "house 04"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_04/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_04/bedroom
	icon_state = "purple"

/area/mission/prefab/house/house_04/entrance
	icon_state = "red"

/area/mission/prefab/house/house_04/bathroom
	icon_state = "orange"


//House 05
/area/mission/prefab/house/house_05
	name = "house 05"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_05/bathroom
	icon_state = "green"

/area/mission/prefab/house/house_05/kitchen
	icon_state = "purple"

/area/mission/prefab/house/house_05/entrance
	icon_state = "red"

/area/mission/prefab/house/house_05/storage
	icon_state = "blue"


//House 06
/area/mission/prefab/house/house_06
	name = "house 06"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_06/bathroom_01
	icon_state = "green"

/area/mission/prefab/house/house_06/bathroom_02
	icon_state = "green"

/area/mission/prefab/house/house_06/kitchen
	icon_state = "purple"

/area/mission/prefab/house/house_06/master_bedroom
	icon_state = "red"

/area/mission/prefab/house/house_06/guest_bedroom
	icon_state = "blue"


//House 07
/area/mission/prefab/house/house_07
	name = "house 07"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_07/bathroom_01
	icon_state = "green"

/area/mission/prefab/house/house_07/bathroom_02
	icon_state = "pink"

/area/mission/prefab/house/house_07/entrance
	icon_state = "purple"

/area/mission/prefab/house/house_07/master_bedroom
	icon_state = "red"

/area/mission/prefab/house/house_07/guest_bedroom
	icon_state = "blue"

/area/mission/prefab/house/house_07/living_area
	icon_state = "brown"



//House 08
/area/mission/prefab/house/house_08
	name = "house 08"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_08/bathroom
	icon_state = "green"

/area/mission/prefab/house/house_08/master_bedroom
	icon_state = "red"

/area/mission/prefab/house/house_08/entrance
	icon_state = "purple"

/area/mission/prefab/house/house_08/closet
	icon_state = "blue"




//davidthtthird house 01
/area/mission/prefab/house/house_D01
	name = "house D01"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_D01/bathroom
	icon_state = "blue"

/area/mission/prefab/house/house_D01/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_D01/main_hallway
	icon_state = "purple"

/area/mission/prefab/house/house_D01/bedroom01
	icon_state = "cyan"

/area/mission/prefab/house/house_D01/bedroom02
	icon_state = "pink"



	//davidthtthird house 02 homless person barracks
/area/mission/prefab/house/house_D02
	name = "house D02"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_D02/bathroom
	icon_state = "blue"

/area/mission/prefab/house/house_D02/kitchen
	icon_state = "green"

/area/mission/prefab/house/house_D02/hallway
	icon_state = "purple"

/area/mission/prefab/house/house_D02/officer_bedroom
	icon_state = "cyan"

/area/mission/prefab/house/house_D02/bunks
	icon_state = "pink"



		//davidthtthird house 03 "boxxed in"
/area/mission/prefab/house/house_D03
	name = "house D03"
	icon_state = "yellow"
	requires_power = TRUE
	link_to_parent_apc = TRUE
	interior = TRUE

/area/mission/prefab/house/house_D03/bathroom
	icon_state = "blue"

/area/mission/prefab/house/house_D03/sec
	icon_state = "green"

/area/mission/prefab/house/house_D03/engi
	icon_state = "purple"

/area/mission/prefab/house/house_D03/science
	icon_state = "cyan"

/area/mission/prefab/house/house_D03/hallway
	icon_state = "pink"

/area/mission/prefab/house/house_D03/command
	icon_state = "red"

/area/mission/prefab/house/house_D03/chapple
	icon_state = "brown"
