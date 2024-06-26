extends Node2D

@export var width: int
@export var height: int
@onready var rng = RandomNumberGenerator.new()

const CHEST = preload("res://chest.tscn")

func spawn():
	rng.randomize()
	var x_spawn = rng.randi_range(global_position.x, global_position.x+width)
	var y_spawn = rng.randi_range(global_position.y, global_position.y-height)
	var chest = CHEST.instantiate()
	chest.global_position = Vector2(x_spawn, y_spawn)
	get_parent().add_child(chest)
