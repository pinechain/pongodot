class_name Ball
extends CharacterBody2D


@export var original_speed := 400.0
@export var spawn_variation := 45

@onready var speed := original_speed

@onready var _vgl := BallVGL.new(self)
@onready var _spawn_direction := -1


func _ready():
	EventBus.on_score.sub(_vgl.on_score_requested)
	EventBus.on_victory_reached.sub(_vgl.on_idle_requested)


func _process(_delta):
	if (Input.is_action_pressed("spawn")):
		_vgl.on_spawn_requested()


func _physics_process(delta):
	# Try to detect collision during movement
	var collision_info = move_and_collide(velocity * delta)
	
	# Collision detected
	if collision_info:
		var colliding_object = collision_info.get_collider() as Node
		if colliding_object.is_in_group("paddle"):
			_vgl.on_play_requested()
		
		# Bounce
		velocity = velocity.bounce(collision_info.get_normal())


func spawn():
	# Determine spawn position
	var height = randf_range(20, 748)
	global_position = Vector2(683, height)

	# Determine initial movement angle
	var initial = deg_to_rad(-spawn_variation)
	var final = deg_to_rad(spawn_variation)
	var angle = randf_range(initial, final)

	# Determine movement direction
	velocity.x = _spawn_direction * speed
	velocity = velocity.rotated(angle)

	# Enable visibility
	visible = true


func clear():
	# Teleport outside of screen
	velocity = Vector2.ZERO
	global_position = Vector2(-50, -50)


func play():
	# Change to playing velocity
	velocity.x *= 2


func change_spawn_direction(direction: Globals.Side):
	match direction:
		Globals.Side.LEFT:
			_spawn_direction = -1
		Globals.Side.RIGHT:
			_spawn_direction = 1