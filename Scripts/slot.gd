extends ColorRect

signal slot_clicked(slot)

# Reference Variables
@onready var filter_path = $Filter

var slot_ID := -1 # Create a Reference to the Slot
var state = DataHandler.slot_states.NONE # Defaukt the filter state to NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_background(c) -> void:
	color = c


func set_filter(color = DataHandler.slot_states.NONE):
	state = color
	match color: # Basically Switch
		DataHandler.slot_states.NONE:
			filter_path.color = Color(0,0,0,0) # Totally Transparent
		DataHandler.slot_states.FREE:
			filter_path.color = Color(0,1,0,0.4) # Vaugely Transparent (Green)
	
	pass


func _on_filter_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		emit_signal("slot_clicked", self)
