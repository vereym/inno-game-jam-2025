extends Node2D

signal level_changed

@onready var current_level: Node2D = $Level

var levels := []

func _input(event):
    if event.is_action_pressed("restart_level"):
        _change_current_scene(current_level)

func next_level():
    var next := load("res://level/level2.tscn").instantiate() as TileMapLayer
    _change_current_scene(next)
    level_changed.emit()

func _change_current_scene(scene):
    current_level.queue_free()
    current_level = scene
    add_child(current_level)

func get_starting_position() -> Vector2:
    var starting_position := current_level.find_child("StartingPosition") as Node2D
    return starting_position.position
