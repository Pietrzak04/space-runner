extends Area2D

@onready var sprite = $Sprite2D
@export var bullet_speed = 400

const destroy_radious = 0.10;

var distance_to_center: float

func _ready():
	look_at(Constant.half_screen_size)
	distance_to_center = position.distance_to(Constant.half_screen_size)
	
	bullet_speed = distance_to_center * bullet_speed / (Constant.half_screen_size.y - Constant.offset)

func _physics_process(delta):
	var distance_percentage = position.distance_to(Constant.half_screen_size) / distance_to_center
	scale.x = distance_percentage
	scale.y = distance_percentage
	
	position = position.move_toward(Constant.half_screen_size, distance_percentage * bullet_speed * delta)
	
	if distance_percentage < destroy_radious:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("destructible"):
		body.queue_free()
	queue_free()
