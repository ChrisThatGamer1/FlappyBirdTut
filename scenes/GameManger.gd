extends Node

@onready var player_bird = $"../PlayerBird" as PlayerBird
@onready var pipe_spawner = $"../PipeSpawner"
@onready var ground = $"../Ground" as Ground

var points = 0 
 
func _ready():
	player_bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)

func on_game_started():
	pipe_spawner.start_spawning_pipes()


func end_game(): #function to stop the game after the player crashes
	ground.stop()
	player_bird.stop()
	pipe_spawner.stop()

func on_point_scored():
	points += 1
