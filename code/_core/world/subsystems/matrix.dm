var/list/atom/movable/matrix_requesters = list()

/*
Format:
	v = data
	data.time
	data.orginal_time
	data.matrix
*/

SUBSYSTEM_DEF(matrix)
	name = "Mob Subsystem"
	desc = "Controls matrix based animations."
	tick_rate = 1
	priority = SS_ORDER_MATRIX

/subsystem/matrix/on_life()
	return FALSEW