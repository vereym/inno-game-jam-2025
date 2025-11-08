extends Node

var tileset_basic = preload("res://level/tileset_basic.tres")

func _ready() -> void:
    %Player.tile_size = tileset_basic.tile_size.x
    %Player.goal_reached.connect(%LevelManager.next_level)
