/obj/item/deployable
	name = "deployable structure"
	desc = "Quick and fast deployment."
	desc_extended = "Deploys a structure."
	var/obj/structure/structure_to_deploy //Store as a type. This should always be a structure.

	item_count_current = 1
	item_count_max = 10
	item_count_max_icon = 3

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

	if(item_count_current <= 0)
		qdel(src)
		return FALSE

	return T.can_construct_on(caller,structure_to_deploy)

/obj/item/deployable/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(isturf(object) && can_deploy_to(caller,object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(caller.loc != object)
			caller.face_atom(object) //Only face the atom if we're not on the tile.
		caller.visible_message(span("warning","\The [caller.name] starts to deploy \the [src.name]..."),span("notice","You start to deploy \the [src.name]..."))
		PROGRESS_BAR(caller,src,get_deploy_time(caller),.proc/deploy,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_deploy_to,caller,object)
		return TRUE

	return ..()

/obj/item/deployable/barricade
	name = "deployable barricade"
	desc = "Your main source of protection."
	desc_extended = "A large deployable barricade."
	structure_to_deploy = /obj/structure/interactive/barricade/
	icon = 'icons/obj/item/deployable/barricade.dmi'
	value = 40

	weight = 3

	item_count_max = 5

	size = SIZE_3

/obj/item/deployable/barricade/filled/Generate()
	item_count_current = item_count_max
	return ..()

/obj/item/deployable/mob
	var/mob/living/mob_to_deploy

/obj/item/deployable/mob/can_deploy_to(var/mob/caller,var/turf/T)

	if(item_count_current <= 0)
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
	item_count_max = 1
	weight = 20
	dan_mode = TRUE
	size = SIZE_8

	var/obj/item/powercell/stored_battery
	var/obj/item/magazine/stored_magazine

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

	return .

/obj/item/deployable/mob/sentry/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_battery")
	SAVEATOM("stored_magazine")
	return .

/obj/item/deployable/mob/sentry/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_battery")
	LOADATOM("stored_magazine")
	return .


