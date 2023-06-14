/obj/item/deployable
	name = "deployable structure"
	desc = "Quick and fast deployment."
	desc_extended = "Deploys a structure."
	var/obj/structure/structure_to_deploy //Store as a type. This should always be a structure.

	amount_max = 10
	amount_max_icon = 3

/obj/item/deployable/proc/get_deploy_time(var/mob/caller)
	return SECONDS_TO_DECISECONDS(3)

/obj/item/deployable/proc/pre_deploy(var/mob/caller,var/turf/T,var/obj/structure/S)
	S.dir = caller.dir
	INITIALIZE(S)
	FINALIZE(S)
	return TRUE

/obj/item/deployable/proc/post_deploy(var/mob/caller,var/turf/T,var/obj/structure/S)
	caller.visible_message(span("notice","\The [caller.name] deploys \the [S.name]."),span("notice","You deploy \the [S.name]."))
	return TRUE

/obj/item/deployable/proc/deploy(var/mob/caller,var/turf/T)

	var/obj/structure/S = new structure_to_deploy(T)
	pre_deploy(caller,T,S)
	post_deploy(caller,T,S)
	add_item_count(-1)

	return S

/obj/item/deployable/proc/can_deploy_to(var/mob/caller,var/turf/T)

	if(amount <= 0)
		qdel(src)
		return FALSE

	return T.can_construct_on(caller,structure_to_deploy)

/obj/item/deployable/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/turf/T = get_turf(object)

	if(can_deploy_to(caller,T))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(caller.loc != T)
			caller.face_atom(T) //Only face the atom if we're not on the tile.
		caller.visible_message(span("warning","\The [caller.name] starts to deploy \the [src.name]..."),span("notice","You start to deploy \the [src.name]..."))
		PROGRESS_BAR(caller,src,get_deploy_time(caller),src::deploy(),caller,T)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_deploy_to(),caller,T)
		return TRUE

	return ..()

/obj/item/deployable/barricade
	name = "deployable barricade"
	desc = "Your main source of protection."
	desc_extended = "A large deployable barricade."
	structure_to_deploy = /obj/structure/interactive/barricade/
	icon = 'icons/obj/item/deployable/barricade.dmi'
	value = 60

	weight = 10

	amount_max = 5

	size = SIZE_3

/obj/item/deployable/mountable/browning
	name = "field browning kit"
	desc = "WW2 warfare."
	desc_extended = "An old-fashioned field kit that lets you set up your very own Browning heavy machinegun, for all the suppressive fire you will ever need. It seems the mount can only turn so far..."
	structure_to_deploy = /obj/structure/interactive/mountable/browning/
	icon = 'icons/obj/item/deployable/browning.dmi'
	dan_mode = TRUE
	dan_icon_state_back = "back"
	value = 8918
	weight = 58

	amount_max = 1

	size = SIZE_9

/obj/item/deployable/mountable/browning/get_deploy_time(var/mob/caller)
	return SECONDS_TO_DECISECONDS(10)

/obj/item/deployable/mob
	var/mob/living/mob_to_deploy

/obj/item/deployable/mob/can_deploy_to(var/mob/caller,var/turf/T)

	if(amount <= 0)
		qdel(src)
		return FALSE

	if(get_dist(caller,T) > 1)
		return FALSE

	var/mob/living/L = locate() in T.contents
	if(L)
		caller.to_chat(span("warning","\The [L.name] is in the way!"))
		return FALSE

	return TRUE

/obj/item/deployable/mob/pre_deploy(var/mob/caller,var/turf/T,var/mob/living/L)
	L.dir = caller.dir
	INITIALIZE(L)
	FINALIZE(L)
	return TRUE

/obj/item/deployable/mob/post_deploy(var/mob/caller,var/turf/T,var/mob/living/L)
	caller.visible_message(span("notice","\The [caller.name] deploys \the [L.name]."),span("notice","You deploy \the [L.name]."))
	return TRUE

/obj/item/deployable/mob/deploy(var/mob/caller,var/turf/T)
	var/mob/living/L = new mob_to_deploy(T)
	pre_deploy(caller,T,L)
	post_deploy(caller,T,L)
	add_item_count(-1)
	return L

/obj/item/deployable/mob/sentry
	name = "deployable sentry"
	desc = "BUILDIN A SENTRY"
	desc_extended = "A small man portable sentry designed to fire small-arms ammunition at hostile targets. Battery amd ammo not included."
	mob_to_deploy = /mob/living/simple/turret/deployable
	icon = 'icons/mob/living/simple/turret_deployable_2.dmi'
	value = 750
	amount_max = 1
	weight = 20
	dan_mode = TRUE
	size = SIZE_8

	var/obj/item/powercell/stored_battery
	var/obj/item/magazine/stored_magazine

	rarity = RARITY_UNCOMMON

/obj/item/deployable/mob/sentry/pre_deploy(var/mob/caller,var/turf/T,var/mob/living/L)

	. = ..()

	var/mob/living/simple/turret/deployable/TD = L
	if(stored_battery)
		TD.stored_battery = stored_battery
		stored_battery.force_move(TD)
	if(stored_magazine)
		TD.stored_magazine = stored_magazine
		stored_magazine.force_move(TD)
	if(TD.ai)
		TD.ai.set_active(TRUE)

	if(is_living(caller))
		var/mob/living/C = caller
		if(C.loyalty_tag)
			TD.set_loyalty_tag(C.loyalty_tag)
		if(C.iff_tag)
			TD.set_iff_tag(C.iff_tag)

/obj/item/deployable/mob/sentry/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("stored_battery")
	SAVEATOM("stored_magazine")

/obj/item/deployable/mob/sentry/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("stored_battery")
	LOADATOM("stored_magazine")


/obj/item/deployable/barbed_wire
	name = "deployable barbed wire"
	desc = "Ouch!"
	desc_extended = "An ancient, almost torturous design meant to inhibit the movement of soldiers and civilians while using as little materials as possible."
	icon = 'icons/obj/structure/barbed_wire.dmi'
	icon_state = "inventory"

	structure_to_deploy = /obj/structure/interactive/barbed_wire

	weight = 5

	amount_max = 10

	value = 10

	size = SIZE_2




/obj/item/deployable/mob/cleaning_bot
	name = "deployable cleaning bot"
	desc = "Clean things and earn money for it too!"
	desc_extended = "A very robust little cleaning bot designed to clean rooms and collect items to be automatically sold off."

	icon = 'icons/mob/living/simple/cleaner.dmi'
	icon_state = "off"

	mob_to_deploy = /mob/living/simple/bot/cleaner

	value = 500

	amount_max = 1

	size = SIZE_5