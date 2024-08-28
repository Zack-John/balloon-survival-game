extends Node2D

const SAW_SCENE = preload("res://sawblade.tscn") # load a "packed" scene

@onready var timer = $Timer
@onready var arrow_sprite = $ArrowSprite

var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))

# Called when the node enters the scene tree for the first time.
func _ready():
	arrow_sprite.rotation = direction.angle()
	timer.timeout.connect(on_timer_timeout) #NOTE: no parens here, just the NAME of the fxn
	Events.balloon_popped.connect(timer.stop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_timer_timeout():
	var saw = SAW_SCENE.instantiate() # instantiate the sawblade scene (in memory)
	saw.position = position # set saw's position to this (telegraph) position
	saw.linear_velocity = direction * 50
	
	Events.saw_blade_added.emit()
	get_tree().current_scene.add_child(saw) # add instantiated scene to the current scene
	
	queue_free() # destroy telegraph once its done
