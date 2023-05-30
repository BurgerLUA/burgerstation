var/global/list/stored_bookcase_phrases = list(
	"...So that's what happened to Woody...",
	"...Those Xenomorphs sure are lusty...",
	"...It really is all porn...",
	"...So that's why they use the shotgun...",
	"...Well, that's one of the symptoms of having a literal dent in your skull...",
	"...It's just... endless anime...",
	"...Oh a mime book... it's blank..."
)

/obj/structure/interactive/bookcase
	name = "dusty bookcase"
	desc = "What possible knowledge could be in here?"
	desc_extended = "An ancient, dusty bookcase. Long abandoned since the days of the gigaplex multimedia home entertainment system."
	icon = 'icons/obj/structure/bookcase.dmi'
	icon_state = "book"

	var/chance_of_scroll = 5

	density = TRUE
	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	collision_dir = NORTH | EAST | SOUTH | WEST

	interaction_flags = FLAG_INTERACTION_LIVING

	pixel_y = 6

/obj/structure/interactive/bookcase/no_scrolls
	chance_of_scroll = 0

/obj/structure/interactive/bookcase/Generate()

	if(chance_of_scroll)
		chance_of_scroll = rand(1,chance_of_scroll)

	. = ..()

/obj/structure/interactive/bookcase/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/bookcase/update_sprite()
	. = ..()
	icon_state = initial(icon_state)
	if(chance_of_scroll > 0)
		icon_state = "[icon_state]-[chance_of_scroll]"

/obj/structure/interactive/bookcase/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_inventory(object))
		return ..()

	if(can_search_case(caller))
		caller.to_chat(span("notice","You start searching \the [src.name]..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),src::search_case(),caller)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_search_case(),caller)

	return TRUE

/obj/structure/interactive/bookcase/proc/can_search_case(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(chance_of_scroll <= 0)
		caller.to_chat(span("warning","You don't think you'll find anything of use here."))
		return FALSE

	if(prob(2))
		caller.to_chat(span("notice",pick(stored_bookcase_phrases)))

	return TRUE

/obj/structure/interactive/bookcase/proc/search_case(var/mob/caller)

	if(prob(chance_of_scroll*10))
		var/rarity = 0
		var/mob/living/advanced/player/P
		if(is_player(caller))
			P = caller
			rarity = P.get_rarity()
		var/turf/T = get_turf(src)
		var/list/found_items = SPAWN_LOOT(/loot/random/scroll,T,rarity)
		if(P)
			for(var/k in found_items)
				var/obj/item/I = k
				P.put_in_hands(I)
		caller.to_chat(span("notice","Huh. You found something in \the [src.name]!"))
	else
		caller.to_chat(span("warning","You didn't find anything in \the [src.name]...."))

	chance_of_scroll--
	update_sprite()

	return TRUE