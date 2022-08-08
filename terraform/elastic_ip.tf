resource "aws_eip" "minecraft_eip" {
	instance = aws_instance.minecraft_instance.id	
}

output "server ip of minecraft" {
	value = "${aws_eip.minecraft_eip.public_ip}"
}