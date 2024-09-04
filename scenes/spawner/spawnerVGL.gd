class_name SpawnerVGL
extends Object


signal state(value: State)


var _current_state := State.IDLE


enum State {
	IDLE,
	ACTIVE
}


func enable():
	if _current_state == State.IDLE:
		_switch_state(State.ACTIVE)


func disable():
	if _current_state == State.ACTIVE:
		_switch_state(State.IDLE)


func _switch_state(new_state: State):
	_current_state = new_state
	state.emit(_current_state)
