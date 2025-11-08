extends Node2D

@onready var current_level := $Level

var levels := []


func next_level():
    var next := load("res://level/level2.tscn").instantiate() as TileMapLayer
    _change_current_scene(next)

func _change_current_scene(scene):
    current_level.queue_free()
    current_level = scene
    add_child(current_level)
