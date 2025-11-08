extends Area2D

signal goal_reached

@onready var ray := $RayCast2D

var moving := false
var animation_speed := 10
var tile_size := 64
var direction_vectors := {
    "left": Vector2.LEFT,
    "right": Vector2.RIGHT,
    "up": Vector2.UP,
    "down": Vector2.DOWN,
}

func _ready() -> void:
    pass

func _unhandled_key_input(event: InputEvent) -> void:
    if moving:
        return
    if event.is_action_pressed("left"): move("left")
    if event.is_action_pressed("right"): move("right")
    if event.is_action_pressed("up"): move("up")
    if event.is_action_pressed("down"): move("down")


func move(dir):
    # check if field where we want to go is a collision
    ray.target_position = direction_vectors[dir] * tile_size
    ray.force_raycast_update()
    if !ray.is_colliding():
        var tween := create_tween()
        tween.tween_property(self, "position",
            position + direction_vectors[dir] * tile_size, 1./animation_speed).set_trans(Tween.TRANS_SINE)
        moving = true
        await tween.finished
        moving = false


func _on_body_entered(_body: Node2D) -> void:
    self.goal_reached.emit()
