extends CharacterBody2D

const speed = 20

var should_delete = false

@onready var notification = $VisibleOnScreenNotifier2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var nav_agent = $NavigationAgent2D
@onready var sprite = $AnimatedSprite2D
func _physics_process(_delta):
	var dir = to_local(nav_agent.target_position).normalized()
	#sprite.rotation = atan2(
	#	nav_agent.target_position.y-global_position.y, 
	#	nav_agent.target_position.x-global_position.x
	#)
	velocity = dir * speed
	move_and_slide()
	if should_delete and not notification.is_on_screen():
		queue_free()
	
func make_path():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player.health -= 1
		print(str("Player health: ", player.health))


func _on_timer_2_timeout():
	should_delete = true
	if not notification.is_on_screen():
		queue_free()

