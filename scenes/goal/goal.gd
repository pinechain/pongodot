extends Area2D


@export var side: Globals.Side


func _on_body_entered(_body:Node2D):
	# Always trigger score for the side that this object is not on
	match side:
		Globals.Side.LEFT:
			EventBus.on_score.trigger(Globals.Side.RIGHT)
		Globals.Side.RIGHT:
			EventBus.on_score.trigger(Globals.Side.RIGHT)
