obj/item/clothing/back/storage/backpack/clown
	name = "clown's backpack"
	desc = "Lightweight and reliable!"
	desc_extended = "A small gear harness designed to carry a small amount of large items. Perfect for looters of the battlefield."

	icon = 'icons/obj/item/clothing/back/backpack/clown.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_4
	container_max_size = SIZE_4

	value = 160

obj/item/clothing/back/storage/backpack/clown/bag_of_bombs
	name = "clown's bag of bombs"
	desc = "Uh oh."
	desc_extended = "A suspicious backpack containing a near-endless supply of bombs which can be obtained when worn. A near-smudged out warning notes that the bombs come pre-lit."

	rarity = RARITY_MYTHICAL

	size = MAX_INVENTORY_X*2*SIZE_3

	dynamic_inventory_count = 0

	var/next_bomb = 0

obj/item/clothing/back/storage/backpack/clown/bag_of_bombs/get_base_value()
	. = ..()
	. += 5000

obj/item/clothing/back/storage/backpack/clown/bag_of_bombs/click_self(var/mob/activator,location,control,params)

	if(is_advanced(activator))
		var/mob/living/advanced/L = activator
		var/obj/hud/inventory/I = src.loc
		var/turf/T = get_turf(src)
		if(T && I.worn)
			INTERACT_CHECK
			INTERACT_DELAY(5)
			if(next_bomb >= world.time)
				activator.to_chat(span("notice","\The [src.name] is recharging, please wait!"))
				return TRUE
			next_bomb = world.time + SECONDS_TO_DECISECONDS(4)
			var/obj/item/slime_bomb/SB = new(T)
			SB.owner = activator
			SB.loyalty_tag = L.loyalty_tag
			INITIALIZE(SB)
			GENERATE(SB)
			FINALIZE(SB)
			SB.light()
			L.visible_message(span("warning","\The [L.name] pulls a lit [SB.name] out of \the [src.name]!"),span("warning","You pull a lit [SB.name] out of \the [src.name]!"))
			L.put_in_hands(SB,params)
			return TRUE

	. = ..()



