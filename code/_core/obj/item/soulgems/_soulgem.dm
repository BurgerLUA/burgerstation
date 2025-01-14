/obj/item/soulgem
	name = "bluespace gem"
	desc = "Holds the souls of lesser beings. Not to be confused with bluespace crystals."
	desc_extended = "Used in enchanting items or refilling the magic of staves."
	icon = 'icons/obj/item/soulgem.dmi'
	icon_state = "common"

	var/total_charge = 0
	var/total_capacity = 0
	var/do_not_consume = FALSE //Does this get consumed? Or merely emptied on craft. Only used for Azuras Star

	weight = 1

	rarity = RARITY_COMMON

	var/mob/living/stored_soul_path
	var/soul_gives_xp = TRUE

/obj/item/soulgem/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("total_charge")
	SAVEVAR("soul_gives_xp")
	SAVEPATH("stored_soul_path")

/obj/item/soulgem/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("total_charge")
	LOADVAR("soul_gives_xp")
	LOADPATH("stored_soul_path")

/obj/item/soulgem/Finalize()
	. = ..()

	if(!total_capacity) //In case of errors.
		if(total_charge)
			total_capacity = total_charge
		else
			total_capacity = SOUL_SIZE_COMMON

	update_sprite()

//https://www.desmos.com/calculator/vjla2nxgnn

/obj/item/soulgem/get_base_value()
	. = ..()
	. = (300 + (total_capacity * ( 100 / (SOUL_SIZE_GODLY+300) ))**2)
	. = CEILING(.,500)
	if(do_not_consume)
		. *= 3

/obj/item/soulgem/get_value()
	. = ..()
	. = (300 + (total_charge * ( 100 / (SOUL_SIZE_GODLY+300) ))**2)*2
	. = CEILING(.,1)

/obj/item/soulgem/get_examine_list(var/mob/caller)
	. = ..()
	. += span("notice","It has a soul worth [total_charge] total charge.")
	if(total_charge)
		if(stored_soul_path)
			. += span("notice","Throwing this will [do_not_consume ? "" : "shatter the gem and "]release \a [initial(stored_soul_path.name)] under your control.")
			. += span("notice","Souls can be recaptured using soul gems, with no penalty.")
		else
			. += span("warning","While it is charged, it does not have a complete soul inside, and will not release a minion when thrown.")

/obj/item/soulgem/on_thrown(var/atom/owner,var/atom/hit_atom) //What happens after the soulgem is thrown and it hits an object.

	. = ..()

	if(is_living(owner) && total_charge > 0 && hit_atom && stored_soul_path)
		var/mob/living/master = owner
		var/turf/T = is_turf(hit_atom) ? hit_atom : get_turf(hit_atom)
		if(T)
			var/mob/living/mob_to_spawn = stored_soul_path
			mob_to_spawn = new mob_to_spawn(T)
			mob_to_spawn.soul_size = total_charge
			src.total_charge = 0
			src.stored_soul_path = null
			INITIALIZE(mob_to_spawn)
			GENERATE(mob_to_spawn)
			master.add_minion(mob_to_spawn)
			FINALIZE(mob_to_spawn)
			if(master.ckey)
				master.add_skill_xp(SKILL_SUMMONING,CEILING(mob_to_spawn.soul_size*0.02,1))
			if(do_not_consume)
				mob_to_spawn.visible_message(span("notice","\The [src.name] vanishes, releasing [mob_to_spawn.name]!"))
				if(is_advanced(master))
					var/mob/living/advanced/A = master
					src.quick_equip(A,ignore_worn=TRUE,ignore_dynamic=TRUE,silent=TRUE)
				update_sprite()
			else
				mob_to_spawn.visible_message(span("notice","\The [src.name] shatters, releasing [mob_to_spawn.name]!"))
				qdel(src)



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



/obj/item/soulgem/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	//Capture Minions
	if(is_living(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		var/mob/living/L = object
		if(L.minion_master != caller)
			return TRUE
		if(L.qdeleting)
			return TRUE
		if(total_charge != 0)
			caller.to_chat(span("warning","You need an empty soul gem in order to capture souls!"))
			return TRUE
		if(initial(L.soul_size) > src.total_capacity)
			caller.to_chat(span("warning","This soul is too large to be contained in \the [src.name]!"))
			return TRUE
		total_charge = min(L.soul_size,total_capacity)
		stored_soul_path = L.type
		soul_gives_xp = FALSE
		qdel(L)
		update_sprite()
		return TRUE

	//Capture Souls
	if(istype(object,/obj/effect/temp/soul))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		if(total_charge != 0)
			caller.to_chat(span("warning","You need an empty soul gem in order to capture souls!"))
			return TRUE

		var/obj/effect/temp/soul/S = object
		if(S.qdeleting || !S.soul_size)
			return TRUE

		if(S.soul_size > src.total_capacity)
			caller.to_chat(span("warning","This soul is too large to be contained in \the [src.name]!"))
			return TRUE

		total_charge = min(S.soul_size,total_capacity)
		caller.visible_message(span("danger","\The [caller.name] traps \the [S.name] with \the [src.name]!"),span("warning","You trap \the [S.name] with \the [src.name]!"))
		if(is_living(caller))
			var/mob/living/L = caller
			L.add_skill_xp(SKILL_SUMMONING,CEILING(S.soul_size*0.01,1))
		stored_soul_path = S.soul_path
		soul_gives_xp = TRUE
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
			if(soul_gives_xp && is_living(caller))
				var/mob/living/L = caller
				L.add_skill_xp(SKILL_SUMMONING,CEILING(total_charge*0.0025,1))
			if(!do_not_consume && total_charge <= 0)
				caller.to_chat(span("warning","\The [src] shatters!"))
				qdel(src)
			else
				stored_soul_path = null
		else
			caller.to_chat(span("warning","\The [src] is empty!"))
		update_sprite()

		return TRUE

	return ..()


/obj/item/soulgem/common
	total_capacity = SOUL_SIZE_COMMON
	value = 1

/obj/item/soulgem/common/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/uncommon
	total_capacity = SOUL_SIZE_UNCOMMON
	value = 1

/obj/item/soulgem/uncommon/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/rare
	total_capacity = SOUL_SIZE_RARE
	value = 1

/obj/item/soulgem/rare/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/mystic
	total_capacity = SOUL_SIZE_MYSTIC
	value = 1

/obj/item/soulgem/mystic/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/godly
	total_capacity = SOUL_SIZE_GODLY
	value = 1

/obj/item/soulgem/godly/filled/Generate()
	. = ..()
	total_charge = total_capacity

/obj/item/soulgem/azuras_star
	total_capacity = SOUL_SIZE_MYSTIC
	do_not_consume = TRUE
	value_burgerbux = 1
	value = 1
