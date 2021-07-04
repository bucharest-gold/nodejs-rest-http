[![Build Status](https://travis-ci.org/nodeshift-starters/nodejs-rest-http.svg?branch=master)](https://travis-ci.org/nodeshift-starters/nodejs-rest-http) [![Coverage Status](https://coveralls.io/repos/github/nodeshift-starters/nodejs-rest-http/badge.svg?branch=master)](https://coveralls.io/github/nodeshift-starters/nodejs-rest-http?branch=master) [![Greenkeeper badge](https://badges.greenkeeper.io/nodeshift-starters/nodejs-rest-http.svg)](https://greenkeeper.io/)

## Running The Example

You can run this example as node processes on your localhost, as pods on a local
[code-ready-containers](https://developers.redhat.com/products/codeready-containers/overview) installation.

### Localhost

To run the basic application on your local machine, just run the commands bellow:

```
$ npm install
$ npm start
```

If you want debug information, you can set `DEBUG` environment variable and start the application:

```
$ DEBUG=* npm start
```

This will launch the application on port 8080.

### CodeReady Containers

CRC should be started, and you should be logged in with a currently
active project. Then run the `npm run openshift` command.

```sh
$ crc setup # Set-up the hypervisor
$ crc start # Initialize the openshift cluster
$ oc login -u developer # Login
$ oc new-project my-example-project # Create a project to deploy to
$ npm run openshift # Deploys the example app
```

This app has an example of integration test using an [integration test tool for Node.js apps on OpenShift](https://github.com/nodeshift/rhoaster)

Once you started your local OpenShift instance you can check it out by running the following commands:

```
npm run test:integration
```

It will deploy the app to local OpenShift and run the tests located on `test/integration` directory.

```
npm run test:integration:undeploy
```

Performs undeploy of the app inside local OpenShift.

### Helm


To deploy the app via Helm you will need docker installed and a kubernetes cluster.

First build the docker image


```sh
docker build -t nodejs-rest-http:1.0.0 .
```

Once the image is built, you can deploy it to you kube cluster using helm. From within the top directory run:

```sh
helm install test-app ./nodejs-rest-http-helm
```

This deploys the app to your kube cluster and will output a series of commands depending on what options you have chosen (options like did you set up an ingress and what routing are you using). 


An example of the output can be seen below, this example gives you commands to set the auto-generated pod name and the container port to environment variable so you can just run one command which set up the port-forwading for that port. This allows you to access and communicate with the pod from outside the kubernetes cluster. 


```sh
NAME: test-app
LAST DEPLOYED: Thu Nov 12 15:33:24 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=nodejs-rest-http-helm,app.kubernetes.io/instance=test-app" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

To undeploy the app simply run:

```sh
helm uninstall test-app
```


Openshift vs Kube - Command line option
