output "public_instance_ip" {
    value = ["${aws_instance.gibs_instance.public_ip}"]
}