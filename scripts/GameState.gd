extends Node
var target_station: String
signal end_game(score)

@onready var stations_node = $CanvasLayer/Stations
@onready var station_label = $CanvasLayer/Page/Header/StationLabel
@onready var score_label = $CanvasLayer/Page/Header/ScoreLabel
@onready var timer_label = $CanvasLayer/Page/Header/TimerLabel
@onready var fail_sound = $Sounds/FailSound
@onready var success_sound = $Sounds/SuccessSound
@onready var timer = $Timer

var score = 0
var essai_restant = 3
var left_stations = []
var stations = []

func _on_timer_timeout():
	emit_signal("end_game", score)

func _ready():
	for station in stations_node.get_children():
		station.connect("station_clicked", Callable(self, "_on_station_clicked"))
		stations.push_front(station.station_name)
	init_stations_order()
	select_random_station()
	score_label.text = str(score)

func _process(delta: float) -> void:
	timer_label.text = str(int(timer.time_left + 1))
	
func init_stations_order():
	left_stations = stations.duplicate()
	left_stations.shuffle()

func select_random_station():
	if left_stations.size() > 0:
		target_station = left_stations.pop_front()
		station_label.text = target_station.substr(0,20)
	else:
		emit_signal("end_game", score)
		
func _on_station_clicked(clicked_name: String):
	if clicked_name == target_station:
		score = score + essai_restant
		select_random_station()
		score_label.text = str(score)
		success_sound.play()
		essai_restant = 3
	else:
		essai_restant = essai_restant - 1
		fail_sound.play()
	if essai_restant == 0:
		get_component_by_name(target_station).shortly_appear()
		select_random_station()
		essai_restant = 3

func _on_button_pressed() -> void:
	init_stations_order()
	select_random_station()
	essai_restant = 3
	score = 0
	score_label.text = str(score)
	timer.start()
	
func get_component_by_name(name: String) -> Node:
	for component in stations_node.get_children():
		if component.station_name == name:
			return component
	return null
