extends CanvasLayer #Dialouge Box

#var tween = create_tween()

const CHAR_READ_RATE = 1.3
var textbox_visable = true

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	print("Starting state: State.READY")
	queue_text("Reu: Your experiment went ape-shit and now your grimoire's pages are scattered throughout the tower.")
	queue_text("Reu: Your pages developed sentience, mutating into page-monsters.")
	queue_text("Reu: Clear each room in order to progress upwards and rebind your spellbook.")
	queue_text("Reu: Grow your power by picking up the defeated pages.")
	queue_text("Reu: ...and maybe don't die in the process-- I hear that kills you.")
	

func _process(delta):
	match current_state:
		State.READY:
			if not text_queue.is_empty():
				display_text()
		State.READING:
			#if Input.is_action_just_pressed("ui_accept"):
				#label.visible_ratio = 1.0
				#tween.remove_all()
				#end_symbol.text = "v"
				#change_state(State.FINISHED)
				pass
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
				

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 0.0, 0)
	tween.tween_property(label, "visible_ratio", 1.0, CHAR_READ_RATE)
	tween.connect("finished", _on_tween_complete, 0)
	
func _on_tween_complete():
	print ("if you can see then this worked")
	end_symbol.text = "[Space]"
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")

func toggle_textbox():
	if textbox_visable:
		textbox_container.hide()
		textbox_visable = false
		#GameManager.toggle_pause()
	else:
		textbox_container.show()
		textbox_visable = true
		#GameManager.toggle_pause()
	
