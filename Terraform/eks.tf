module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-mastery"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Enables EKS Access Entries API natively
  authentication_mode = "API_AND_CONFIG_MAP"

  eks_managed_node_groups = {
    system_nodes = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"] # Smallest reliable instance size for core components

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}
