output "alb_dns_name" {

  value = aws_lb.alb.dns_name
}

output "ecs_security_group_id" {

  value = aws_security_group.ecs_sg.id
}

output "ecs_cluster_name" {

  value = aws_ecs_cluster.cluster.name
}
