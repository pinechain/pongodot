extends Node2D


@export var ball: PackedScene


@onready var _vgl := SpawnerVGL.new()
@onready var _ball_instance := ball.instantiate() as CharacterBody2D
@onready var _off_limits_position := Vector2(-50, -50)


func _ready():
	_vgl.state.connect(_on_state_changed)
	add_child(_ball_instance)


func _process(_delta):
	if Input.is_action_pressed("spawn"):
		_trigger_vgl(true)
	if Input.is_action_pressed("clear"):
		_trigger_vgl(false)


func _trigger_vgl(is_active: bool):
	if is_active:
		_vgl.enable()
	else:
		_vgl.disable()


func _on_state_changed(state: SpawnerVGL.State):
	match state:
		SpawnerVGL.State.IDLE:
			_clear_ball()
		SpawnerVGL.State.ACTIVE:
			_spawn_ball()


func _spawn_ball():
	var height = randf_range(20, 748)
	_ball_instance.global_position = Vector2(683, height)


func _clear_ball():
	_ball_instance.global_position = _off_limits_position