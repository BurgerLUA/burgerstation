// Clamps (duh) a number between 2 other numbers.
// Yes, this implementation is faster than a min(max()) clamp, I've profiled it.
#define Clamp(x, min, max) (x <= min ? min : (x >= max ? max : x))
#define CLAMP01(x)         Clamp((x), 0, 1)
