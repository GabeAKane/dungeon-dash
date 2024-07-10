extends Node2D

var spawned = false
@onready var CHEST = preload("res://chest.tscn")

func spawn():
	var chest = CHEST.instantiate()
	
	chest.global_position = global_position
	get_parent().add_child(chest)
