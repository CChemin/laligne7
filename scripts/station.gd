extends Button

@export var station_name: String
signal station_clicked(station_name: String)

func _ready():
	modulate.a = 0
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color.RED
	add_theme_stylebox_override("normal", stylebox)

func _pressed() -> void:
	emit_signal("station_clicked", station_name)
	
func shortly_appear() -> void:
	modulate.a = 1
	await get_tree().create_timer(2).timeout
	modulate.a = 0
