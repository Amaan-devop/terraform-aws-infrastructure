
module "smart_asg" {
  source = "./modules/autoscalinggroup"
  app_name = "sample-app-api"
  subnets = ["",""]
  ami_id = ""
}