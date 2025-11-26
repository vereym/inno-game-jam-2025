extends Area2D

const Inventory := preload("res://player/inventory.gd")
const Pickup := preload("res://pickup/pickup.gd")

signal goal_reached

enum Movement {
    Normal,
    Diagonal,
}

@onready var ray := $RayCast2D
@onready var current_movement := Movement.Normal
@onready var inventory = Inventory.new()

var moving := false
var animation_speed := 10
var tile_size := 250
var direction_vectors := {
    "left": Vector2.LEFT,
    "right": Vector2.RIGHT,
    "up": Vector2.UP,
    "down": Vector2.DOWN,
}
var diagonal_vectors := {
    "left": Vector2(0, -1),
    "right": Vector2(0, 1),
    "up": Vector2(1,0),
    "down": Vector2(-1, 0),
}

func _unhandled_key_input(event: InputEvent) -> void:
    if moving:
        return
    if event.is_action_pressed("coin_flip") and inventory.can_flip():
        if current_movement == Movement.Normal:
            current_movement = Movement.Diagonal
        else:
            current_movement = Movement.Normal

        _play_flip_animation()

    if event.is_action_pressed("left"): move("left")
    if event.is_action_pressed("right"): move("right")
    if event.is_action_pressed("up"): move("up")
    if event.is_action_pressed("down"): move("down")


func move(dir):
    var target_position: Vector2
    if current_movement == Movement.Diagonal:
        target_position = (direction_vectors[dir] * tile_size) + (diagonal_vectors[dir] * tile_size)
    else:
        target_position = direction_vectors[dir] * tile_size

    # check if field where we want to go is a collision
    ray.target_position = target_position
    ray.force_raycast_update()
    if !ray.is_colliding():
        var tween := create_tween()
        tween.tween_property(self, "position",
            position + target_position, 1./animation_speed).set_trans(Tween.TRANS_SINE)
        moving = true
        await tween.finished
        moving = false

func reset(new_position: Vector2):
    self.position = new_position
    current_movement = Movement.Normal
    inventory = Inventory.new()

func _pickup_item(item: Pickup):
    inventory.add(item.type)
    item.queue_free()

func _play_flip_animation():
    %Default.hide()
    %CoinFlip.play()
    %CoinFlip.animation_finished.connect(func(): %Default.show())

func _on_area_entered(area: Area2D) -> void:
    if area.name == "PickupArea":
        _pickup_item(area.get_parent())

    if area.name == "GoalArea":
        self.goal_reached.emit()
