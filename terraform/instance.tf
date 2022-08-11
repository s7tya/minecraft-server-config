
resource "aws_instance" "minecraft_instance" {
  # Ubuntu 22.04 LTS (64bit (x86))
  ami                    = "ami-07200fa04af91f087"
  instance_type          = "t2.medium"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_security_group.id]
  subnet_id              = aws_subnet.minecraft_subnet.id

  # Setup minecraft
  # user_data = "curl -s https://raw.githubusercontent.com/s7tya/minecraft-server-config/master/setup.sh | sudo bash"
  user_data = file("../setup.sh")
}

# resource "aws_spot_instance_request" "minecraft_instance" {
#   # Ubuntu 22.04 LTS (64bit (x86))
#   ami                            = "ami-07200fa04af91f087"
#   instance_type                  = "t2.medium"
#   key_name                       = var.key_name
#   vpc_security_group_ids         = [aws_security_group.minecraft_security_group.id]
#   instance_interruption_behavior = "stop"
#   wait_for_fulfillment           = true

#   # Setup minecraft
#   user_data = "curl -s https://raw.githubusercontent.com/s7tya/minecraft-server-config/master/setup.sh | sudo bash"

# }
