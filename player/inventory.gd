extends Node

const Pickup := preload("res://pickup/pickup.gd")

@onready var _inventory: Dictionary[Pickup.Type, int] = { }


func add(pickup_type: Pickup.Type):
	print(_inventory)
	if _inventory.has(pickup_type):
		_inventory[pickup_type] += 1
	else:
		_inventory[pickup_type] = 1


func use_coin_if_available() -> bool:
	if _inventory.has(Pickup.Type.Coin):
		if _inventory[Pickup.Type.Coin] > 0:
			_inventory[Pickup.Type.Coin] -= 1
			return true
		else:
			return false
	return false
