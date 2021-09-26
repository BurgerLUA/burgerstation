/obj/item/powergem
	name = "power gem"
	desc = "A gem filled with power."
	desc_extended = "A special gem used for augmenting magic weapons with damage bonuses. Click on the magic weapon to apply it. Can be removed with a crowbar."
	rarity = RARITY_COMMON

	icon = 'icons/obj/item/powergem.dmi'
	icon_state = "gem1"

	var/damage_type_to_add = ARCANE
	var/damage_to_add = 10

	value = 1000

	value_burgerbux = 1 //Not in rotation, yet.

/obj/item/powergem/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("rarity")
	SAVEVAR("icon_state")
	SAVEVAR("damage_type_to_add")
	SAVEVAR("damage_to_add")

/obj/item/powergem/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("rarity")
	LOADVAR("icon_state")
	LOADVAR("damage_type_to_add")
	LOADVAR("damage_to_add")

/obj/item/powergem/Generate()

	icon_state = "gem[rand(1,5)]"

	damage_type_to_add = pick(ALL_DAMAGE - list(BLADE,BLUNT,PIERCE))
	rarity = pickweight(
		list(
			RARITY_COMMON = 100,
			RARITY_UNCOMMON = 50,
			RARITY_RARE = 25,
			RARITY_MYTHICAL = 12,
			RARITY_LEGENDARY = 6
		)
	)

	switch(rarity)
		if(RARITY_BROKEN)
			damage_to_add = rand(-20,-10)
		if(RARITY_COMMON)
			damage_to_add = rand(4,8)
		if(RARITY_UNCOMMON)
			damage_to_add = rand(9,14)
		if(RARITY_RARE)
			damage_to_add = rand(15,20)
		if(RARITY_MYTHICAL)
			damage_to_add = rand(21,29)
		if(RARITY_LEGENDARY)
			damage_to_add = rand(30,50)

	return ..()

/obj/item/powergem/get_examine_list(var/mob/examiner)

	. = ..()

	. += span("notice","Adds [damage_to_add] [damage_type_to_add] damage to attacks.")


/obj/item/powergem/Finalize()

	name = "[rarity] power gem of [damage_type_to_add]"

	var/damage_to_color = list(
		LASER = COLOR_RED,
		ARCANE = COLOR_PURPLE,
		HEAT = COLOR_ORANGE,
		COLD = COLOR_CYAN,
		SHOCK = COLOR_BLUE,
		BOMB = COLOR_BROWN,
		BIO = "#92CC00",
		RAD = COLOR_GREEN,
		HOLY = COLOR_YELLOW,
		DARK = COLOR_BLOOD,
		FATIGUE = "#00FF00",
		PAIN = COLOR_WHITE,
		ION = "#0094FF",
		SANITY = COLOR_GREY_DARK
	)

	if(damage_type_to_add) color = damage_to_color[damage_type_to_add]

	var/glow_mod = clamp((damage_to_add/40)*TILE_SIZE*0.5,2,TILE_SIZE*0.5)
	var/glow_color = "#FFFFFF"

	switch(rarity)
		if(RARITY_UNCOMMON)
			glow_color = COLOR_UNCOMMON
		if(RARITY_RARE)
			glow_color = COLOR_RARE
		if(RARITY_MYTHICAL)
			glow_color = COLOR_MYTHICAL
		if(RARITY_LEGENDARY)
			glow_color = COLOR_LEGENDARY

	if(glow_mod > 0 && glow_color != "#FFFFFF")
		filters += filter(type="drop_shadow",x=0,y=0,size=glow_mod,offset=4,color=glow_color)

	// https://www.desmos.com/calculator/6ldvbumkps
	value = 1000 + (max(5,damage_to_add)**2.3)*2

	return ..()

/obj/item/powergem/update_overlays()
	. = ..()
	var/image/I = new(icon,icon_state)
	I.appearance_flags = src.appearance_flags
	I.blend_mode = BLEND_ADD
	I.plane = PLANE_LIGHTING
	add_overlay(I)
