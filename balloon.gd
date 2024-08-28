extends CharacterBody2D

# an on-ready var that accesses the hurtbox Node
# (created by click + alt dragging from heirarchy view)
@onready var hurtbox = $Hurtbox

# called once at game start
func _ready():
	# connect the hurtbox's body_entered signal to our function
	# syntax: ref.signal_recieved.connect(fxn_to_execute)
	hurtbox.body_entered.connect(on_hurtbox_body_entered)

# called every physics step
func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * 100
	move_and_slide()

func on_hurtbox_body_entered(body):
	# ask events script to emit our custom balloon_popped signal
	Events.balloon_popped.emit()
	
	# destory the balloon
	queue_free()
