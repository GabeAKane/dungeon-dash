extends StaticBody2D

@onready var timer = $Timer
@onready var spawnArea = $spawn_radius/CollisionShape2D.shape.radius
@onready var origin = global_position

const ENEMY = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 3.0 + (randf()*5) 
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	var enemy = ENEMY.instantiate()
	enemy.global_position = origin + (spawnArea*_random_inside_unit_circle())
	get_parent().add_child(enemy)
	timer.wait_time = 3.0 + (randf()*5)

func _random_inside_unit_circle() -> Vector2:
	var theta : float = randf() * 2 * PI
	return Vector2(cos(theta), sin(theta)) * sqrt(randf())
