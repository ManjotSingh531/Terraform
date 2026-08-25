#Key pair resource
resource "aws_key_pair" "gibs_key" {
    key_name = "gibs-key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#AWS Instance
resource "aws_instance" "myfirstinstance" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    key_name = aws_key_pair.gibs_key.key_name

    tags = {
        Name = "Gibs"
    }
}

#EBS volume resource
resource "aws_ebs_volume" "ebs-volume" {
    availability_zone = "ap-south-1b"
    size              = 50
    type              = "gp3"
    tags = {
        Name = "EBSVolume"
    }
}

#Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs-volume-attachment" {
    device_name = "/dev/xvdf"
    volume_id   = aws_ebs_volume.ebs-volume.id
    instance_id = aws_instance.myfirstinstance.id
}