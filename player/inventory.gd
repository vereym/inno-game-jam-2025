extends Node

const Pickup := preload("res://pickup/pickup.gd")

@onready var _inventory: Dictionary[Pickup.Type, int] = { }


func add(pickup_type: Pickup.Type):
	print(_inventory)
	if _inventory.has(pickup_type):
		_inventory[pickup_type] += 1
	else:
		_inventory[pickup_type] = 1


func can_flip() -> bool:
	if _inventory.has(Pickup.Type.Coin):
		return true if _inventory[Pickup.Type.Coin] > 0 else false
	return false
