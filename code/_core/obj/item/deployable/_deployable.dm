/obj/item/deployable
	name = "deployable structure"
	desc = "Quick and fast deployment."
	desc_extended = "Deploys a structure."
	var/obj/structure/structure_to_deploy //Store as a type.

	item_count_current = 1
	item_count_max = 10
	item_count_max_icon = 3

/obj/item/deployable/proc/get_deploy_time(var/mob/caller)
	return SECONDS_TO_DECISECONDS(3)

/obj/item/deployable/proc/deploy(var/mob/caller,var/turf/T)

	var/obj/structure/S = new structure_to_deploy(T)
	S.dir = caller.dir
	INITIALIZE(S)
	FINALIZE(S)
	caller.visible_message(span("notice","\The [caller.name] deploys \the [S.name]."),span("notice","You deploy \the [S.name]."))

	add_item_count(-1)

	return TRUE

/obj/item/deployable/proc/can_deploy_to(var/mob/caller,var/turf/T)

	if(item_count_current <= 0)
		qdel(src)
		return FALSE

	return T.can_construct_on(caller,structure_to_deploy)

/obj/item/deployable/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(isturf(object) && can_deploy_to(caller,object))
		if(caller.loc != object)
			caller.face_atom(object) //Only face the atom if we're not on the tile.
		caller.to_chat(span("notice","You begin deploying \the [src.name]..."))
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

/obj/item/deployable/sentry
	name = "deployable sentry"
	desc = "BUILDIN A SENTRY"
	desc_extended = "A small man portable sentry. on the bottom you see a tag saying: ATTENTION DUE TO THE MANUFACTURE'S INCOMPITANCE YOU CANNOT PACK UP THIS SENTRY ONCE YOU DEPLOY IT"
	structure_to_deploy =/mob/living/simple/npc/turret/nanotrasen_deployable/
	icon = 'icons/obj/item/deployable/miniturret.dmi'
	value = 500
	item_count_max = 1
	weight = 20
	size = SIZE_4