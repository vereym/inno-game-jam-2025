extends Node

var tileset_basic := preload("res://level/tileset_basic.tres")
var custom_tileset := preload("res://level/custom_tileset.tres")


func _ready() -> void:
	%Player.tile_size = custom_tileset.tile_size.x
	%Player.goal_reached.connect(%LevelManager.next_level)

	%LevelManager.finished.connect(_game_finished)
	%LevelManager.level_changed.connect(
		func():
			%Player.reset(%LevelManager.get_starting_position())
			(%CurrentLevel as Label).text = "LEVEL: " + str(%LevelManager.current_level_number)
	)


func _input(event):
	if event.is_action_pressed("restart_level"):
		%Player.reset(%LevelManager.get_starting_position())
		%LevelManager.reset_level()


func _game_finished():
	%FinishLabel.show()
