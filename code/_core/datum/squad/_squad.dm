#define SQUAD_PUBLIC "public"
#define SQUAD_FRIENDS_ONLY "friends"
#define SQUAD_INVITE_ONLY "invite"

#define SQUAD_MEMBERS_MAX 4


var/global/list/squad/all_squads = list()

/squad/
	var/name = "Squad Name"
	var/desc = "Squad description."
	var/desc_extended = "Squad long description."
	var/access = SQUAD_INVITE_ONLY

	var/mob/living/advanced/player/leader = null
	var/list/mob/living/advanced/player/members = list()

	var/never_delete = FALSE

/squad/New(var/desired_loc)

	all_squads += src

	return ..()

/squad/Destroy()

	all_squads -= src

	for(var/k in members)
		var/mob/living/advanced/player/P = k
		remove_member(P)

	remove_leader()

	return ..()

/squad/proc/add_member(var/mob/living/advanced/player/P)

	if(members[P])
		return FALSE

	if(length(members) > SQUAD_MEMBERS_MAX)
		return FALSE

	if(P.current_squad == src)
		return FALSE

	if(P.current_squad)
		P.current_squad.remove_member(P)

	members[P] = TRUE

	P.set_squad(src)

	for(var/k in members)
		var/mob/living/advanced/player/P2 = k
		P2.add_squad_button(P)

	P.to_chat(span("warning","You have joined the squad \"[name]\"."))

	return TRUE

/squad/proc/remove_member(var/mob/living/advanced/player/P)

	if(!members[P])
		return FALSE

	if(P == leader)
		remove_leader()

	P.unset_squad(src)

	members -= P

	P.to_chat(span("warning","You are no longer a squad member of [name]."))

	for(var/k in members)
		var/mob/living/advanced/player/P2 = k
		P2.remove_squad_button(P)

	if(!never_delete && !length(members))
		qdel(src)

	return TRUE

/squad/proc/set_leader(var/mob/living/advanced/player/P)

	if(!members[P])
		return FALSE

	if(leader)

		if(leader == P)
			return FALSE

		remove_leader()

	leader = P

	P.to_chat(span("notice","You are now the squad leader of [name]."))

	return TRUE

/squad/proc/remove_leader()

	if(!leader)
		return FALSE

	leader.to_chat(span("warning","You are no longer the squad leader of [name]."))

	leader = null

	return TRUE