#!/bin/bash
for D in "$@"; do
  mkdir $D
  pushd $D
  touch main.tf outputs.tf variables.tf
  # TODO: get name without tf_
  cat <<MAIN >main.tf
/**
 * ${D} Terraform Module
 * =====================
 *
 * Module description
 *
 * Usage:
 * ------
 *
 *     module "${D}" {
 *       source      = "../${D}"
 *
 *       add variables
 *     }
**/

MAIN
  cat <<VARS >variables.tf
/**
 *  Variables for ${D}
**/

// Standard Variables

variable "name" {
  description = "Name"
}
variable "environment" {
  description = "Environment (ex: dev, qa, stage, prod)"
}
variable "namespaced" {
  description = "Namespace all resources (prefixed with the environment)?"
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

// Module specific Variables

VARS
  cat <<OUTPUT >outputs.tf
/**
 *  Outputs for ${D}
**/

// description
output "out_var" {
  value = "\${source_var}"
}

OUTPUT
  cat <<IGNORE >.gitignore
.terraform*
!terraform.tfstate*
terraform.*
IGNORE
  git init
  git add -A
  git commit -m 'Initial Terraform module stub'
  popd
done
