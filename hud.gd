extends CanvasLayer

@onready var timer = $GameTime
@onready var scoreL = $"score label"
@onready var timeL = $"time label"
@onready var player = get_tree().get_first_node_in_group("player")
@onready var healthL = $"health label"
@onready var highscoreL = $"highscore label"
var minutes = 3
var seconds = 0

var changed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	highscoreL.text = str("High Score: ", player.previous_scores.max())
	timeL.text = "3:00"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scoreL.text = str("Score: ", player.points)
	healthL.text = str("Health: ", player.health)


func _on_game_time_timeout():
	changed = true
	if seconds == 0:
		if minutes <=0:
			print("GAME END")
			timer.paused = true
			player.save_score()
			get_tree().reload_current_scene()
		else:
			minutes-=1
			seconds=59
	else:
		seconds-=1
	#print(str("time: ", minutes, " ", seconds))
	
	if seconds <10:
		timeL.text=str(minutes, ":0",seconds)
		return
	
	timeL.text=str(minutes, ":",seconds)
