class_name Ball
extends CharacterBody2D


@export var original_speed := 400.0
@export var spawn_variation := 45

@onready var speed := original_speed

@onready var _vgl := BallVGL.new(self)


func _process(_delta):
	if (Input.is_action_pressed("spawn")):
		_vgl.on_spawn_requested()
	if (Input.is_action_pressed("clear")):
		_vgl.on_idle_requested()


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		var colliding_object = collision_info.get_collider() as Node
		if colliding_object.is_in_group("paddle"):
			_vgl.on_play_requested()
		
		_bounce(collision_info)


func spawn():
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
	velocity = Vector2.ZERO
	global_position = Vector2(-50, -50)


func play():
	velocity.x *= 2


func _bounce(collision_info: KinematicCollision2D):
	velocity = velocity.bounce(collision_info.get_normal())