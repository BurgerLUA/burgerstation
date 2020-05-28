#define A_STAR_MAXIMUM_SEARCH_THRESHOLD 500
#define A_STAR_DIAGONAL_MOVEMENT_ALLOWED TRUE
#define A_STAR_DIAGONAL_MOVEMENT_COST_MULTIPLE 1
#define A_STAR_MOVEMENT_COST_ESTIMATE_PER_TURF 1
#define A_STAR_DESTINATION_BIAS 1




/atom/movable/get_a_star_path_to(var/turf/destination,var/needed_dist)
	return get_a_star_path(src,destination,needed_dist)