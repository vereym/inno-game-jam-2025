extends Node

var tileset_basic := preload("res://level/tileset_basic.tres")
var custom_tileset := preload("res://level/custom_tileset.tres")

func _ready() -> void:
    %Player.tile_size = custom_tileset.tile_size.x
    %Player.goal_reached.connect(%LevelManager.next_level)

    %LevelManager.level_changed.connect(
        func():
            %Player.position = %LevelManager.get_starting_position()
    )
