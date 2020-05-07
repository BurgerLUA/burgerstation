#define HOOK_ADD(event_name,identifier,datum_to_use,proc_to_use) SShook.add_hook(event_name,identifier,datum_to_use,proc_to_use)
#define HOOK_REMOVE(event_name,identifier,datum_to_use) SShook.remove_hook(event_name,identifier,datum_to_use)
#define HOOK_CALL_ADV(event_name,datum_to_use,args) SShook.call(event_name,datum_to_use,args)
#define HOOK_CALL(event_name) SShook.call_hook(event_name,src,args)