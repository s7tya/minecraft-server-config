
resource "aws_security_group" "minecraft_security_group" {
  name        = "minecraft security group"
  description = "allow SSH and minecraft inbound traffic"
  vpc_id      = aws_vpc.minecraft_vpc.id

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.minecraft_security_group.id
}

resource "aws_security_group_rule" "allow_minecraft" {
  type      = "ingress"
  from_port = 25565
  to_port   = 25565
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.minecraft_security_group.id
}
