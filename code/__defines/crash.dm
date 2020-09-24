#define CRASH_SAFE(x) world.Error(new /exception(x,__FILE__,__LINE__));
