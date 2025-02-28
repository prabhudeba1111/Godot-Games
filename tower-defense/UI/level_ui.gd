extends Control


func updateHealth(value: int) -> void:
	$Stats/HealthPanel/HealthLabel.text = str(value)


func updateMoney(value: int) -> void:
	$Stats/MoneyPanel/MoneyLabel.text = str(value)
