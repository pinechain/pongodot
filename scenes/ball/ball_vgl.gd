class_name BallVGL
extends Object


var _current_state := State.IDLE


var _ball: Ball


enum State {
	IDLE,
	SPAWNING,
	PLAYING
}


func _init(ball: Ball):
	_ball = ball


func on_idle_requested():
	_current_state = State.IDLE
	_ball.clear()


func on_spawn_requested():
	if _current_state == State.IDLE:
		_current_state = State.SPAWNING
		_ball.spawn()


func on_playing_requested():
	if _current_state == State.SPAWNING:
		_current_state = State.PLAYING
		_ball.play()