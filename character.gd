extends CharacterBody2D

const default_speed = 80.0
const dash_speed = 1000.0
var movement_speed = default_speed
var health = 5
#animation variables
var direction=1
var pre_dir = direction
var action=3
var pre_action=action

var dash = false
var points = 0

var previous_scores = []

#variables for other nodes
@onready var dashtimer = $DashTimer
@onready var cam = $Camera2D
@onready var sprite = $AnimatedSprite2D


func _ready():
	if not FileAccess.file_exists("user://game.save"):
		return
		
	var save_game = FileAccess.open("user://game.save", FileAccess.READ)
	var json_string = save_game.get_line()
	var json = JSON.new()
	
	if not json.parse(json_string) == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
		
	var data = json.get_data()
	
	previous_scores = data["scores"]
	
	
	
	

func _physics_process(_delta):
	var x_mov = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	var y_mov = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	var mov = Vector2(x_mov, y_mov)
	
	
	#if 2, The chcharacter is running. if 1, the character is walking
	if y_mov > 0:
		direction=3
		action= 2 if dash else 1
	elif y_mov < 0:
		direction=1
		action= 2 if dash else 1
	elif x_mov > 0:
		direction=2
		action= 2 if dash else 1
	elif x_mov < 0:
		direction=4
		action= 2 if dash else 1 
	elif mov == Vector2.ZERO:
		action=3
	
	var dash_key = Input.is_action_just_released("Dash")
	
	if dash_key:
		if not dash:
			if mov == Vector2.ZERO:
				match direction:
					1:
						mov = Vector2(0.0, -1.5)
					2:
						mov = Vector2(1.5, 0.0)
					3:
						mov = Vector2(0.0, 1.5)
					4:  
						mov = Vector2(-1.5, 0.0)
			
			movement_speed = dash_speed
			dashtimer.start()
			dash = true
			action = 2 # 
			cam.drag_horizontal_enabled = true
			cam.drag_vertical_enabled = true
			
	
	
	else:
		movement_speed = 80.0
	velocity = mov.normalized()*movement_speed
	
	if pre_dir != direction or pre_action != action:
		sprite.play(str(get_action_as_str(), get_dir_as_str()))
		pre_dir = direction
		pre_action = action
	
	move_and_slide()
	
func get_dir_as_str():
	match direction:
		1:
			return " up"
		2:
			return " right"
		3:
			return " down"
		4:
			return " left"
			
func get_action_as_str():
	match action:
		1:
			return "walk"		
		2:
			return "run"
		3:
			return "idle"
			
func change_score(num):
	points += num
	print(str("Score: ", points))

func _on_dash_timer_timeout():
	dash = false
	movement_speed = default_speed
	cam.drag_horizontal_enabled = false
	cam.drag_vertical_enabled = false
	
func lower_health(num: int):
	health-=num
	print(str("Health: ", health))
	if health <= 0:
		save_score()
		get_tree().reload_current_scene()
		
func save_score():
	previous_scores.append(points)
	var dict = {
		"scores": previous_scores
	}
	var save_game = FileAccess.open("user://game.save", FileAccess.WRITE)
	var JSON_str = JSON.stringify(dict)
	save_game.store_line(JSON_str)

