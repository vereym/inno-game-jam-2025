extends Control

func _start_game():
    get_tree().change_scene_to_file("res://main.tscn")


func _on_start_button_pressed() -> void:
    _start_game()
