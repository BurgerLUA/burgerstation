#define AI_STATE_NONE 0x0

#define AI_STATE_MOVE 0x1
#define AI_STATE_ATTACK 0x2
#define AI_STATE_DEFEND 0x4




/ai/
	var/name = "Default AI"
	var/desc = "The AI."

	var/mob/owner

	var/atom/objective_move
	var/atom/objective_attack
	var/atom/objective_defend

	var/state_ai


/ai/proc/on_life()

	handle_objectives()
	handle_movement()
	handle_attacking()



	return TRUE

/ai/proc/handle_attacking()


/ai/proc/handle_movement()


/ai/proc/handle_objectives()