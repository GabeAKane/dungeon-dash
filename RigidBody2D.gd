extends RigidBody2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	var mult = 1
	if randi() % 2:
		mult = -1
	
	timer.wait_time = 3.0 + (randf()*5*mult) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	pass # spawn enemy in rand area from spawn_radius (next time!)
