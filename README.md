The Containers and Cloud-Native Roadshow Installer
===

This repositpry enables you to create **the Containers and Cloud-Native Roadshow - Dev Track**
by deploying required services (lab instructions, CodeReady Workspace, RH-SSO, RHAMT, Istio, and more) which are used during the labs.

Prerequisites
===

Assumes you have a running OpenShift 4 cluster(i.e. RHPDS) and have:

- [yq](https://github.com/mikefarah/yq) (YAML processor)
- [jq](https://github.com/stedolan/jq) (JSON processor)
- OpenShift 4 CLI `oc` for your environment from https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/.

IMPORTANT
=====

If you not have OCP4 cluster then please proceed to https://try.openshift.com[try.openshift.com] to get one 
installed and configured before proceeding to next section.

Create a new Lab Environment
===

Login to OpenShift with `cluster-admin` privileges and run. If you want to run on RHPDS, use `opentlc-mgr` credential:

[source, none]
```
setup/preparelab_ccn.sh -c [COUNT] -m [MODUEL_TYPE]

example: setup/preparelab_ccn.sh -c 50 -m m1,m2,m3,m4
```

Delete an exsiting Lab Environment
===

Login to OpenShift with `cluster-admin` privileges and run. If you want to run on RHPDS, use `opentlc-mgr` credential:

[source, none]
```
setup/resetlab_ccn.sh
```
