extends Area3D
signal gameOver
signal deSpawn(value)
var value = 5
@export var speed : float = 10
@export_enum("Vertical","Horizontal") var type = 0
# 				= 0 		= 1

func _ready() -> void:
	# desplazar vertical
	if type == 0:
		position.y = randf_range(-7.5, 7.5)
	
	# desplazar horizontal
	if type == 1:
		rotation = Vector3(0, 0, PI/2)
		position.x = randf_range(-8.5, 8.5)
	
	position.z = -15
	speed += 0.3
	
func _on_body_entered(body: Player) -> void:
	# game over detection
	if body is Player:
		gameOver.emit()

func _physics_process(delta: float) -> void:
	#avanzar hacia la camara
	position.z += speed * delta
	
	#cuando el jugador lo esquive, se regresa, y aumenta los puntos
	if position.z > 6:
		_ready()
		deSpawn.emit(value)
