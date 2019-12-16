#define SQUAD_PUBLIC "public"
#define SQUAD_FRIENDS_ONLY "friends"
#define SQUAD_INVITE_ONLY "invite"

#define SQUAD_MEMBERS_MAX 4


var/global/list/squad/all_squads = list()

/squad/
	name = "Squad Name"
	desc = "Squad description."
	desc_extended = "Squad long description."
	var/access = SQUAD_INVITE_ONLY

	var/mob/living/advanced/player/leader = null
	var/list/mob/living/advanced/player/members = list()

	var/never_delete = FALSE

/squad/New(var/desired_loc)

	all_squads += src

	return ..()

/squad/Destroy()

	all_squads -= src

	for(var/mob/living/advanced/player/P in members)
		remove_member(P)

	remove_leader()

	return ..()

/squad/proc/add_member(var/mob/living/advanced/player/P)

	if(P in members)
		return FALSE

	if(length(members) > SQUAD_MEMBERS_MAX)
		return FALSE

	if(P.current_squad == src)
		return FALSE

	if(P.current_squad)
		P.current_squad.remove_member(P)

	members += P

	P.set_squad(src)

	P.to_chat("You have joined [name].")

	return TRUE

/squad/proc/remove_member(var/mob/living/advanced/player/P)

	if(!(P in members))
		return FALSE

	if(P == leader)
		remove_leader()

	P.unset_squad(src)

	members -= P

	P.to_chat("You are no longer in [name].")

	if(!never_delete && !length(members))
		qdel(src)

	return TRUE

/squad/proc/set_leader(var/mob/living/advanced/player/P)

	if(!(P in members))
		return FALSE

	if(leader)

		if(leader == P)
			return FALSE

		remove_leader()

	leader = P

	P.to_chat("You are now the leader of [name].")

	return TRUE

/squad/proc/remove_leader()

	if(!leader)
		return FALSE

	leader.to_chat("You are no longer the leader of [name].")

	leader = null

	return TRUE