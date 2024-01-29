/obj/item/soulgem
	name = "bluespace gem"
	desc = "Holds the souls of lesser beings. Not to be confused with bluespace crystals."
	desc_extended = "Used in enchanting items or refilling the magic of staves."
	icon = 'icons/obj/item/soulgem.dmi'
	icon_state = "common"

	var/total_charge = 0
	var/total_capacity = 0
	var/do_not_consume = FALSE //Does this get consumed? Or merely emptied on craft. Only used for Azuras Star

	value = 100 //Dummy value. Calculated later.

	weight = 1

	rarity = RARITY_COMMON



/obj/item/soulgem/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("total_charge")

/obj/item/soulgem/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("total_charge")

/obj/item/soulgem/Finalize()
	. = ..()

	if(!total_capacity)
		if(total_charge)
			total_capacity = total_charge
		else
			total_capacity = SOUL_SIZE_COMMON

	update_sprite()

/obj/item/soulgem/get_base_value()
	. = ..()
	. += (total_capacity/32)**1.5
	. = CEILING(.,1)

/obj/item/soulgem/get_value()
	. = ..()
	. += (total_charge/16)**1.5
	. = CEILING(.,1)

/obj/item/soulgem/get_examine_list(mob/caller)
	return ..() + span("notice","It has [total_charge] total charge.")

/obj/item/soulgem/update_sprite()
	. = ..()
	name = initial(name)
	icon = initial(icon)
	if(do_not_consume)
		name = "unbreaking [name]"
		icon_state = "azuras"
		rarity = RARITY_LEGENDARY
	else
		switch(total_capacity)
			if(0 to SOUL_SIZE_COMMON)
				name = "common [name]"
				icon_state = "common"
				rarity = RARITY_COMMON
			if(SOUL_SIZE_COMMON to SOUL_SIZE_UNCOMMON)
				name = "uncommon [name]"
				icon_state = "uncommon"
				rarity = RARITY_UNCOMMON
			if(SOUL_SIZE_UNCOMMON to SOUL_SIZE_RARE)
				name = "rare [name]"
				icon_state = "rare"
				rarity = RARITY_RARE
			if(SOUL_SIZE_RARE to SOUL_SIZE_MYSTIC)
				name = "mystic [name]"
				icon_state = "mystic"
				rarity = RARITY_MYTHICAL
			if(SOUL_SIZE_MYSTIC to INFINITY)
				name = "godly [name]"
				icon_state = "godly"
				rarity = RARITY_LEGENDARY
	if(total_charge > 0)
		switch(total_charge)
			if(0 to SOUL_SIZE_COMMON)
				name = "[name] (common)"
			if(SOUL_SIZE_COMMON to SOUL_SIZE_UNCOMMON)
				name = "[name] (uncommon)"
			if(SOUL_SIZE_UNCOMMON to SOUL_SIZE_RARE)
				name = "[name] (rare)"
			if(SOUL_SIZE_RARE to SOUL_SIZE_MYSTIC)
				name = "[name] (mystic)"
			if(SOUL_SIZE_MYSTIC to INFINITY)
				name = "[name] (godly)"
		icon_state = "[icon_state]_1"
	else
		name = "[name] (empty)"



/obj/item/soulgem/click_on_object(mob/caller as mob,atom/object,location,control,params)

	if(istype(object,/obj/effect/temp/soul))
		if(total_charge != 0)
			caller.to_chat(span("warning","You need an empty soul gem in order to capture souls!"))
			return TRUE

		var/obj/effect/temp/soul/S = object
		if(S.qdeleting || !S.soul_size)
			return TRUE

		total_charge = min(S.soul_size,total_capacity)
		caller.visible_message(span("danger","\The [caller.name] traps \the [S.name] with \the [src.name]!"),span("warning","You trap \the [S.name] with \the [src.name]!"))
		if(is_living(caller))
			var/mob/living/L = caller
			L.add_skill_xp(SKILL_SUMMONING,CEILING(S.soul_size*0.01,1))
		qdel(S)
		update_sprite()

		return TRUE

	if(istype(object,/obj/item/weapon/ranged/magic/staff/))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		var/obj/item/weapon/ranged/magic/staff/S = object
		if(total_charge)
			caller.visible_message(span("notice","\The [caller.name] recharges \the [S.name] with \the [src.name]."),span("notice","You charge \the [S] with \the [src]."))
			S.total_charge += total_charge
			total_charge -= total_charge
			if(is_living(caller))
				var/mob/living/L = caller
				L.add_skill_xp(SKILL_SUMMONING,CEILING(total_charge*0.0025,1))
			if(!do_not_consume && total_charge <= 0)
				caller.to_chat(span("warning","\The [src] shatters!"))
				qdel(src)
		else
			caller.to_chat(span("warning","\The [src] is empty!"))
		update_sprite()

		return TRUE

	return ..()


/obj/item/soulgem/common
	total_capacity = SOUL_SIZE_COMMON

/obj/item/soulgem/common/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/uncommon
	total_capacity = SOUL_SIZE_UNCOMMON

/obj/item/soulgem/uncommon/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/rare
	total_capacity = SOUL_SIZE_RARE

/obj/item/soulgem/rare/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/mystic
	total_capacity = SOUL_SIZE_MYSTIC

/obj/item/soulgem/mystic/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/godly
	total_capacity = SOUL_SIZE_GODLY
	value_burgerbux = 1

/obj/item/soulgem/godly/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/azuras_star
	total_capacity = SOUL_SIZE_MYSTIC
	do_not_consume = TRUE
