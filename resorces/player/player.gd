extends Area2D

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var bullet_position = $BulletPosition

@export var Bullet : PackedScene

var angle = 90.0
var max_speed = 50
var speed = 0.0
var rotation_offset = 0.0
var target_position: Vector2

func player_move(direction: float, delta: float):
	speed = lerp(speed, -direction * max_speed * delta, 0.2)
	angle += speed
	
	target_position = Vector2(cos(deg_to_rad(angle)) * (Constant.half_screen_size.x - Constant.offset) + Constant.half_screen_size.x,
							  sin((deg_to_rad(angle))) * (Constant.half_screen_size.y - Constant.offset) + Constant.half_screen_size.y)
	position = target_position
	
	look_at(Constant.half_screen_size)
	
	rotation_offset = lerp(rotation_offset, 10.0 * direction, 0.2)
	rotation += deg_to_rad(rotation_offset)

func shoot():
	var bullet = Bullet.instantiate()
	bullet.transform = bullet_position.global_transform
	owner.add_child(bullet)

func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	player_move(direction, delta)
	
	if Input.is_action_just_pressed("shot"):
		shoot()
	
	
