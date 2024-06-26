extends CharacterBody2D

class_name PlayerBird

# create vars, that can be edited via the inspector with @export var
@export var gravity = 900.0
@export var jump_force = -900
@export var rotation_speed = 2

@onready var animation_player = $AnimationPlayer

# create a var that can only be changed via the script
var max_speed = 400
var is_started = false #creating a boolean var that is false 
var should_process_input = true


func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			animation_player.play("flap_wings")
			is_started = true
		jump()
	
	
	
	if !is_started:
		return 
	velocity.y += gravity * delta #to apply gravity over time
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta) #stopped at
	
	#call the function 
	rotate_bird()

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)


func rotate_bird():
# rotate donwards when falling 
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
		# rotate upwards when rising
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	should_process_input = false
