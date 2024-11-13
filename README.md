# OpenStack on OpenShift Gitops

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repo is based on the [MultiCloud GitOps](https://github.com/validatedpatterns/multicloud-gitops) 
Validated Pattern.  The idea is to provide a way to automate the deployment of the 
components for OpenStack on OpenShift using the Validated Patterns GitOps approach.

[Live build status](https://validatedpatterns.io/ci/?pattern=mcgitops)

## Start Here

If you've followed a link to this repository, but are not really sure what it contains
or how to use it, head over to [Multicloud GitOps](https://validatedpatterns.io/patterns/multicloud-gitops/)
for additional context and installation instructions

## Rationale

The goal for this pattern is to:

* Use a GitOps approach to manage hybrid and multi-cloud deployments across both public and private clouds.
* Enable cross-cluster governance and application lifecycle management.
* Securely manage secrets across the deployment.

## Showroom template demo

To use this pattern you must deploy the Red Hat OpenStack Services on OpenShift catalog service
found on demo.redhat.com.  

We also followed the intructions found on the RHOSO deployment using OpenShift Gitops section
of the [showroom template demo document](https://rh-osp-demo.github.io/showroom_osp-on-ocp/modules/prereqs-argocd.html.


