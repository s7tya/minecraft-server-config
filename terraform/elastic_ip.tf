resource "aws_eip" "minecraft_eip" {
  # instance = aws_instance.minecraft_instance.id
  instance = aws_spot_instance_request.minecraft_instance.spot_instance_id
  vpc      = true
}

output "server_ip_of_minecraft" {
  value = aws_eip.minecraft_eip.public_ip
}
