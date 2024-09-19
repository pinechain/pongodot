class_name BallVGL
extends Object


var _current_state := State.IDLE


var _ball: Ball


enum State {
	IDLE,
	SPAWNING,
	PLAYING,
	SCORING
}


func _init(ball: Ball):
	_ball = ball


func on_idle_requested():
	if _current_state != State.IDLE:
		_switch_state(State.IDLE)
		_ball.clear()


func on_spawn_requested():
	if _current_state == State.IDLE:
		_switch_state(State.SPAWNING)
		_ball.spawn()


func on_play_requested():
	if _current_state == State.SPAWNING:
		_switch_state(State.PLAYING)
		_ball.play()


func on_score_requested(side: Globals.Side):
	if _current_state == State.SPAWNING or _current_state == State.PLAYING:
		_switch_state(State.SCORING)
		_ball.change_spawn_direction(side)
		on_idle_requested()
		on_spawn_requested()


func _switch_state(state: State):
	_current_state = state
	_ball.speed = _ball.original_speed * _current_state
