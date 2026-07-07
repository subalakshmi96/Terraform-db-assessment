module "network" {

  source = "../../modules/network"

  region = var.region

  project_name = var.project_name

  vpc_cidr = "10.0.0.0/16"

  public_subnet_1 = "10.0.1.0/24"

  public_subnet_2 = "10.0.2.0/24"

  private_subnet_1 = "10.0.3.0/24"

  private_subnet_2 = "10.0.4.0/24"
}

module "ecs" {

  source = "../../modules/ecs"

  project_name = var.project_name

  vpc_id = module.network.vpc_id

  public_subnets = module.network.public_subnet_ids

  private_subnets = module.network.private_subnet_ids
}
