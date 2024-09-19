class_name Arbiter
extends Node2D


var _score : Array[int] = [0, 0]


func _ready():
	EventBus.on_score.sub(_increase_score)


func _increase_score(side: Globals.Side):
	_update_score(side)


func _update_score(side: Globals.Side):
	_score[side] += 1
	EventBus.on_score_changed.trigger(_score)
	if (_score[side] == Globals.VICTORY_SCORE):
		EventBus.on_victory_reached.trigger(side)
