extends Node
class_name State

var states
var current_state

# Called when the node enters the scene tree for the first time.
func _init():
	states = {
		"Idle" : IdleState,
		"Walking" : WalkingState,
		"Onair" : OnairState,
		"Dead" : DeadState,
		"Hit" : HitState,
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_state(new_state_name):	
	if get_child_count() == 1:#!=0 :
		get_child(0).queue_free()
	
	if get_child_count() < 2:
		current_state = states.get(new_state_name).new()
		current_state.name = new_state_name
		add_child(current_state)
		var count = get_child_count()
		print(get_child(0))

