/obj/structure/interactive/enchantment_circle
	name = "circle of enchanting"
	icon = 'icons/obj/decal/enchanting_circle.dmi'
	icon_state = "0"

	anchored = TRUE
	density = TRUE

	plane = PLANE_FLOOR_ATTACHMENT

	value = 0

	pixel_x = -32
	pixel_y = -32

	listener = TRUE

	var/active = FALSE

	var/list/stored_items = list()
	var/obj/item/paper/book/enchanting/stored_book

	mouse_opacity = 2

/obj/structure/interactive/enchantment_circle/PreDestroy()
	set_active(FALSE)
	. = ..()

/obj/structure/interactive/enchantment_circle/Destroy()
	stored_book = null // Just in case.
	stored_items.Cut() // Just in case.
	. = ..()


/obj/structure/interactive/enchantment_circle/New(var/desired_loc)
	color = random_color()
	alpha = rand(200,255)
	return ..()

/obj/structure/interactive/enchantment_circle/proc/store_item(var/obj/item/I)
	if(!stored_book && istype(I,/obj/item/paper/book/enchanting/))
		stored_book = I
	stored_items += I
	HOOK_ADD("post_move","enchantment_sanity_\ref[src]",I,src,src::unstore_item())
	if(active)
		I.visible_message(span("notice","\The [I.name] glows faintly..."))
	return TRUE

/obj/structure/interactive/enchantment_circle/proc/unstore_item(var/obj/item/I)
	if(I == stored_book)
		stored_book = null
	stored_items -= I
	HOOK_REMOVE("post_move","enchantment_sanity_\ref[src]",I)
	if(active)
		src.set_active(FALSE)
		I.visible_message(span("warning","\The [I.name] stops glowing..."))
	return TRUE

/obj/structure/interactive/enchantment_circle/proc/set_active(var/desired_active=TRUE)

	if(active == desired_active)
		return FALSE

	active = desired_active

	if(active)
		var/list/found_contents = get_contents()
		var/obj/item/paper/book/enchanting/B = locate() in found_contents
		if(!B)
			set_active(FALSE)
			return FALSE
		for(var/k in found_contents)
			store_item(k)
		src.visible_message(span("notice","\The [src.name] brightens up and indicates it's ready for enchanting..."))
	else
		for(var/k in stored_items)
			unstore_item(k)
		src.visible_message(span("warning","\The [src.name] quietly fades..."))

	update_sprite()

	return TRUE

/obj/structure/interactive/enchantment_circle/update_icon()
	icon_state = "[active]"
	return ..()

/obj/structure/interactive/enchantment_circle/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	set_active(!active)

	caller.visible_message(span("notice","\The [caller.name] [active ? "activates" : "deactivates"] \the [src.name]."))

	return TRUE

/obj/structure/interactive/enchantment_circle/proc/get_contents()

	. = list()

	for(var/k in list(NORTH,EAST,SOUTH,WEST,0))
		var/turf/T = get_step(src,k)
		var/obj/item/I = locate() in T.contents
		if(I) . += I


/obj/structure/interactive/enchantment_circle/proc/try_enchant(var/mob/living/caller)

	var/obj/item/soulgem/soulgem = locate() in stored_items
	var/obj/item/weapon/weapon_to_enchant = locate() in stored_items

	if(weapon_to_enchant)
		if(weapon_to_enchant.enchantment_whitelist)
			if(!length(weapon_to_enchant.enchantment_whitelist) && !weapon_to_enchant.enchantment_whitelist[stored_book.stored_enchantment])
				weapon_to_enchant = null
		if(length(weapon_to_enchant.enchantment_blacklist))
			if(weapon_to_enchant.enchantment_blacklist[stored_book.stored_enchantment])
				weapon_to_enchant = null


	if(!soulgem || !soulgem.total_charge || !weapon_to_enchant || weapon_to_enchant.enchantment || !stored_book.stored_enchantment)
		caller.visible_message(span("warning","\The [src.name] reacts to [caller.name]'s words... but slowly fizzles out."),span("warning","\The [src.name] reacts to your words... but slowly fizzles out."))
		return FALSE

	caller.visible_message(span("danger","\The [src.name] reacts to [caller.name]'s words!"),span("warning","\The [src.name] reacts to your words!"))

	weapon_to_enchant.enchantment = new stored_book.stored_enchantment
	var/experience_to_give = weapon_to_enchant.enchantment.generate_stats(caller,weapon_to_enchant,soulgem)
	weapon_to_enchant.visible_message(span("notice","\The [weapon_to_enchant.name] shines brightly as it's new enchantment is applied."))
	caller.add_skill_xp(SKILL_SUMMONING,experience_to_give)
	if(soulgem.do_not_consume)
		soulgem.total_charge = 0
	else
		qdel(soulgem)
	qdel(stored_book)
	qdel(src)

	return TRUE



/obj/structure/interactive/enchantment_circle/on_listen(var/atom/speaker,var/datum/source,var/text,var/raw_text,var/language_text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(is_living(speaker) && active && stored_book && raw_text)

		var/language/L = SSlanguage.all_languages[LANGUAGE_LIZARD]

		var/converted_text = lowertext(raw_text)
		var/converted_enchanting_phrase = lowertext(stored_book.enchanting_phrase)
		var/converted_enchanting_translated = lowertext(L.process_text(speaker,converted_enchanting_phrase))

		if(converted_text == converted_enchanting_phrase || converted_text == converted_enchanting_translated)
			try_enchant(speaker)

	return ..()


