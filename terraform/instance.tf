
# resource "aws_instance" "minecraft_instance" {
# 	ami = ""
# 	instance_type = "t2.medium"
# 	key_name = "${var.key_name}"

# 	# Setup minecraft
# 	user_data = "curl -s https://raw.githubusercontent.com/s7tya/minecraft-server-config/master/setup.sh | sudo bash -"
# }

resource "aws_spot_instance_request" "minecraft_instance" {
	# Ubuntu 22.04 LTS (64bit (x86))
	ami = "ami-07200fa04af91f087"
	instance_type = "t2.medium"
	key_name = "${var.key_name}"
	instance_interruption_behavior = "stop"

	# Setup minecraft
	user_data = "curl -s https://raw.githubusercontent.com/s7tya/minecraft-server-config/master/setup.sh | sudo bash -"

}