# Cerebro plugin in Origin Aggregated Logging
This repository contains documentation and artifacts necessary for deploying [Cerebro](https://github.com/lmenezes/cerebro) in the [Origin Aggregated Logging](https://github.com/openshift/origin-aggregated-logging) project.
The AOL stack is expected to be already running.

### Installation
Deploy Cerebro with the template:
```
oc create -f cerebro.yaml
oc new-app --template=logging-es-cerebro -p CEREBRO_SECURE_URL=<your_cerebro_url>
# enter CEREBRO_SECURE_URL without the 'https://' prefix
```
This deploys all of the necessary artifacts, with sensible default values.

Now, a new pod has been created in the logging project and Cerebro is available
under `CEREBRO_SECURE_URL`. The pod consists of two containers:
1. Oauth proxy, that authenticates users against OpenShift API server
2. The Cerebro container

If you need a customized deployment, check out the available parameters in the
template.

### Troubleshoot
```
oc describe pod <logging-es-kopf-pod-name>
oc logs -c logging-es-cerebro <logging-es-cerebro-pod-name>
oc logs -c logging-es-cerebro-auth-proxy <logging-es-cerebro-pod-name>
```

### Uninstall
```
oc delete all -l logging=logging-es-cerebro
oc delete OAuthClient cerebro-proxy
```
