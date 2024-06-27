packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "prerequisites-win-dotnet" {
  ami_name       = "prerequisites-win-dotnet-${local.timestamp}"
  communicator   = "winrm"
  instance_type  = "t3.micro"
  region         = "${var.region}"
  source_ami     = "ami-0e94f1103762e84a6"
  user_data_file = "./bootstrap_win.txt"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

build {
  name    = "prerequisites_win_dotnet"
  sources = ["source.amazon-ebs.prerequisites-win-dotnet"]

  provisioner "powershell" {
    environment_vars = ["DEVOPS_LIFE_IMPROVER=PACKER"]
    inline           = ["Write-Host \"HELLO NEW USER; WELCOME TO $Env:DEVOPS_LIFE_IMPROVER\"", "Write-Host \"You need to use backtick escapes when using\"", "Write-Host \"characters such as DOLLAR`$ directly in a command\"", "Write-Host \"or in your own scripts.\""]
  }
  provisioner "windows-restart" {
  }
  provisioner "powershell" {
    environment_vars = ["VAR1=A$Dollar", "VAR2=A`Backtick", "VAR3=A'SingleQuote", "VAR4=A\"DoubleQuote"]
    script           = "./sample_script.ps1"
  }
  provisioner "powershell" {
    scripts = ["scripts/install_dotnet_and_git.ps1"]
  }
}


