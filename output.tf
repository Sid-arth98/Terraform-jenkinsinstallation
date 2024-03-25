output "public-ip" {
  value = aws_instance.jenkinsServer.public_ip
}
