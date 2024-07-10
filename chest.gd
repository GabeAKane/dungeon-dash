extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $AnimatedSprite2D
var isOpened = false

@export var points = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_2d_body_entered(body):
	if not isOpened and body.is_in_group("player"):
		player.change_score(points)
		isOpened = true
		sprite.play("opening")


func _on_visible_on_screen_notifier_2d_screen_exited():
	if isOpened: 
		queue_free()
		var chest_managers = get_tree().get_nodes_in_group("chest manager")
		var rand_manager = chest_managers.pick_random()
		while rand_manager.spawned:
			rand_manager = chest_managers.pick_random()
		rand_manager.spawn()
