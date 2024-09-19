extends Control


func _ready():
	EventBus.on_score_changed.sub(_update_score)
	EventBus.on_victory_reached.sub(_trigger_victory)


func _update_score(score: Array[int]):
	$left_score.text = str(score[Globals.Side.LEFT])
	$right_score.text = str(score[Globals.Side.RIGHT])


func _trigger_victory(side: int):
	match side:
		Globals.Side.LEFT:
			$left_status.text = "winner"
			$right_status.text = "loser"
		Globals.Side.RIGHT:
			$right_status.text = "winner"
			$left_status.text = "loser"

	$left_status.visible = true
	$right_status.visible = true
