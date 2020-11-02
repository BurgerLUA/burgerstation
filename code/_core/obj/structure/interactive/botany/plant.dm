/obj/structure/interactive/plant/nitrogen_flower
	plant_type = /plant_type/nitrogen_flower
	icon_state = "nitrogen_flower"

	potency = 20
	yield = 1
	growth_speed = 5
	growth_min = 0

/obj/structure/interactive/plant/oxygen_fruit
	plant_type = /plant_type/oxygen_fruit
	icon_state = "oxygen_fruit"

	potency = 20
	yield = 1
	growth_speed = 5


/obj/structure/interactive/plant/wheat
	plant_type = /plant_type/wheat
	icon_state = "wheat"

	potency = 10
	yield = 4
	growth_speed = 6
	growth_min = 0


/obj/structure/interactive/plant/sugarcane
	plant_type = /plant_type/sugarcane
	icon_state = "sugarcane"

	potency = 5
	yield = 3
	growth_speed = 5
	growth_min = 0


/obj/structure/interactive/plant/liberty_cap
	plant_type = /plant_type/liberty_cap
	icon_state = "liberty_cap"

	potency = 20
	yield = 2
	growth_speed = 2
	growth_min = 0

/obj/structure/interactive/plant/chanterelle
	plant_type = /plant_type/chanterelle
	icon_state = "chanterelle"

	potency = 20
	yield = 2
	growth_speed = 4
	growth_min = 0


/obj/structure/interactive/plant/destroying_angel
	plant_type = /plant_type/destroying_angel
	icon_state = "destroying_angel"

	potency = 20
	yield = 2
	growth_speed = 1
	growth_min = 0

/obj/structure/interactive/plant/fly_amanita
	plant_type = /plant_type/fly_amanita
	icon_state = "fly_amanita"

	potency = 20
	yield = 2
	growth_speed = 4
	growth_min = 0

/obj/structure/interactive/plant/glowshroom
	plant_type = /plant_type/glowshroom
	icon_state = "glowshroom"

	potency = 20
	yield = 2
	growth_speed = 2
	growth_min = 0

/obj/structure/interactive/plant/glowshroom/Initialize()
	set_light(2,0.25,"#00FF00")
	return ..()


/obj/structure/interactive/plant/tomato
	plant_type = /plant_type/tomato
	icon_state = "tomato"

	potency = 20
	yield = 7
	growth_speed = 4
	growth_min = 75

	delete_after_harvest = FALSE

/obj/structure/interactive/plant/cabbage
	plant_type = /plant_type/cabbage
	icon_state = "cabbage"

	potency = 10
	yield = 1
	growth_speed = 5
	growth_min = 0