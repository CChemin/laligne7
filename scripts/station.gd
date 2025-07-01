extends Button

@export var station_name: String
signal station_clicked(station_name: String)

func _ready():
	modulate.a = 0
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	var stylebox: StyleBox = get_theme_stylebox("normal")
	stylebox.bg_color = "#ff0000"
	add_theme_stylebox_override("normal", stylebox)

func _pressed() -> void:
	emit_signal("station_clicked", station_name)
	
func shortly_appear() -> void:
	modulate.a = 1
	modulate = Color(1, 0, 0, 1)
	await get_tree().create_timer(2).timeout
	modulate.a = 0
