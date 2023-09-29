#define START_THINKING(A) \
	if(A.qdeleting) \
		log_error("WARNING: Tried calling START_THINKING on [A.get_debug_name()], which was deleting!"); \
	else \
		SSthinking.all_thinkers[A] = TRUE;

#define STOP_THINKING(A) SSthinking.all_thinkers -= A
#define IS_THINKING(A) SSthinking.all_thinkers[A]
