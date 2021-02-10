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

	var/chance_of_scroll = 0

	density = TRUE

/obj/structure/interactive/bookcase/Generate()

	if(prob(25))
		chance_of_scroll = rand(1,5)
		icon_state = "[initial(icon_state)]_[chance_of_scroll]"

	return ..()

/obj/structure/interactive/bookcase/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_inventory(object))
		return ..()

	if(can_search_case(caller))
		caller.to_chat(span("notice","You start to search \the [src.name]..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/search_case,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_search_case,caller)

	return TRUE

/obj/structure/interactive/bookcase/proc/can_search_case(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(prob(5))
		caller.to_chat(span("notice",pick(stored_bookcase_phrases)))

	return TRUE

/obj/structure/interactive/bookcase/proc/search_case(var/mob/caller)

	if(chance_of_scroll <= 0)
		caller.to_chat(span("warning","...You don't think you'll find anything of use here."))
		return TRUE

	if(prob(chance_of_scroll))
		var/turf/T = get_turf(src)
		CREATE_LOOT(/loot/skill_scroll,T)
		caller.to_chat(span("notice","Huh. You found a scroll!"))
		chance_of_scroll = 0
	else
		chance_of_scroll--
		caller.to_chat(span("warning","...You didn't find anything."))

	return TRUE