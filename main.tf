module "network" {
  source = "./NETWORK"
  cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
}
module "compute" {
  source          = "./COMPUTE"
  web_sg          = module.network.web_sg
  public_subnet_1 = module.network.public_subnet_1
}

