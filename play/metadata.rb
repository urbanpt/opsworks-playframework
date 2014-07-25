maintainer       "Samuel Martins"
maintainer_email "samuel.martins@gmail.com"
license          "Apache 2.0"
description      "Deploys play 1.2.5 app on OpsWorks (based on Torben Werner's work)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "play::build_app", "Builds a Play! application detected in the OpsWorks deploy stack JSON."
recipe "play::deploy_app", "Deploys a Play! application that was previously built."
recipe "play::play_app_service", "Defines the application as a service."
recipe "play::start_app", "Starts the Play! application service."
recipe "play::stop_app", "Stops the Play! application service."
