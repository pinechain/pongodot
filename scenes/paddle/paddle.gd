extends CharacterBody2D


@export var side: Globals.Side
@export var speed := 400.0


func _ready():
	match side:
		Globals.Side.LEFT:
			global_position = Vector2(100, 364)
			var sprite = load("res://scenes/paddle/red.png")
			($sprite as Sprite2D).texture = sprite
		Globals.Side.RIGHT:
			global_position = Vector2(1266, 364)
			var sprite = load("res://scenes/paddle/blu.png")
			($sprite as Sprite2D).texture = sprite


func _process(_delta):
	velocity = Vector2.ZERO
	match side:
		Globals.Side.LEFT:
			_process_red_input()
		Globals.Side.RIGHT:
			_process_blu_input()
	move_and_slide()


func _process_red_input():
	if Input.is_action_pressed("red_up"):
		_move_up()
	if Input.is_action_pressed("red_down"):
		_move_down()


func _process_blu_input():
	if Input.is_action_pressed("blu_up"):
		_move_up()
	if Input.is_action_pressed("blu_down"):
		_move_down()


func _move_up():
	velocity.y = -1
	velocity *= speed


func _move_down():
	velocity = Vector2.ZERO
	velocity.y += 1
	velocity *= speed
