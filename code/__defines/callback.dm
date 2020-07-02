#define GLOBAL_PROC	"some_magic_bullshit"
//#define INVOKE_ASYNC ImmediateInvokeAsync


#define CALLBACK(desired_id,desired_time,desired_object,desired_proc,arguments...) SScallback.add_callback(desired_id,desired_time,desired_object,desired_proc,arguments)
#define CALLBACK_GLOBAL(desired_id,desired_time,desired_proc,arguments...) SScallback.add_callback(desired_id,desired_time,null,desired_proc,arguments)
#define CALLBACK_EXISTS(desired_id) SScallback.all_callbacks[desired_id]
#define CALLBACK_REMOVE(desired_id) SScallback.remove_callback(desired_id)