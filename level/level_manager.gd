extends Node2D

signal level_changed
signal finished

@onready var current_level: Node2D = levels0["level1"].instantiate()
var current_level_number := 1


func _ready():
	add_child(current_level)
	level_changed.emit.call_deferred()


const levels0 := {
	"level1": preload("res://level/levels 0/level0-1.tscn"),
	"level2": preload("res://level/levels 0/level0-2.tscn"),
	"level3": preload("res://level/levels 0/level0-3.tscn"),
	"level4": preload("res://level/levels 0/level0-4.tscn"),
	"level5": preload("res://level/levels 0/level0-5.tscn"),
}


func next_level():
	if current_level_number >= 5:
		finished.emit()
		return

	current_level_number += 1
	var next: Node2D = levels0["level" + str(current_level_number)].instantiate()
	_change_current_scene(next)


func _change_current_scene(scene: Node2D):
	current_level.queue_free()
	current_level = scene
	call_deferred("add_child", current_level)
	await get_tree().create_timer(0.1).timeout
	level_changed.emit.call_deferred()


func get_starting_position() -> Vector2:
	var starting_position := current_level.find_child("StartingPosition") as Node2D
	return starting_position.position


func reset_level():
	_change_current_scene(levels0["level" + str(current_level_number)].instantiate())
