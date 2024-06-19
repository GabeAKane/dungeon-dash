extends CanvasLayer

@onready var timer = $GameTime
@onready var scoreL = $"score label"
@onready var timeL = $"time label"
@onready var player = get_tree().get_first_node_in_group("player")

var minutes = 3
var seconds = 0

var changed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scoreL.text = str("Score: ", player.points)


func _on_game_time_timeout():
	changed = true
	if seconds == 0:
		if minutes <=0:
			print("GAME END")
			timer.paused = true
		else:
			minutes-=1
			seconds=59
	else:
		seconds-=1
	print(str("time", minutes, " ", seconds))
	
	timeL.text=str(minutes, ":",seconds)
