#define START_THINKING(A) SSthinking.all_thinkers[A] = TRUE
#define STOP_THINKING(A) SSthinking.all_thinkers -= A
#define IS_THINKING(A) SSthinking.all_thinkers[A]
