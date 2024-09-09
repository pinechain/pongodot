class_name Ball
extends CharacterBody2D


@export var speed := 400.0
@export var spawn_variation := 45


@onready var _vgl := BallVGL.new(self)


func _process(_delta):
	if (Input.is_action_pressed("spawn")):
		_vgl.on_spawn_requested()
	if (Input.is_action_pressed("clear")):
		_vgl.on_idle_requested()
	
	move_and_slide()


func spawn():
	_stop()

	# Determine spawn position
	var height = randf_range(20, 748)
	global_position = Vector2(683, height)

	# Determine initial movement angle
	var initial = deg_to_rad(-spawn_variation)
	var final = deg_to_rad(spawn_variation)
	var angle = randf_range(initial, final)

	# Determine movement direction
	velocity.x = -1 * speed
	velocity = velocity.rotated(angle)


func clear():
	global_position = Vector2(-50, -50)
	_stop()


func play():
	pass


func _stop():
	velocity = Vector2.ZERO