extends CharacterBody2D

const speed = 20

@onready var player = get_tree().get_first_node_in_group("player")
@onready var nav_agent = $NavigationAgent2D

func _physics_process(delta):
	var dir = to_local(nav_agent.target_position).normalized()
	velocity = dir * speed
	move_and_slide()
	
func make_path():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path()
