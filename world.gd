extends Node2D

const TELEGRAPH_SCENE = preload("res://sawblade_telegraph.tscn") # load a "packed" scene

@onready var timer = $Timer
@onready var saw_count_label = $SawCountLabel

var saw_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(on_timeout)
	Events.balloon_popped.connect(timer.stop) # connect timer's stop method to our balloon_popped signal
	Events.saw_blade_added.connect(update_saw_count)

func update_saw_count():
	saw_count += 1
	saw_count_label.text = "Blades\n" + str(saw_count)

func on_timeout():
	var telegraph = TELEGRAPH_SCENE.instantiate()
	
	telegraph.position.x = randf_range(55, 265)
	telegraph.position.y = randf_range(10, 170)
	
	#get_tree().current_scene.add_child(telegraph)
	add_child(telegraph) # dont have to get_tree cause already in the world scene!

