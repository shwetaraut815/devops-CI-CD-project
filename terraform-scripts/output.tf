output "public-ip-node-1" {
    value = aws_instance.project-node-1.id
}
output "public-ip-node-2" {
    value = aws_instance.project-node-2.id
}
output "public-ip-master" {
    value = aws_instance.project-automation-master
}