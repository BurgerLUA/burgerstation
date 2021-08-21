/obj/structure/interactive/plant/nitrogen_flower
	plant_type = /plant_type/nitrogen_flower
	icon_state = "nitrogen_flower"

	potency = 20
	yield_max = 1
	growth_speed = 0.5

/obj/structure/interactive/plant/oxygen_fruit
	plant_type = /plant_type/oxygen_fruit
	icon_state = "oxygen_fruit"

	potency = 20
	yield_max = 1
	growth_speed = 0.5

/obj/structure/interactive/plant/wheat
	plant_type = /plant_type/wheat
	icon_state = "wheat"

	potency = 10
	yield_max = 4
	growth_speed = 0.2

/obj/structure/interactive/plant/sugarcane
	plant_type = /plant_type/sugarcane
	icon_state = "sugarcane"

	potency = 5
	yield_max = 3
	growth_speed = 0.5

/obj/structure/interactive/plant/liberty_cap
	plant_type = /plant_type/liberty_cap
	icon_state = "liberty_cap"

	potency = 20
	yield_max = 2
	growth_speed = 0.2

/obj/structure/interactive/plant/chanterelle
	plant_type = /plant_type/chanterelle
	icon_state = "chanterelle"

	potency = 20
	yield_max = 2
	growth_speed = 0.4

/obj/structure/interactive/plant/destroying_angel
	plant_type = /plant_type/destroying_angel
	icon_state = "destroying_angel"

	potency = 20
	yield_max = 2
	growth_speed = 0.1

/obj/structure/interactive/plant/fly_amanita
	plant_type = /plant_type/fly_amanita
	icon_state = "fly_amanita"

	potency = 20
	yield_max = 2
	growth_speed = 0.2

/obj/structure/interactive/plant/glowshroom
	plant_type = /plant_type/glowshroom
	icon_state = "glowshroom"

	potency = 20
	yield_max = 2
	growth_speed = 0.2

/obj/structure/interactive/plant/glowshroom/Initialize()
	set_light(2,0.25,"#00FF00")
	return ..()


/obj/structure/interactive/plant/tomato
	plant_type = /plant_type/tomato
	icon_state = "tomato"

	potency = 20
	yield_max = 7
	growth_speed = 0.4

	growth_max = 50
	delete_after_harvest = FALSE

/obj/structure/interactive/plant/corn
	plant_type = /plant_type/corn
	icon_state = "corn"

	potency = 8
	yield_max = 7
	growth_speed = 0.2

	growth_max = 50
	delete_after_harvest = FALSE

/obj/structure/interactive/plant/cabbage
	plant_type = /plant_type/cabbage
	icon_state = "cabbage"

	potency = 10
	yield_max = 1
	growth_speed = 0.5

/obj/structure/interactive/plant/cannabis
	plant_type = /plant_type/cannabis
	icon_state = "cannabis"

	potency = 20
	yield_max = 2
	growth_speed = 0.2

/obj/structure/interactive/plant/cannabis/life
	plant_type = /plant_type/cannabis/life
	icon_state = "whitecannabis"

/obj/structure/interactive/plant/cannabis/death
	plant_type = /plant_type/cannabis/death
	icon_state = "blackcannabis"


/obj/structure/interactive/plant/cactus_fruit
	plant_type = /plant_type/cactus_fruit
	icon_state = "cactus"

	potency = 40
	yield_max = 1
	growth_speed = 0.2


/obj/structure/interactive/plant/polypore_mushroom
	plant_type = /plant_type/polypore_mushroom
	icon_state = "polypore"

	potency = 20
	yield_max = 5
	growth_speed = 0.5

	growth_max = 50
	delete_after_harvest = FALSE

/obj/structure/interactive/plant/porcini_mushroom
	plant_type = /plant_type/porcini_mushroom
	icon_state = "porcini"

	potency = 15
	yield_max = 4
	growth_speed = 0.9

	growth_max = 50
	delete_after_harvest = FALSE


/obj/structure/interactive/plant/inocybe_mushroom
	plant_type = /plant_type/inocybe_mushroom
	icon_state = "inocybe"

	potency = 15
	yield_max = 5
	growth_speed = 0.4

	growth_max = 50
	delete_after_harvest = FALSE

/obj/structure/interactive/plant/embershroom_mushroom
	plant_type = /plant_type/embershroom_mushrrom
	icon_state = "ember"

	potency = 10
	yield_max = 7
	growth_speed = 0.4
