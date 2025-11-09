extends Node2D

signal level_changed

@onready var current_level: Node2D = $Level

const level_names := {
    "Level": level,
    "Level2": level2,
}

const level := preload("res://level/level.tscn")
const level2 := preload("res://level/level2.tscn")

var levels := []

func next_level():
    var next: Node2D = level.instantiate()
    _change_current_scene(next)

func _change_current_scene(scene: Node2D):
    current_level.queue_free()
    current_level = scene
    add_child(current_level)
    level_changed.emit()

func get_starting_position() -> Vector2:
    var starting_position := current_level.find_child("StartingPosition") as Node2D
    return starting_position.position

func reset_level():
    _change_current_scene(level_names[current_level.name].instantiate())
