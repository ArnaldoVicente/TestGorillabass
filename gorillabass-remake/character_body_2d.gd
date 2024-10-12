extends Node2D

# Variáveis para o pulo
var jump_force = Vector2(0, -200)  # Força do pulo
var gravity = 500  # Gravidade que afeta o gorila
var velocity = Vector2()  # Velocidade atual do gorila

# Variáveis de controle
var is_jumping = false  # Verifica se o gorila está no ar

# Referência à banana
var banana_scene = preload("res://Scenes/Banana.tscn")  # Certifique-se de ter o caminho correto para a cena da banana

func _ready():
	pass

func _physics_process(delta):
	if is_jumping:
		# Aplicar gravidade
		velocity.y += gravity * delta
		position.y += velocity.y * delta
		
		# Parar o pulo quando o gorila voltar ao solo
		if position.y >= 400:  # Supondo que o solo está na posição Y = 400
			position.y = 400
			velocity.y = 0
			is_jumping = false

# Função para lançar a banana e fazer o gorila pular
func arremessar_banana(angle, force):
	if not is_jumping:
		# Iniciar o pulo
		velocity.y = jump_force.y
		is_jumping = true
	
	# Criar e lançar a banana
	var banana = banana_scene.instance()
	get_parent().add_child(banana)
	banana.position = position  # A banana é lançada da posição do gorila
	
	# Aplicar uma força para a banana, ajustando ângulo e força
	banana.apply_impulse(Vector2.ZERO, Vector2(cos(angle) * force, sin(angle) * force))
