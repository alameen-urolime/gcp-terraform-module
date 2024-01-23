module "cloud_build_triggers" {
  source                  = "./modules/cloudbuild"  
  trigger                 = var.trigger
  git-username            = var.git-username
  git-repo                = var.git-repo
  branches                = var.branches
}

module "gcp_networking" {
  source                   = "./modules/vpc"
  cluster_name             = var.cluster_name
  cluster_location         = var.cluster_location
  region                   = var.region
  standard_machine_type    = var.standard_machine_type
  vpc                      = var.vpc
  project                  = var.project
  gke_subnet_name          = var.gke_subnet_name
  gke_subnet_cidr          = var.gke_subnet_cidr
  gke_subnet_cluster_cidr  = var.gke_subnet_cluster_cidr
  gke_subnet_services_cidr = var.gke_subnet_services_cidr
  gke_subnet_region        = var.gke_subnet_region
  ports                    = var.ports
  source_ranges            = var.source_ranges
  source_ip_ranges_to_nat  = var.source_ip_ranges_to_nat
  jump-host                = var.jump-host
  
}

module "gke_cluster" {
  source                      = "./modules/gke" 
  region                      = var.region
  project                     = var.project
  cluster_name                = var.cluster_name
  cluster_location            = var.cluster_location
  vpc                         = module.gcp_networking.vpc_self_link
  gke_subnet_name             = module.gcp_networking.subnet_self_link
  gke_subnet_cidr             = var.gke_subnet_cidr
  gke_subnet_cluster_cidr     = var.gke_subnet_cluster_cidr
  gke_subnet_services_cidr    = var.gke_subnet_services_cidr
  master_ipv4_cidr_block      = var.master_ipv4_cidr_block
  gke_subnet_region           = var.gke_subnet_region
  min-master-version          = var.min_master_version
  standard_min_node_count     = var.standard_min_node_count
  standard_max_node_count     = var.standard_max_node_count
  standard_machine_type       = var.standard_machine_type
}

module "jump-host" {
  source                      = "./modules/bastionhost"
  zone                        = var.zone
  project                     = var.project
  jump-host                   = var.jump-host
  jump-machine                = var.jump-machine
  vpc                         = module.gcp_networking.vpc_self_link
  gke_subnet_name             = module.gcp_networking.subnet_self_link
  vm_image                    = var.vm_image
  pritunlfile                 = var.pritunlfile
}