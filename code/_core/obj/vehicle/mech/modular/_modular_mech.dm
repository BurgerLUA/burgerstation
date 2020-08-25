var/global/list/stored_mechs_by_ckey = list()

/proc/save_all_mechs() //Should only be done at the end of the round.

	for(var/ckey in stored_mechs_by_ckey)
		LOG_DEBUG("Checking stored mechs for [ckey]...")
		var/savedata/client/mob/M = MOBDATA(ckey)
		if(!M)
			log_error("ERROR: Mech Saving: Could not find mobdata for ckey [ckey]!")
			continue
		if(!M.loaded_data["stored_mechs"])
			M.loaded_data["stored_mechs"] = list()
		try
			for(var/mob/living/vehicle/mech/modular/V in stored_mechs_by_ckey[ckey])
				LOG_DEBUG("Mech Saving: Found mech [V.get_debug_name()].")
				if(V.qdeleting)
					M.loaded_data["stored_mechs"] -= V.mech_id //Gone forever.
				else
					M.loaded_data["stored_mechs"][V.mech_id] = V.save_mech_data()
					LOG_DEBUG("Storing mech. Data length: [length(M.loaded_data["stored_mechs"][V.mech_id])]")
		catch(var/exception/e)
			log_error("save_all_mechs(): [e] on [e.file]:[e.line]!")

	return TRUE

/mob/living/vehicle/mech/modular
	name = "modular mech"
	icon = 'icons/mob/living/advanced/mecha/parts.dmi'
	icon_state = "backbone"

	var/obj/item/mech_part/arms/mech_arms
	var/obj/item/mech_part/legs/mech_legs
	var/obj/item/mech_part/body/mech_body
	var/obj/item/mech_part/head/mech_head

	var/owner_ckey //The owner of this mech.
	var/mech_id //The unique ID of the mech.

	pixel_x = -8

	value = 500

	armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY,
		ION = -100
	)

	class = /class/gygax/

	health = /health/mob/living/vehicle/mech/modular

	health_base = 500

	movement_delay = DECISECONDS_TO_TICKS(4)


/mob/living/vehicle/mech/modular/PostInitialize()

	. = ..()

	if(owner_ckey)
		if(!stored_mechs_by_ckey[owner_ckey])
			stored_mechs_by_ckey[owner_ckey] = list()
		stored_mechs_by_ckey[owner_ckey] += src

	return .

/mob/living/vehicle/mech/modular/proc/generate_name()
	name = "Mech Unit [uppertext(copytext(owner_ckey,1,4))]-[uppertext(copytext(mech_id,1,4))]"

/mob/living/vehicle/mech/modular/proc/generate_id()
	mech_id = rustg_hash_string(RUSTG_HASH_MD5,"[get_date()][get_time()]")
	return TRUE

/mob/living/vehicle/mech/modular/proc/set_owner(var/desired_ckey)

	if(owner_ckey && stored_mechs_by_ckey[owner_ckey])
		stored_mechs_by_ckey[owner_ckey] -= src

	if(!stored_mechs_by_ckey[desired_ckey])
		stored_mechs_by_ckey[desired_ckey] = list()

	owner_ckey = desired_ckey
	stored_mechs_by_ckey[desired_ckey] |= src

	return TRUE

/mob/living/vehicle/mech/modular/proc/save_mech_data(var/save_inventory = TRUE)

	. = list()

	SAVEVAR("name")
	SAVEVAR("mech_id")
	SAVEATOM("mech_arms")
	SAVEATOM("mech_legs")
	SAVEATOM("mech_body")
	SAVEATOM("mech_head")

	return .

/mob/living/vehicle/mech/modular/proc/load_mech_data(var/mob/living/advanced/player/P,var/list/object_data)

	. = list()

	LOADVAR("name")
	LOADVAR("mech_id")
	LOADATOM("mech_arms")
	LOADATOM("mech_legs")
	LOADATOM("mech_body")
	LOADATOM("mech_head")

	update_sprite()

	return .

/mob/living/vehicle/mech/modular/can_attach_weapon(var/mob/caller,var/obj/item/I)

	if(!mech_arms)
		caller?.to_chat(span("notice","You must add a set of arms to this assembly before attaching weapons!"))
		return FALSE

	return ..()

/mob/living/vehicle/mech/modular/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)


	var/atom/A = object.defer_click_on_object(location,control,params)

	if(is_item(object) && is_living(caller))
		var/mob/living/L = caller
		if(L.intent == INTENT_HARM)
			return ..()
		if(length(passengers))
			return ..()
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WRENCH)
			INTERACT_CHECK
			if(mech_head)
				caller?.to_chat(span("notice","You remove \the [mech_head.name] from \the [src.name]."))
				mech_head.drop_item(get_turf(src))
				if(caller) mech_head.force_move(get_turf(caller))
				mech_head = null
				update_sprite()
			else if(mech_arms)
				caller?.to_chat(span("notice","You remove \the [mech_arms.name] from \the [src.name]."))
				mech_arms.drop_item(get_turf(src))
				if(caller) mech_arms.force_move(get_turf(caller))
				mech_arms = null
				update_sprite()
			else if(mech_body)
				caller?.to_chat(span("notice","You remove \the [mech_body.name] from \the [src.name]."))
				mech_body.drop_item(get_turf(src))
				if(caller) mech_body.force_move(get_turf(caller))
				mech_body = null
				update_sprite()
			else if(mech_legs)
				caller?.to_chat(span("notice","You remove \the [mech_legs.name] from \the [src.name]."))
				mech_legs.drop_item(get_turf(src))
				if(caller) mech_legs.force_move(get_turf(caller))
				mech_legs = null
				update_sprite()
			else
				caller?.to_chat(span("notice","There is nothing to remove from \the [src.name]!"))

			return TRUE

		if(istype(A,/obj/item/mech_part/))
			INTERACT_CHECK
			. = FALSE
			if(istype(I,/obj/item/mech_part/arms))
				if(!mech_arms)
					if(!mech_body)
						caller?.to_chat(span("notice","You must add a mech body to this assembly before attaching \the [I.name]!"))
						return TRUE
					mech_arms = I
					. = TRUE
			if(istype(I,/obj/item/mech_part/legs))
				if(!mech_legs)
					mech_legs = I
					. = TRUE
			if(istype(I,/obj/item/mech_part/body))
				if(!mech_body)
					if(!mech_legs)
						caller?.to_chat(span("notice","You must add mech legs to this assembly before attaching \the [I.name]!"))
						return TRUE
					mech_body = I
					. = TRUE
			if(istype(I,/obj/item/mech_part/head))
				if(!mech_head)
					if(!mech_body)
						caller?.to_chat(span("notice","You must add a mech body to this assembly before attaching \the [I.name]!"))
						return TRUE
					mech_head = I
					. = TRUE
			if(.)
				I.drop_item(src)
				I.update_sprite()
				caller?.to_chat(span("notice","You insert \the [I.name] into \the [src.name]."))
				update_sprite()
				return TRUE

	return ..()

/mob/living/vehicle/mech/modular/update_overlays()
	. = ..()

	if(mech_legs) add_overlay(mech_legs)
	if(mech_body) add_overlay(mech_body)
	if(mech_arms) add_overlay(mech_arms)
	if(mech_head) add_overlay(mech_head)

	if(length(equipment) >= 1 && istype(equipment[1],/obj/item/weapon/ranged/energy/mech))
		var/image/I = new/image(equipment[1].icon_attached,"[equipment[1].icon_state_attached]_right hand")
		add_overlay(I)

	if(length(equipment) >= 2 && istype(equipment[2],/obj/item/weapon/ranged/energy/mech))
		var/image/I = new/image(equipment[2].icon_attached,"[equipment[2].icon_state_attached]_left hand")
		add_overlay(I)

	return .

/mob/living/vehicle/mech/modular/update_icon()

	. = ..()

	if(mech_body)
		icon_state = "none"
	else
		icon_state = "backbone"
		set_dir(SOUTH)

	return .

/mob/living/vehicle/mech/modular/set_dir(var/desired_dir,var/force=FALSE)

	if(!mech_body)
		dir = SOUTH
		return TRUE

	return ..()


/mob/living/vehicle/mech/modular/get_object_to_damage(var/atom/attacker,var/atom/weapon,var/list/params = list(),var/accurate=FALSE,var/find_closest=FALSE,var/inaccuracy_modifier=1)

	if(!length(params))
		params = list(PARAM_ICON_X = num2text(rand(0,32)),PARAM_ICON_Y = num2text(rand(0,32)))

	var/x_attack = text2num(params[PARAM_ICON_X])
	var/y_attack = text2num(params[PARAM_ICON_Y])

	if(!accurate && is_living(attacker) && attacker != src)
		var/inaccuracy = !weapon ? 0 : weapon.get_inaccuracy(attacker,src,inaccuracy_modifier)
		x_attack = clamp(x_attack + rand(-inaccuracy,inaccuracy),0,32)
		y_attack = clamp(y_attack + rand(-inaccuracy,inaccuracy),0,32)

	if(mech_arms && (x_attack < 12 || x_attack > 16) && y_attack > 12 && y_attack < 23)
		return mech_arms

	if(mech_legs && y_attack < 13)
		return mech_legs

	if(mech_head && y_attack > 24)
		return mech_head

	if(mech_body)
		return mech_body

	return src


/mob/living/vehicle/mech/modular/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!mech_arms || mech_arms.health.health_current <= 0)
		return FALSE

	return ..()

/mob/living/vehicle/mech/modular/handle_movement(var/adjust_delay = 0)

	if(!mech_legs || mech_legs.health.health_current <= 0)
		return FALSE

	return ..()