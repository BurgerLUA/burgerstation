#define LATE_INIT(o) if(SSobj.initialized) {CRASH_SAFE("Warning: [o.get_debug_name()] tried to be initialized late, but it was done after initializations!")} else {SSobj.initialize_late += o}

#define REAGENT(x) (SSreagent.all_reagents[x])