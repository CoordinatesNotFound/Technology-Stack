# Kubernetes





## 1 Kubernetes Basic

> 【References】
>
> - Intro
>   - [What is Kubernetes? | DigitalOcean](https://www.digitalocean.com/community/tutorials/an-introduction-to-kubernetes)
>   - [Glossary | Kubernetes](https://kubernetes.io/docs/reference/glossary/?fundamental=true)
>   - [Kubernetes Documentation | Kubernetes](https://kubernetes.io/docs/home/)
>
> - Running a cluster
>   - Kind
>     - Intro: kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
>     - Guide: [kind](https://kind.sigs.k8s.io/)
>   - Minikube
>     - Intro: minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.
>     - Guide: [minikube start | minikube](https://minikube.sigs.k8s.io/docs/start/)
>
> - Command line
>   - Kubectl
>     - Intro: provided by Kubernetes, which is a command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
>     - Guide
>       - [Command line tool (kubectl) | Kubernetes](https://kubernetes.io/docs/reference/kubectl/)
>       - [kubectl Cheat Shee t | Kubernetes](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
> - Plugin Manager
>   - Krew 
>     - Intro: Krew is the plugin manager for `kubectl` command-line tool
>     - Guide: [User Guide · Krew](https://krew.sigs.k8s.io/docs/user-guide/)



### 1.1 Cluster Architecture

- Purpose of kubernetes
  - To host your applications in the form of containers in an automated fashion so that you can easily deploy as many as instances of your application as required and easily enable communication between different services within your application

- Architecture

  > `kubectl get pods --namespace=kube-system`

  - Master - manage, plan, schedule, monitor nodes
    - ETCD - a database that store information in a key-value format
    - Kube-Scheduler - identifies the right node to place a container on based on the containers resource requirements. the worker nodes capacity or any other policies
    - Kube-Controller-Manager
      - Node-Controller - onboards new nodes to the cluster, handles situation where nodes become unavailable or get destroyed
      - Replication-Controller - ensures that the desired number of containers are running at all times in an application group
    - Kube-Apiserver - orchestrate all operations within the cluster; exposes Kubernetes API used by external users to perform management operations on the cluster, used by various controllers to monitor the state of cluster and make necessary changes as required, used by Worker Nodes to communicate with servers
  - Worker Nodes - host applications as containers
    - Container Runtime Engine - Run containers, e,g, Docker
    - Kubelet - an agent that runs on each node; listens for instructions from the kube-Apiserver and destroys or deploys containers on the node as required
    - Kube-proxy - ensure that necessary services are in place for the containers to reach each other

- Docker vs ContainerD
  - [containerd vs. Docker | Docker](https://www.docker.com/blog/containerd-vs-docker/)



### 1.2 API Primitives

- Pod

  - Concept

    - a single instance of application
    - usually one-to-one relation with the container application
    - one pod can have multiple containers

  - Pod with YAML

    ```yaml
    apiVersion: apps/v1 # version of kubernetes api
    kind: Pod # type of the resource
    metadata: # meta data
    	name: myapp-pod 
    	labels:
    		app: myapp
    		type: fronte-end
    spec: # specification of the pod and container
    	containers:
    	 - name: nginx-container
    	 	 image: nginx
    ```

  - Commands for pods
    ```bash
    # create and run a pod
    kubectl run <pod-name> --image <image> -l "<key>=<value>" --port=<exposed-port>
    
    # delete a pod
    kubectl delete pod <pod-name>
    
    # check all pods
    kubectl get po
    
    # check the detail of a pod
    kubectl describe pod <pod-name>
    
    # edit the pod
    kubectl edit pod <pod-name>
    ```

- ReplicaSet

  - Concept
    - controller for replicas of pods
    - ReplicaSet is the advanced version of ReplicationController

  - ReplicationController with YAML

    ```yaml
    apiVersion: v1 
    kind: ReplicationController 
    metadata: 
    	name: myapp-rc 
    	labels:
    		app: myapp
    		type: fronte-end
    spec:
    	template:
    		metadata: 
    		name: myapp-pod 
    		labels:
    			app: myapp
    			type: fronte-end
    		spec: 
    			containers:
    	 		- name: nginx-container
    	 	 		image: nginx
    	 replicas: 3
    ```

  - ReplicaSet with YAML
    ```yaml
    apiVersion: apps/v1 
    kind: ReplicaSet 
    metadata: 
    	name: myapp-rs
    	labels:
    		app: myapp
    		type: fronte-end
    spec: 
    	template:
    		metadata: 
    		name: myapp-pod 
    		labels:
    			app: myapp
    			type: fronte-end
    		spec: 
    			containers:
    	 		- name: nginx-container
    	 	 		image: nginx
    	 replicas: 3 # number of replicas
    	 selector: # select the pod under the replicaset
    	 	matchLabels:
    	 		app: myapp
    ```

  - Commands for ReplicaSet
    ```bash
    # create a replicaset 
    kubectl create -f replicaset-definition.yaml
    
    # delete a replicaset 
    kubectl delete replicaset <replicaset-name>
    
    # get all replicaset
    kubectl get replicaset
    
    # edit a replicaset
    kubectl edit replicaset <replicaset-name>
    
    # scale
    kubectl scale --replicas=6 replicaset <replicaset-name>
    ```

- Deployment

  - Concept

    - a kubernetes object that comes higher in hierachy
    - provides the capability to upgrade the underlying instances seamlessly using rolling updates and undo/pause/resume changes

  - Deployment with YAML

    ```yaml
    apiVersion: apps/v1 
    kind: Deployment 
    metadata:
    	name: myapp-deployment
    	labels:
    		app: myapp
    		type: fronte-end
    spec:
    	template:
    		metadata: 
    		name: myapp-pod 
    		labels:
    			app: myapp
    			type: fronte-end
    		spec: 
    			containers:
    	 		- name: nginx-container
    	 	 		image: nginx
    	 replicas: 3
    	 selector: 
    	 	matchLabels:
    	 		app: myapp
    ```

  - Commands for Deployment
    ```bash
    # check all deployments
    kubectl get deployment
    
    # create a deployment
    kubectl create deployment --image=nginx nginx
    
    # generate a yaml file without creating an instance
    kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > xxx-deployment.yaml
    ```

- Service

  - Concept

    - a kubernetes object that can be used to expose ports on the node and forward the request to the pod

  - Services Type

    - NodePort
    - ClusterIP
    - LoadBalancer

  - Commands for Services
    ```bash
    # check all services
    kubectl get services
    
    # check a service
    kubectl describe service <service-name>
    
    # create a service named redis-service of type ClusterIP to expose pod redis on port 6379
    kubectl expose pod redis --port=6379 --name redis-service --type ClusterIP --dry-run=client -o yaml
    # or
    kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
    ```

  - NodePort

    - Function

      - to realize the port forwarding from the port that node exposed to external to the pod

    - 3 Ports

      - TargetPort - the request forwarded to by service
      - Port - on the service itself
      - NodePort - used to access the service externally (range 30000-32767)

    - Port Forwarding:

      1. external access to the NodePort of the node;
      2. the NodePort Service realize the port mapping from the NodePort to TargetPort on each selected pod, without any additional configuration in any case
         - Multiple pods in one node - a random algorithm applied to realize the load balancing acrross different pods
         - Single/Multiple pods in multiple nodes - port mapping in all selected pods in all nodes

    - NodePort with YAML
      ```yaml
      apiVersion: v1 
      kind: Service
      metadata: 
      	name: myapp-service
      spec: 
      	type: NodePort
      	ports:
      		- targetPort: 80 # default to be the same as port
      			port: 80 # mandatory
      			nodePort: 30008 # default to be a free port available within 30000-32767
      	selector: # select the pod 
      		app: myapp
      		type: front-end
      ```

  - ClusterIP

    - Function

      - to group the pods and provide a single interface to access the pods

    - 2 Ports

      - TargetPort - the request forwarded to by service
      - Port - on the service itself, exposed to others

    - ClusterIP with YAML
      ```yaml
      apiVersion: v1 
      kind: Service
      metadata: 
      	name: back-end
      spec: 
      	type: ClusterIP
      	ports:
      		- targetPort: 80 # default to be the same as port
      			port: 80 # mandatory
      	selector: # select the pod 
      		app: myapp
      		type: back-end
      ```

  - LoadBalancer

    - Function

      - to route traffic to different nodes and realize the load balaning
      - only works when there is supporting cloud provider (and generates a public IP for the service), or it turns to NodePort

    - LoadBalancer with YAML
      ```yaml
      apiVersion: v1 
      kind: Service
      metadata: 
      	name: myapp-service
      spec: 
      	type: LoadBalancer
      	ports:
      		- targetPort: 80 # default to be the same as port
      			port: 80 # mandatory
      			nodePort: 30008 # default to be a free port available within 30000-32767
      	selector: # select the pod 
      		app: myapp
      		type: front-end
      ```



### 1.3 Namespaces

- Concept

  - To isolate different set of kubernetes objects

- Existing Namespaces

  - `default`
  - `kube-system`
  - `kube-public`

- Features

  - Policies
  - Resource Limits
  - ...

- DNS

  - access another service in another namespace: `<service-name>.<namespace-name>.svc.cluster.local`

- Commands for Namespace
  ```bash
  # get pods within one namespace
  kubectl get pods --namespace=<namespace-name>
  
  # get pods with all namespaces
  kubectl get pods --all-namespaces
  
  # create a namespace
  kubectl create namespace <namespace-name>
  
  # switch namespace
  kubectl config set-context --current --namespace=<namespace-name>
  ```

- Namespace with YAML
  ```yaml
  apiVersion: v1
  kind: Namespace
  metadata:
  	name: dev
  ---
  # ...
  metadata: 
  	name: myapp-service
  	namespace: dev
  # ...
  ```



### 1.4 Others

- Imperative vs Declarative
  - Imperative - provide the steps to conduct, using command
  - Declarative - provide the expected status, using configuration files

- Kuberctl Apply Command

  - Command
    - `kubectl apply -f xxx.yaml`

  - Mechanism
    1. if object not exists, then create a Live Object Configuration with additional information (stored internally in kubernetes memory)
    2. always update the Last Applied Configuration (in JSON) if any changes in Live Object Configuration





## 2 Scheduling



### 2.1 Manual Scheduling

- Specify the Node with YAML
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
  	name: nginx
  	labels:
  		name: nginx
  spec:
  	containers:
  		- name: nginx
  			image: nginx
  			ports:
  				- containerPort: 8080
  	nodeName: node02 # the node to be assigned, only valid when created!
  ```

- Binding
  ```yaml
  apiVersion: v1
  kind: Binding
  metadata:
  	name: nginx
  	target:
  		apiVersion: v1
  		kind: Node
  		name: node02 # the node to be binded
  ```

  



### 2.2 Labels & Selectors

- Concept

  - Labels - properties attached to objects
  - Selectors - filters used to select objects based on labels

- Commands
  ```bash
  # label
  kubectl run myapp -l key=value
  
  # select
  kubectl get pods --selector key=value
  ```

  

### 2.3 Taints & Tolerations

- Concept

  - Taints - a property of a node that "repels" pods

    > Master Node is tainted as it is initiated

  - Tolerations - a way for a pod to tell Kubernetes that it's willing to tolerate being scheduled on a node with certain taints

- Taint Effects

  - `NoSchedule` - prevents new pods from being scheduled onto a node unless the pod has a matching toleration for the taint
  - `PreferNoSchedule` - similar to `NoSchedule`, but it only recommends that new pods are not scheduled onto a node unless the pod has a matching toleration for the taint; if there are no other suitable nodes available, Kubernetes may still schedule pods onto nodes with taints that have this effect
  - `NoExecute` - existing pods that do not tolerate the taint will be evicted from the node; however, new pods with matching tolerations can still be scheduled onto the node

- Commands for Taints
  ```bash
  # create a taint for a node
  kubectl taint node <node-name> <key>=<value>:<taint-effect>
  
  # delete a taint of a node
  kubectl taint node <node-name> <key>-
  ```

- Tolerations with YAML

  ```yaml
  # spec:
  	tolerations:
  		- key: "app"
  			operation: "Equal"
  			value: "blue"
  			effect: "NoSchedule"
  ```



### 2.4 Node Labels & Selectors

- Concept

  - set a limitation on the pod that they only run on desired node

- Commands for Node Labels
  ```bash
  # label a node
  kubectl label node <node-name> <key>=<value>
  ```

- NodeSelector with YAML
  ```yaml
  # spec:
  	nodeSelector:
  		size: Large
  ```



### 2.5 Node Affinity

- Concept

  - provides advanced capabilities to limit pod placement on specific nodes

- Node Affinity Types

  - `requiredDuringSchedulingIgnoredDuringExecution`
  - `preferredDuringSchedulingIgnoredDuringExecution`
  - `requiredDuringSchedulingRequiredDuringExecution`

- NodeAffinity with YAML

  ```yaml
  # spec:
  	affinity:
  		nodeAffinity:
  			requiredDuringSchedulingIgnoredDuringExecution:
  				nodeSelectorTerms:
  					- matchExpressions:
  						- key: size
  							operator: In
  							values: 
  								- Large
  								- Medium
  
  ```

  

### 2.6 Resource Requests and Limits

- Concept

  - when a pod is created, it looks for a node that has enough cpu and memory resource for it, or it is pending

- Resource

  - CPU

    - `1` - 1 AWS vCPI / 1 GCP Core / 1 Azure Core / 1 Hyperthread

  - Memory

    - `1 G` - 1,000,000,000 bytes (1 Gigabyte)

    - `1 M` - 1,000,000 bytes (1 Megabyte)
    - `1 K` - 1,000 bytes (1 Kilobyte)
    - `1 Gi` -  1,073,741,824 bytes (1 Gibibyte)
    - `1 Mi` -  1,048,576 bytes (1 Mebibyte)
    - `1 Ki` - 1,024 bytes (1 Kibibyte)

- Resource Requests & Limits with YAML
  ```yaml
  # spec.containers.:
  	resources:
  		requests:
  			memory: "4Gi"
  			cpu: 2
  		limits:
  			memory: "10Gi"
  			cpu: 10
  ```

- Behavior

  - Default - no requests, no limits

  - For CPU - set requests, no limits

    > CPU can throttle

  - For Memory - set requests, set limits

    > Out Of Memory

- Resource Quotas

  - ResourceQuota with YAML
    ```yaml
    apiVersion: v1
    kind: ResourceQuota
    metadata:
    	name: compute-quota
    	namespace: dev
    spec:
    	hard:
    		pods: 10
    		requests.cpu: "4"
    		requests.memory: 5Gi
    		limits.cpu: "10"
    		limits.memory: 10Gi
    ```

    



### 2.7 Daemon Sets

- Concept
  - help run instances of pods, but run one pod on each node
  - whenever a new node is made, a replica of the pod is added to it
  - whenver a node is removed, the pod is removed
- Use Case
  - Monitoring Solution
  - Logs Viewer
  - Kube-proxy
  - Networking Solution
  - ...

- DaemonSet with YAML
  ```yaml
  apiVersion: apps/v1 
  kind: DaemonSet
  metadata: 
  	name: monitoring-daemon
  spec: 
  	selector: 
  	 	matchLabels:
  	 		app: monitoring-agent
  	template:
  		metadata: 
  			name: monitoring-agent
  			labels:
  				app: monitoring-agent
  			spec: 
  				containers:
  	 			- name: monitoring-agent
  	 	 			image: monitoring-agent
  
  ```

- Commands for DaemonSet
  ```bash
  # get daemonsets
  kubectl get daemonsets
  
  # check one daemonset
  kubectl describe daemonset <daemonset-name>
  ```



### 2.8 Static Pods

- Concept
  - pods that are created by the kubelet on its own without intervention of kube-apiserver or other components
  - the kubelet works at the pod level and can only understand pods
  - the static pod has a mirror in the kube-apiserver, and can only be viewed not deleted or edited

- Static Pods Paths

  1. check the option pod-manifest-path in the kubelet.service file
     ```bash
     ps -aux | grep kubelet
     ```

  2. if it's not there, then look at the configure option and identify the file used as config file

  3. within config file, look for the statisPodPath option

- Use Case

  - deploy control plane components

- Operations
  ```bash
  # create a static pod
  # 1. define a definition file (yaml) 
  # 2. move the file to static pod path
  
  # edit a static pod
  # 1. edit the file
  # 2. save it
  
  # delete a static pod
  # 1. find the node ip using `kubectl get nodes -o wide`
  # 2. ssh the node
  # 3. find the static pod path and delete it
  ```



### 2.9 Multiple Schedulers

- Deploy Multiple Schedulers

  - Deploy Schedulers as Binaries

    ```bash
    wget "https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler"
    
    chmod +x kube-scheduler 
    sudo mv kube-scheduler /usr/local/bin/
    sudo mv kube-scheduler.kubeconfig /var/lib/kubernetes/
    
    cat <<EOF | sudo tee /etc/kubernetes/config/kube-scheduler.yaml
    apiVersion: componentconfig/v1alpha1
    kind: KubeSchedulerConfiguration
    clientConnection:
      kubeconfig: "/var/lib/kubernetes/kube-scheduler.kubeconfig"
    leaderElection:
      leaderElect: true
    EOF
    
    cat <<EOF | sudo tee /etc/systemd/system/kube-scheduler.service
    [Unit]
    Description=Kubernetes Scheduler
    Documentation=https://github.com/kubernetes/kubernetes
    
    [Service]
    ExecStart=/usr/local/bin/kube-scheduler \\
      --config=/etc/kubernetes/config/kube-scheduler.yaml \\
      --v=2
    Restart=on-failure
    RestartSec=5
    
    [Install]
    WantedBy=multi-user.target
    EOF
    
    
    sudo systemctl daemon-reload
    sudo systemctl enable kube-scheduler
    sudo systemctl start kube-scheduler
    ```

  - Deploy Additional Schedulers as Pods

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
    	name: my-custom-scheduler
    	namespace: kube-system
    spec:
    	containers:
    		- command:
    				- kube-scheduler
    				- --address=127.0.0.1
    				- --kubeconfig=/etc/kubernetes/scheduler.conf
    				- --leader-elect=true
    			image: k8s.gcr.io/kube-scheduler-amd64:v1.11.3
    			name: my-custom-scheduler
    ```

  - Deploy Additional Schdulers as Deployments with features

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: my-scheduler
      namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: my-scheduler-as-kube-scheduler
    subjects:
    - kind: ServiceAccount
      name: my-scheduler
      namespace: kube-system
    roleRef:
      kind: ClusterRole
      name: system:kube-scheduler
      apiGroup: rbac.authorization.k8s.io
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: my-scheduler-config
      namespace: kube-system
    data:
      my-scheduler-config.yaml: | # schduler as a profile
        apiVersion: kubescheduler.config.k8s.io/v1beta2
        kind: KubeSchedulerConfiguration
        profiles:
          - schedulerName: my-scheduler
        leaderElection:
          leaderElect: false    
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: my-scheduler-as-volume-scheduler
    subjects:
    - kind: ServiceAccount
      name: my-scheduler
      namespace: kube-system
    roleRef:
      kind: ClusterRole
      name: system:volume-scheduler
      apiGroup: rbac.authorization.k8s.io
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        component: scheduler
        tier: control-plane
      name: my-scheduler
      namespace: kube-system
    spec:
      selector:
        matchLabels:
          component: scheduler
          tier: control-plane
      replicas: 1
      template:
        metadata:
          labels:
            component: scheduler
            tier: control-plane
            version: second
        spec:
          serviceAccountName: my-scheduler
          containers:
          - command:
            - /usr/local/bin/kube-scheduler
            - --config=/etc/kubernetes/my-scheduler/my-scheduler-config.yaml
            image: gcr.io/my-gcp-project/my-kube-scheduler:1.0
            livenessProbe:
              httpGet:
                path: /healthz
                port: 10259
                scheme: HTTPS
              initialDelaySeconds: 15
            name: kube-second-scheduler
            readinessProbe:
              httpGet:
                path: /healthz
                port: 10259
                scheme: HTTPS
            resources:
              requests:
                cpu: '0.1'
            securityContext:
              privileged: false
            volumeMounts:
              - name: config-volume
                mountPath: /etc/kubernetes/my-scheduler
          hostNetwork: false
          hostPID: false
          volumes: # mount the condig-volume
            - name: config-volume
              configMap:
                name: my-scheduler-config
    
    ```

- Use Custom Scheduler

  ```bash
  # spec:
  	schedulerName: my-custom-scheduler
  ```

- View Events

  ```bash
  kubectl get events -o wide
  ```

- View Scheduler Logs

  ```bash
  kubectl logs my-custom-scheduler --name-space=kube-system
  ```



### 2.10 Scheduler Profile

- Scheduling Process

  | Phase            | Description                                                  | Plugin                                        |
  | ---------------- | ------------------------------------------------------------ | --------------------------------------------- |
  | Scheduling Queue | waiting to be scheduled, sorted based on priority            | PrioritySort                                  |
  | Filtering        | filter out the NODEs that donot have enough resouces to hold pods | NodeResourcesFit, NodeName, NodeUnschedulable |
  | Scoring          | score th NODEs                                               | NodeResourcesFit, ImageLocality               |
  | Binding          | bind the pods to nodes                                       | DefaultBinder                                 |

- Scheduler Profile
  ```yaml
  # scheduler-config.yaml
  
  profiles:
  	- schedulerName: my-scheduler
  		plugins: 
  			disabled:
        	- name: TaintToleration
  			enable:
  				- name: MyPluginA
  				- name: MyPluginB
  ```

  





## 3 Logging & Monitoring



### 3.1 Monitoring

- Concept
  - to get, store and analyze the metrics of clusters

- Monitoring Solutions

  - Metrics Server (Heapster)

    - in-memory, get metrics from kubelet api
    - use: `minikube addons enable metric-server`

  - View
    ```bash
    kubectl top node/pod
    ```



### 3.2 Logging

- Concept
  - records of the cluster

- Commands for Logging

  - One Container in Pod
    ```bash
    kubectl logs -f <pod-name> 
    ```

  - Muliple Containers in Pod
    ```bash
    kubectl logs -f <pod-name> <container-name>
    ```

    

  

## 4 Application Lifecycle Management



### 4.1 Rolling Updates and Rollbacks

- Deployment Strategy

  - Recreate
    - delete all instances and then create new instances
  - Rolling Updates
    - update/replace instances few at a time

- Commands for Rolling
  ```bash
  # update
  kubectl apply -f <deployment0-definition-file>
  kubectl set image deployment/<deployment-name> <container-name>=<image>
  
  # check status
  kubectl rollout status <deployment-name>
  
  # check history
  kubectl rollout history <deployment-name>
  
  # undo update
  kubectl rollout undo <deployment-name>
  ```

  

### 4.2 Configure Applications

> 【Docker Refreshing】
>
> - run an ubuntu image and exit immediately
>   ```bash
>   docker run ubuntu
>   ```
>
> - run an ubuntu image with command
>   - pure command
>     ```bash
>     docker run ubuntu sleep 5
>     ```
>
>   - dockerfile & command
>     ```dockerfile
>     FROM ubuntu
>                 
>     CMD ["sleep", "5"]
>     ```
>
>     ```bash
>     docker build -t myubuntu .
>     docker run myubuntu
>     ```
>
> - run an ubuntu image with command & argument
>
>   ```dockerfile
>   FROM ubuntu
>   
>   ENTRYPOINT ["sleep"]
>   ```
>
>   ```bash
>   docker build -t myubuntu .
>   docker run myubuntu 5
>   ```
>
> - run an ubuntu image with command & default argument
>   ```dockerfile
>   FROM ubuntu
>         
>   ENTRYPOINT ["sleep"]
>         
>   CMD ["5"]
>   ```
>
>   ```bash
>   docker build -t myubuntu .
>   docker run myubuntu [5]
>   ```

- Commands & Arguments
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
  	name: myubuntu-pod
  spec:
  	containers:
  		- name: myubuntu
  			image: myubuntu
  			# command, and it overrides the ENTRYPOINT of the image
  			command: ["sleep"]
  			# arguments, and it overrides the CMD of the image
  			args: ["10"]
  ```

- Environment Variables
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
  	name: simple-webapp-color
  spec:
  	containers:
  		- name: simple-webapp-color
  			image: simple-webapp-color
  			ports:
  				- containerPort: 8080
  			# environment variables
  			env:
  				- name: APP_COLOR
  					value: pink
  ```

  - Other ways:

    - From ConfigMap
      ```yaml
      env:
      	- name: APP_COLOR
      		valueFrom:
      			configMapKeyRef:
      ```

    - From Secret
      ```yaml
      env:
      	- name: APP_COLOR
      		valueFrom:
      			secretKeyRef: 
      ```

- Configuration 

  - ConfigMap

    1. Create the ConfigMap

       - Imperative
         ```bash
         kubectl create configmap
         	<config-name> --from-literal=<key>=<value>
         ```

         ```bash
         kubectl create configmap \
         	<config-name> --from-file=xxx_config.properties
         	
         # xxx_config.properties
         	# APP_COLOR: blue
         	# APP_MODE: prod
         ```

       - Declarative
         ```yaml
         apiVersion: v1
         kind: ConfigMap
         metadata:
         	name: app-config
         	data:
         		APP_COLOR: blue
         		APP_MODE: prod
         ```

         ```bash
         kubectl create –f config-map.yaml
         ```

    2. Insert ConfigMap Into Pods
       - Env
         ```yaml
         envFrom:
         	- configMapRef:
         			name: app-config
         ```

       - Single Env
         ```yaml
         env:
         	- name: APP_COLOR
         		valueFrom:
         			configMapKeyRef:
         				name: app-config
         				key: APP_COLOR
         ```

       - Volume
         ```yaml
         volumes:
         	- name: app-config-volume
         		configMap:
         			name: app-config
         ```

  - Secret

    1. Create Secret

       - Imperative
         ```bash
         kubectl create secret generic
         	<secret-name> --from-literal=<key>=<value>
         ```

         ```bash
         kubectl create secret generic \
         	<secret-name> --from-file=xxx_secret.properties
         	
         # xxx_secret.properties
         	# DB_Host=mysql
         	# DB_User=root
         	# DB_Password=passwd
         ```

       - Declarative
         ```yaml
         apiVersion: v1
         kind: Secret
         metadata:
         	name: app-secret
         	data:
         	# encode: `echo –n ‘xxx’ | base64`
         	# decode: `echo –n ‘xxx’ | base64 --decode`
         		DB_Host=bXlzcWw=
         		DB_User=cm9vdA==
         		DB_Password=4oCTbiDig
         ```

         ```bash
         kubectl create -f secret.yaml
         ```

    2. Inject Secret Into Pods

       - Env
         ```yaml
         envFrom:
         	- secretRef:
         			name: app-config
         ```

       - Single Env
         ```yaml
         env:
         	- name: DB_Password
         		valueFrom:
         			secretKeyRef:
         				name: app-secret
         				key: DB_Password
         ```

       - Volume
         ```yaml
         volumes:
         	- name: app-secret-volume
         		secret:
         			secretName: app-secret
         ```

    > 【Note on Secret】
    > Secrets are not encrypted, so it is not safer in that sense. However, some best practices around using secrets make it safer. As in best practices like:
    >
    > - Not checking-in secret object definition files to source code repositories.
    > - [Enabling Encryption at Rest ](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)for Secrets so they are stored encrypted in ETCD. 



### 4.3 Multi Container Pods

- Concept

  - containers in one pod share the same life cycle, same network space (can refer to each other as localhost), same storage volume

- Multi Container Pod with YAML
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
  		name: simple-webapp
  		labels:
  			name: simple-webapp
  spec:
  	containers:
  		- name: simple-webapp
  			image: simple-webapp
  			ports:
  				- containerPort: 8080
  		- name: log-agent
  			image: log-agent
  ```

- InitContainer

  - Concept

    - In a multi-container pod, each container is expected to run a process that stays alive as long as the POD's lifecycle. For example in the multi-container pod that we talked about earlier that has a web application and logging agent, both the containers are expected to stay alive at all times. The process running in the log agent container is expected to stay alive as long as the web application is running. If any of them fails, the POD restarts.
    - But at times you may want to run a process that runs to completion in a container. For example a process that pulls a code or binary from a repository that will be used by the main web application. That is a task that will be run only one time when the pod is first created. Or a process that waits for an external service or database to be up before the actual application starts. That's where **initContainers** comes in.

  - InitContainer with YAML
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: myapp-pod
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp-container
        image: busybox:1.28
        command: ['sh', '-c', 'echo The app is running! && sleep 3600']
      initContainers:
      - name: init-myservice
        image: busybox
        command: ['sh', '-c', 'git clone <some-repository-that-will-be-used-by-application> ; done;']
    ```

    > You can configure multiple such initContainers as well, like how we did for multi-containers pod. In that case each init container is run **one at a time in sequential order**.



## 5 Cluster Maintanence



### 5.1 OS Upgrades

- Pod Eviction Time

  - After a node comes down, the pods on it will not be terminated within the Pod Eviction Time

  - If the node comes back within Pod Eviction Time, the pods will come back
  - If the node comes back after Pod Eviction Time, the pods in replica set will be created on other node, while others will be terminated

- Drain a Node

  - Terminate the pods on a node gracefully and recreate them on other nodes
  - The node is cordoned or marked as unschedulable
  - Command
    - `kubectl drain <node> --ignore-daemonsets`

- Cordon/Uncorden

  - Cordon
    - Mark a node as unschedulable
    - `kubectl cordon <node>`
  - Uncordon
    - Mark a node as schedulable
    - `kubectl uncordon <node>`

- OS Upgrades

  - If one pod is critical, when doing OS upgrades of some node, we don't want to drain it forcefully and cause the pod to be dead



### 5.2 Cluster Upgrade Process

- Kubernetes Release Versions

  - `v1.11.3`
    - Major version
    - Minor version
      - features
      - functions
    - Patch version
      - bug fixes
  - Control plane components have their own versions
    - The components versions cannot be higher than api-server's, except for kubectl
    - Go one minor version up at one time
    - Allowed combination of kubernetes binary versions:

      - kube-apiserver - version X
      - controller-manager - version X-1
      - kube-scheduler - version X-1
      - kubelet - version X-2
      - kube-proxy - version X-2
      - kubectl - version X+1 > X-1

- Cluster Upgrade

  - Three scenerios

    - Cluster set up with cloud providers (e.g. Gooogle): upgrade with a click
    - Cluster set up with tools: upgrade with apply and plan
    - Cluster set up from scratch: upgrade each component

  - Upgrading process

    1. Upgrade master nodes
       - Master down, without impacting workers' (service) running
    2. Upgrade worker nodes
       - Strategy 1: upgrade all nodes at one time
       - Strategy 2: upgrade one node at one time
       - Strategy 3: create new node with new version, move pods to new node and remove old one

  - Kubeadm Upgrade

    1. Upgrade master node: [Upgrading kubeadm clusters | Kubernetes](https://v1-29.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
       ```bash
       kubectl drain controlplane
       
       ...
       
       kubectl uncordon controlplane
       ```

    2. Upgrade worker nodes (one at a time): [Upgrading Linux nodes | Kubernetes](https://v1-29.docs.kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/)
       ```bash
       kubectl drain <node>
       
       ssh <node>
       
       ...
       
       exit
       
       kubectl uncordon <node>
       ```

       

    

### 5.3 Backup and Restore

- Backup Resource Configurations

  - Backup all pods, deployments, services

    ```
    kubectl get all --all-namespaces -o yaml > all-deploy-svc.yaml
    ```

  - Other tools...

- Bakcup & Restore ETCD

  - [Operating etcd clusters for Kubernetes | Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

  ```bash
  ETCDCTL_API=3 etcdctl snapshot save snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key
  
  ETCDCTL_API=3 etcdctl snapshot status snapshot.db
  
  ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
  --data-dir /var/lib/etcd-from-backup \
  
  # edit /etc/kubernetes/manifests.yaml
  ```







## 6 Security



### 6.1 Kubernetes Security Primitives

- Secure Hosts
  - Password based authentication disabled
  - SSH Key based authentication enabled
- Authentication
  - Concept
    - Who can access?
  - Methods
    - Files - username and password
    - Files - username and tokens
    - Certificates
    - External Authentication providers - LDAP
    - Service Accounts
- Authorization
  - Concept
    - RBAC Authorization
    - ABAC Authorization
    - Node Authorization
    - Webhook Mode
- TLS Certificates
  - Secure the communication among components of controlplane



### 6.2 Authentication

- Types of Access
  - Users
    - developers
    - admins
  - Service Accounts (bots)
- Auth Mechanisms
  - specify the auth-file in kube-apiserver config
  - use correct password/token/... to access kube-apiserver



### 6.3 TLS

- TLS Basics

  - Symmetric Encryption
    - Password/Token/...
  - Asymmetric Encryption (e.g. SSH Authentication)
    - Private key
      - id_rsa: to access the server
    - Public key
      - id_rsa.pub: to lock the server
  - Certificates
    - guarantee trust between two parties in communication
    - should be signed by Certificate Authority (CA)
    - CA
      - well-known organizations that can sign and validate your certificates for you
      - make sure you are the actual owner of some domain and can be trusted by browser
      - use private keys to sign the certificate, and browser use public key to validate the certificate
      - process of certificate request
        1. certificate signing request (CSR)
        2. validate information
        3. sign and send certificate
    - 3 type of certificates
      - root certificate
        - to ensure children certificates' identity
      - server certificate
        - to ensure server's identity
      - client certificate
        - to ensure client identity
  - Security Consideration
    - The asymmetric encryption can be used to transfer symmetric keys securely, the symmetric encryption can be used to secure the following communication
    - Certificates signed by CA used to validate the identity of both servers and clients
    - all infrastructure known as PKI

- TLS in Kubernetes

  - CA Certificates
    - two for clients & servers

  - Server Certificates
    - kube-apiserver
      - apiserver.crt
      - apiserver.key
    - etcd-servcer
      - etcdserver.crt
      - etcdserver.key
    - kubelet-server
      - kubelet-server.crt
      - kubelet-server.key
  - Client Certificates
    - admin
      - admin.crt
      - admin.key
    - scheduler
      - scheduler.crt
      - scheduler.key
    - kube-controller-manager
      - controller-manager.crt
      - controller-manager.key
    - kube-proxy
      - kube-proxy.crt
      - kube-proxy.key
    - kubelet
      - kubelet-client.crt
      - kubelet-client.key
    - kube-apiserver (to the etcd-server)
      - apiserver-etcd-client.crt
      - apiserver-etcd-client.key
    - kube-apiserver (to the kubelet)
      - apiserver-kubelet-client.crt
      - apiserver-kubelet-client.key

- Certificate Creation

  - Generate CA Certificate

    1. Generate keys
       ```bash
       openssl genrsa -out ca.key 2048
       ```

    2. Certificate signing request
       ```bash
       openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
       ```

    3. Sign Certificates

       ```bash
       openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
       ```

  - Generate Certificate for Admin User (Client/Server)

    1. Generate Keys
       ```bash
       openssl genrsa -out admin.key 2048
       ```

    2. Certificate signing request

       ```bash
       openssl req -new -key admin.key -subj "/CN=kube-admin" -out admin.csr
       ```

    3. Sign Certificates

       ```bash
       # signed with CA key pair
       openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
       ```

  - Generate Certificate for Kube-Apiserver

    1. Generate Keys
       ```bash
       openssl genrsa -out apiserver.key 2048
       ```

    2. Certificate signing request
       ```bash
       openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr -config openssl.cnf
       ```

- View Certificate Details

  - Perform a health check of all certificates in cluster

    - Cluster built with kubeadm

      ```bash
      cat /etc/kubernetes/manifests/kube-apiserver.yaml
      ```

    - Cluster built in hard way
      ```bash
      cat /etc/systemd/system/kube-apiserver.service 
      ```

  - Find more details in some certificate
    ```bash
    openssl x509 -in file-path.crt -text -noout
    ```

  - View logs
    ```bash
    kubectl logs etcd-master
    ```



### 6.4 Certificates API

- CA Server

  - A pair of keys and certificate files that have been generated, are stored securely in an environment
  - Everytime you want to sign a certificate, you log in to that server

- Certificates API

  - No need to manually log in and sign the request

  - Process

    1. Create `CertificatesSigningRequest` object
       ```bash
       openssl genrsa -out xxx.key 2048
       openssl req -new -key xxx.key -subj "/CN=xxx" -out xxx.csr
       
       cat <<EOF | kubectl apply -f -
       apiVersion: certificates.k8s.io/v1
       kind: CertificateSigningRequest
       metadata:
         name: my-svc.my-namespace
       spec:
         request: $(cat server.csr | base64 | tr -d '\n')
         signerName: example.com/serving
         usages:
         - digital signature
         - key encipherment
         - server auth
       EOF
       
       kubectl apply -f xxx.yaml
       
       ```

    2. Review requests
       ```bash
       kubectl get csr
       
       kubectl describe csr xxx
       ```

    3. Approve requests
       ```bash
       kubectl certificate approve <csr_name>
       
       # kubectl certificate deny <csr_name>
       ```

    4. Share certs





### 6.5 KubeConfig

- KubeConfig File

  - Defining the existing users to access exisiting clusters, `.kube/config`

  - Structure

    - Clusters
    - Contexts
    - Users

    ```yaml
    apiVersion: v1
    kind: Config
    
    clusters:
    - cluster:
        proxy-url: http://proxy.example.org:3128
        server: https://k8s.example.org/k8s/clusters/c-xxyyzz
      name: development
    
    users:
    - name: developer
    
    contexts:
    - context:
      name: development
    ```

  - View Config
    ```bash
    # view default config
    kubectl config view
    
    # view non-default config
    kubectl config --kubeconfig=/root/my-kube-config view
    ```

  - Change Current Context
    ```bash
    kubectl config use-context xxx_user@xxx_cluster
    ```

    



### 6.6 API Groups

- API Groups
  - `core` group
    - `/api`
  - `named` group
    - `/apis`
      - Resources
        - Verbs

- kubectl proxy
  - ACTP proxy service created by Kube control utility to access API server





### 6.7 Authorization

- Authorization Mode

  - Modes

    - Node
      - Node Authorizer handles the Kubelet's requests

    - ABAC
    - RBAC
    - Webhook
      - Open Policy Agent
    - AlwaysAllow
    - AlwaysDeny

  - Specified in `--authorization-mode`

    - Multiple modes: handled in order of the chain

- RBAC

  - Role

    - Role with YAML
      ```yaml
      apiVersion: rbac.authorization.k8s.io/v1
      kind: Role
      metadata:
      	name: developer
      rules:
      - apiGroups: [""]
      	resources: ["pods"]
      	verbs: ["list", "get", "create", "update", "delete"]
      - apiGroups: [""]
      	resources: ["ConfigMap"]
      	verbs: ["create"]
      	resourceName: ["blue", "orange"]
      ```

    - Commands for Roles
      ```bash
      # create a role
      kubectl create -f developer-role.yaml
      
      # lists roles
      kubectl get roles
      
      # view a role
      kubectl describe role developer
      ```

  - RoleBinding

    - RoleBinding with YAML
      ```yaml
      apiVersion: rbac.authorization.k8s.io/v1
      kind: RoleBinding
      metadata:
      	name: devuser-developer-binding
      subjects:
      - kind: User
      	name: dev-user
      	apiGroup: rbac.authorization.k8s.io
      roleRef:
      	kind: Role
      	name: developer
      	apiGroup: rbac.authorization.k8s.io
      ```

    - Commands for RoleBinding
      ```bash
      # list RBACs
      kubectl get rolebindings
      
      # view a RBAC
      kubectl describe rolebinding devuser-developer-binding
      ```

  - Check Access
    ```bash
    kubectl auth can-i create deployments
    
    kubectl auth can-i delete nodes
    
    # impersonate
    kubectl auth can-i create deployments --as dev-user
    ```




### 6.8 Cluster Roles and RoleBindings

- Namespaced and Cluster-scoped Resources

  - Namespaced Resources

    - Roles & RoleBindings
    - Pods
    - Deployments
    - Services
    - ...

  - Cluster-scoped Resources

    - ClusterRoles
    - ClusterRoleBindings
    - Nodes
    - Namespaces

    - ...

  - Check whether is namespaced
    ```bash
    kubectl api-resources --namespaced=true/false
    ```

- ClusterRoles

  - ClusterRole with YAML
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
    	name: cluster-administrator
    rules:
    - apiGroups: [""]
    	resources: ["nodes"]
    	verbs: ["list", "get", "create", "delete"]
    ```

- ClusterRoleBindings

  - ClusterRoleBinding with YAML
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
    	name: cluster-admin-role-binding
    subjects:
    - kind: User
    	name: cluster-admin
    	apiGroup: rbac.authorization.k8s.io
    roleRef:
    	kind: ClusterRole
    	name: cluster-administrator
    	apiGroup: rbac.authorization.k8s.io
    ```

    > You can also create cluster role for namespaced resources (will across all namespaces)



### 6.9 Service Accounts

- Account Types
  - User Account
  - Service Account

- ServiceAccount

  - Commands For ServiceAccount
    ```bash
    # create
    kubectl create serviceaccount dashboard-sa
    
    # list
    kubectl get serviceaccount
    
    # view
    kubectl describe serviceaccount dashboard-sa
    
    # create token for service account
    kubectl create token dashboard-sa
    ```

  - Specify the ServiceAccount for Deployment
    ```yaml
    #...
    spec:
    	serviceAccountName: dashboard-sa
    	containers:
    #...
    ```

  - When a ServiceAccount created

    1. create an account object
    2. generates a token for the service account
    3. create a secret object and store the token
    4. app can use the token to access the cluster

  > If the app is deployed on the cluster itself, the secret can be mounted as a volume inside the pod

  - Default service account
    - created automatically for each namespace
    - has a default secret for pods
    - only has permissions to run basic kube api





### 6.10 Image Security

- Image Name Structure

  - `Registry/User/Image`
    - e.g. `docker.io/library/nginx`

- Private Repository

  - Need to access with credentials

    - Login with command line:
      ```bash
      docker login private-registry.io
      ```

    - Passing the credentials to the docker runtime (Login when creating pod with image):
      ```bash
      kubectl create secret docker-registry <secret-name> \
        --docker-server=private-registry.io \
        --docker-username=registry-user \
        --docker-password=registry-password \
        --docker-email=sregistry-user@org.com
      ```

      ```yaml
      # ...
      spec:
      	containers:
      	- name: nginx
      		image: private-registry.io/apps/internal-app
      	imagePullSecrets:
      	- name: <secret-name>
      ```

    

    

    

    

### 6.11 Secruity Context

> 【Docker Security】
>
> - Process Isolation
>
>   - From a container inside, run `ps aux` can only see the process inside the container
>   - From the host, run `ps aux` can see many processes, because processes can have different process iDs in different namespaces
>
> - User Security
>
>   - default user: root
>
>   - specify the user: 
>
>     - `docker run xxx --user=user1`
>
>     - ```
>       FROM ubuntu
>       
>       USER user1
>       ```
>
>   - the root user inside container is not the same as the root user on the host, but permissions can be added
>
>     ```bash
>     docker run xxx --cap-add MAC_ADMIN
>     ```

- Security Contexts

  - Set Security Context in Pod Definition
    ```yaml
    #...
    spec:
    	containers:
    		- name: ubuntu
    			image: ubunutu
    			command: ["sleep", "3600"]
    			securityContext:
    				runAsUser: 1000
    				capabilities:
    					add: ["MAC_ADMIN"]
    ```

    > Capabilities are only supported at the container level and not at the POD level





### 6.12 Network Policy

- Network Policy

  - Selectors & Rules

    - pod labels
      ```yaml
      # db pod
      labels:
      	role：db
      ```

    - pod selectors
      ```bash
      # rules: db-policy
      podSelector:
      	matchLabels:
      		role: db
      ```

  - NetworkPolicy with YAML
    ```yaml
    # For db pod only allow ingress traffic from api-pod to 3306 port
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
    	name: db-policy
    spec:
    	podSelector: 
    		matchLabels:
    			role: db
    	policyTypes:
    		- Ingress
    	Ingress:
    	- from:
    		- podSelector:
    				matchLabels:
    					name: api-pod
    		ports:
    		- protocol: TCP
    			port: 3306
    			
    ```

    > Not all network solutions support NetworkPolicy



## 7 Storage

> 【Docker Storage】
>
> - Storage Driver
>
>   - File System
>
>     - `/var/lib/docker` stores all data by default
>
>   - Layered Architecture
>
>     - Container Layer (Read Write, COPY-ON-WRITE)
>     - Image Layers (Read Only)
>       - Each line of instruction of Dockerfile add to a layer in the image
>
>   - Volumes
>
>     - Create a volume
>       ```bash
>       docker volume create data_volume
>       ```
>
>     - Mount a volume
>       ```bash
>       docker run xxx -v data_volume:/var/lib/mysql
>       ```
>
>   - Storage Drivers
>
>     - Maintaining the layed architecture
>     - Common drivers
>       - AUFS
>       - ZFS
>       - BTRFS
>       - ...
>
> - Volume Drivers
>   - Volume Driver Plugin
>     - Handling the volume
>     - Common drivers
>       - Local
>       - Azure File Storage
>       - Convoy
>       - ...
> - Container Storage Interface (CSI)
>   - Defines a set if RPC that can be called by container orchestrators



### 7.1 Volumes

- Volumes

  - Concept

    - Data of pod are transient in native
    - Volumes are used to persist the data processed by pod

  - Mounts
    ```yaml
    #...
    # spec:
    	containers:
    		- image: alpine
    			name: alpine
    			volumeMounts:
    			- mountPath: /opt
    				name: data-volume
    	
    	volumes:
    	- name:
    		hostPath:
    			path: /data
    			type: Directory
    ```

    



### 7.2 Persistent Volumes

- Persistent Volumes

  - PersistentVolume with YAML
    ```yaml
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: pv-vol1
    spec:
      accessModes:
      	- ReadWriteOnce
      capacity:
      	storage: 1Gi
      hostPath:
      	path: /var/log/mysql
        type: Directory
      persistentVolumeReclaimPolicy: Delete
    ```

- Persistent Volume Claims

  - Binding
    - If the PersistentVolume exists and has not reserved PersistentVolumeClaims through its `claimRef` field, then the PersistentVolume and PersistentVolumeClaim will be bound.
    - One to one binding between claims and volume

  - PersistentvolumeClaim with YAML
    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: foo-pvc
      namespace: default
    spec:
      accessModes:
      	- ReadWriteOnce
      resources:
      	requests:
      		storage: 500Mi
    ```

  - Using PVCs in Pods
    ```yaml
    # ...
    	# spec:
    		# containers:
    		 # ...
    		volumes:
    			- name: mypd
    				persistentVolumeClaim:
    					claimName: myclaim
    ```

    



### 7.2 Storage Class

- StorageClass

  - Concept

    - Static Provisioning
      - Manually created the storage for pod each time a claim is made
    - Dynamic Provisioning
      - With Storage Class, can define a provisioner, that can automatically provision storage ( e.g. Google Cloud) and attach that to pods when a claim is made

  - StorageClass with YAML
    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metaData:
    	name: google-storage
    provisioner: kubernetes.io/gce-pd
    parameters: # specific to provisioners
    	type: pd-standard
    	replication-type: none
    ```

  - Using StorageClass in PVC definition
    ```yaml
    # ...
    spec:
    	# ...
    	storageClassName: google-storage
    ```

    









## 8 Networking

> 【Networking】
>
> - Switching & Routing
>
>   - Switching: enable communication within a network
>
>   - Routing: enable communication between two networks
>
>   - Default Gateway: to the unknown or internet
>
>   - Linux Commands
>     ```bash
>     # list interfaces on the host
>     ip link
>     
>     # see the ip addresses assigned to interfaces
>     ip addr
>     
>     # set ip addresses on the interfaces
>     ip add add 192.168.1.0/24 dev eth0
>     
>     # see the routing table
>     ip route
>     
>     # add entries into the routing table
>     ip route add 192.168.1.0/24 via 192.168.2.1
>     
>     # check if ip forwarding is enabled on a host (if the host works as a router)
>     cat /proc/sys/net/ipv4/ip_forward
>     ```
>
> - DNS
>
>   - Domain Names
>
>     - root
>     - top level domain name
>     - subdomain
>
>   - Record Types
>
>     - `A`: name -> ipv4 addr
>     - `AAAA`: name -> ipv6 addr
>     - `CNAME`: name -> another name
>
>   - Linux Commands
>
>     ```bash
>     # define name resolution
>     cat >> /etc/hosts
>     
>     # specify the dns server
>     cat /etc/resolv.conf
>     
>     # lookup order
>     cat /etc/nsswitch.conf
>     ```
>
> - Network Namespaces
>
>   - Namespace
>
>     - Process Namespace
>       - process isolation
>     - Network Namespace
>       - within the namespace, the container cannot access the network-related information on the host
>
>   - Linux Commands
>
>     ```bash
>     # create network ns
>     ip netns add <netns-name>
>     
>     # list network ns
>     ip netns
>     
>     # exec in network ns
>     ip netns exec <netns-name> ip link
>     ip -n <netns-name> ip link
>     ```
>
>   - Virtual Switch
>     ```bash
>     # create a linux bridge switch
>     ip link add v-net-0 type bridge
>     
>     # bring the switch up
>     ip link set dev v-net-0 up
>     
>     # creating cable
>     ip link add veth-red type veth peer name veth-red-br
>     ip link add veth-blue type veth peer name veth-blue-br
>     
>     # connect one end of the cable to ns
>     ip link set veth-red netns red
>     ip link set veth-red-br master v-net-0
>     ip link set veth-blue netns red
>     ip link set veth-blue-br master v-net-0
>     
>     # set the ip addr
>     ip -n red addr add 192.168.15.1 dev veth-red
>     ip -n blue addr add 192.168.15.2 dev veth-blue
>     ip -n red link set veth-red up
>     ip -n blue link set veth-red up
>     
>     # enable host to connect to within ns
>     ip addr add 192.168.15.5/24 dev v-net-0
>     
>     # enable connecting to outside ns
>     ip netns exec blue ip route add 192.168.1.0/24 via 192.168.15.5
>     iptables -t nat -A POSTROUTING -s 192.168.15.0/24 -j MASQUERADE
>     ```

> 【Docker Network】
>
> - Network Mode
>
>   - None
>     ```bash
>     docker run --nertwork none nginx
>     ```
>
>   - Host
>     ```bash
>     docker run --network host nginx
>     ```
>
>   - Bridge
>
>     - with a interface `docker0`
>
>     ```bash
>     docker run nginx 
>     # 172.17.0.0/24 by default
>     ```
>
> - CNI
>
>   - Container Runtime must create network namespace
>   - Identify network the container must attach to
>   - Container Runtime to Invoke Network Plugin (bridge) when container is ADDed
>   - Container Runtime to Invoke Network Plugin (bridge) when container is DELETEd
>   - JSON format of the Network Configuration
>   - Bridge (Plugin)
>     1. Create Bridge Network
>     2. Create VETH Pairs
>     3. Attach VETH to Namespace
>     4. Attach Other VETH to Bridge
>     5. Assign IP Addresses
>     6. Bring the interfaces up
>     7. Enable NAT - IP MASQURADE



### 8.1 Clustering Networking

- Networking in Kubernetes Cluster
  - [Ports and Protocols | Kubernetes](https://kubernetes.io/docs/reference/networking/ports-and-protocols/)
  - [Cluster Networking | Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/networking/)

- Network Addon
  - [Installing Addons | Kubernetes](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

> ```bash
> # check internal ip
> kubectl get nodes -o wide
> ```



### 8.2 Pod Networking

- Networking Model

  - Every Pod should have an IP address
  - Every Pod should be able to communicate with every other Pod in the same node
  - Every Pod should be able to communicate with every other Pod on other nodes without NAT

- Network Scripts
  ```
  ADD)
  
  	# Create veth pair
  	
  	# Attach veth pair
  	
  	# Assign IP Address
  	
  	# Bring Up Interface
  
  DELETE)
  	
  	# ip link del ...
  ```

  - will be executed when a container is created



### 8.3 K8s CNI

- Configuring CNI
  - Network Plugins are installed in `/opt/cni/bin`
  - Which plugin to use & How to use it is condigured in `/etc/cni/net.d`

- CNI Weave

  - Deployed on a cluster, deploy an agent on each node that can communicate with each other to exchange info, storing topology of the setup

  - Deploy
    ```bash
    kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
    ```

    

### 8.4 IP Address Management

- Assigning IP to Pods

  - Responsible by CNI plugins
    - host-local
    - DHCP

- IP range

  - By default:

    - 10.32.0.0/12

  - Check the ip range by weave
    ```bash
    kubectl logs <weave-pod-name> -n kube-system
    ```

    





### 8.5 Service Networking

- Service Mechanism

  - Services are cluster wide, across all nodes
  - When a service is created, the ip address is assigned in a predefined range, and kube-proxy on each node creates a ip forwarding
    - userspace
    - iptables
    - ipvs

- Service IP range

  - By default

    - 10.244.0.0/16

  - Check

    ```bash
    cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep cluster-ip-range
    ```

    



### 8.6 DNS in Kubernetes

- CoreDNS
  - Deployed as a ReplicaSet, can be accessed as Service
  - Inside the CoreDNS pod, there is a configuration file `/etc/coredns/Corefile`
    - Corefile is passed in to the CoreDNS as coredns ConfigMap  (config volume mounting)



### 8.7 Ingress

- Ingress

  - Concept
    - Helps users access applications using a single externally accessible URL that can be condigured to route to different services within the URL path
    - Realize Load Balancing
    - Execute SSL security
  - Implementation
    1. Deploy one of the supported solution
       - Ingress Controller
    2. Configure the rules
       - Ingress Resources

- Ingress Controller

  - Solutions available
    - NGINX
    - Contour
    - Istio
    - GCP HTTP Load Balancer

  - NGINX Deployment with YAML
    ```yaml
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
    	name: nginx-ingress-controller
    spec:
    	replicas: 1
    	selector:
    	matchLabels:
    		name: nginx-ingress
    	template:
    		metadata:
    			labels:
    				name: nginx-ingress
    		spec:
    			containers:
    				- name: nginx-ingress-controller
    					image: quay.io/kubernetes-ingresscontroller/nginx-ingress-controller:0.21.0
    					args:
    						- /nginx-ingress-controller
    						- --configmap=$(POD_NAMESPACE)/nginx-configuration
    					env:
    						- name: POD_NAME
    							valueFrom:
    								fieldRef:
    									fieldPath: metadata.name
    						- name: POD_NAMESPACE
    							valueFrom:
    								fieldRef:
    									fieldPath: metadata.namespace
    					ports:
    						- name: http
    							containerPort: 80
    						- name: https
    							containerPort: 443
    ```

    - Service
      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
      	name: nginx-ingress
      spec:
      	type: NodePort
      	ports:
      		- port: 80
      			targetPort: 80
      			protocol: TCP
      			name: http
      		- port: 443
      			targetPort: 443
      			protocol: TCP
      			name: https
      	selector:
      		name: nginx-ingress
      ```

    - ConfigMap
      ```yaml
      kind: ConfigMap
      apiVersion: v1
      metadata:
      	name: nginx-configuration
      ```

    - Auth
      ```yaml
      apiVersion: v1
      kind: ServiceAccount
      metadata:
      	name: nginx-ingress-serviceaccount
      ```

- Ingress Resources

  - Ingress with YAML

    - Split traffic by Path
      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: ingress-wear-watch
        annotations:
          nginx.ingress.kubernetes.io/rewrite-target: /
      spec:
        rules:
        - http:
            paths:
            - path: /wear
              pathType: Prefix
              backend:
                service:
                  name: wear-service
                  port:
                    number: 80
            - path: /watch
              pathType: Prefix
              backend:
                service:
                  name: watch-service
                  port:
                    number: 80
      ```

    - Split traffic by Hostname
      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: ingress-wear-watch
        annotations:
          nginx.ingress.kubernetes.io/rewrite-target: /
      spec:
        rules:
        - host: wear.my-online-store.com
        	http:
            paths:
            - backend:
                service:
                  name: wear-service
                  port:
                    number: 80
        - host: watch.my-online-store.com
        	http:
            paths:
            - backend:
                service:
                  name: watch-service
                  port:
                    number: 80
      ```

  - Commands for Ingress
    ```bash
    kubectl create ingress <ingress-name> --rule="host/path=service:port"
    ```

    

## 9 Design and Install a Kubernetes Cluster



### 9.1 Design a Kubernetes Cluster

- Purpose

  - Education
    - Minikube
    - Single node cluster with kubeadm/GCP/AWS
  - Developments & Testing
    - Multi-node cluster with a Single Master and Multiple workers
    - Setup using kubeadm tool or quick provision on GCP or AWS or AKS

- Cloud/OnPrem

  - Cloud
    - GKE for GCP
    - Kops for AWS
    - Azure Kubernetes Service(AKS) for Azure
  - OnPrem
    - Kubeadm

- Storage

  - High Performance – SSD Backed Storage 
  - Multiple Concurrent connections – Network based storage 
  - Persistent shared volumes for shared access across multiple PODs 
  - Label nodes with specific disk types 
  - Use Node Selectors to assign applications to nodes with specific disk types

- Nodes

  - Virtual or Physical Machines

  - Master vs Worker Nodes

    > Master nodes can host workloads but not recommended

  - Linux x86_64 Architecture





### 9.2 Choosing Kubernetes Infrastructure

- On Laptop

  - Minikube
    - Deploys VMs
    - Single Node Cluster
  - Kubeadm
    - Requires VMs to be ready
    - Single/Multi Node Cluster

- On Production Env

  - Turnkey Solutions 

    - You Provision VMs 

    - You Configure VMs 

    - You Use Scripts to Deploy Cluster 

    - You Maintain VMs yourself 

      > Eg: Kubernetes on AWS using KOPS 

  - Hosted Solutions (Managed Solutions) 

    - Kubernetes-As-A-Service 

    - Provider provisions VMs 

    - Provider installs Kubernetes 

    - Provider maintains VMs 

      > Eg: Google Container Engine (GKE)







### 9.3 Configure High Availability

- [Options for Highly Available Topology | Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/)



### 9.4 Install Kubernetes the Kubeadm Way

> [Bootstrapping clusters with kubeadm | Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)

- Steps

  1. Provision VMs

  2. Install Container Runtimer (Containerd)

     > https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-runtime

  3. Install Kubeadm Tool

     > https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl

  4. Initialize Master Server

     > https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#preparing-the-hosts

  5. Set Up the Pod Network

     > https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network

  6. Join Node

     > https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#join-nodes





## 10 Troubleshooting



### 10.1 Application Failure

- Check Accessiblity
  ```bash
  curl http://<web-servive-ip>:<node-port>
  ```

- Check Service Status
  ```bash
  kubectl describe service web-service
  ```

- Check Pod
  ```bash
  kubectl get pod
  
  kubwctl describe pod web
  
  kubectl logs web -f --prev
  ```

- Others

  - Check dependent service
  - Check dependent application





### 10.2 Control Plane Server

- Check Controlplane Services
  ```bash
  service kube-apiserver status
  
  service kube-controller-manager status
  
  service kube-scheduler status
  
  service kubelet status
  
  service kube-proxy status
  ```

- Check Service Logs
  ```bash
  kubectl logs kube-apiserver-master -n kube-system
  
  sudo journalctl -u kube-apiserver
  ```

  



### 10.3 Worker Node Failure

- Check Node Status

  ```bash
  kubectl get nodes
  
  kubectl describe node worker-1
  ```

- Check Node
  ```bash
  top
  
  df -h
  ```

- Check Kubelet Status
  ```bash
  service kubelet status
  
  sudo journalctl -u kubelet
  ```

- Check Certificates
  ```bash
  openssl x509 -in /var/lib/kubelet/worker-1.crt -text
  
  # s/var/lib/kubelet/config.yaml
  # /etc/kubernetes/kubelet.conf
  ```

  



### 10.4 Network Troubleshooting

- Check CoreDNS

  1.  If you find **CoreDNS** pods in pending state first check network plugin is installed.

  2. Coredns pods have **CrashLoopBackOff or Error state**

  3. If **CoreDNS** pods and the **kube-dns** service is working fine, check the **kube-dns** service has valid **endpoints**.

      ```bash
      kubectl -n kube-system get ep kube-dns
      ```

- Check Kube-proxy
  ```bash
  kubectl describe ds kube-proxy -n kube-system
  ```

  1. Check **kube-proxy** pod in the **kube-system** namespace is running.
  2. Check **kube-proxy** logs.
  3. Check **configmap** is correctly defined and the config file for running **kube-proxy** binary is correct.
  4. **kube-config** is defined in the **config map**.
  5. check **kube-proxy** is *running* inside the container



## 11 Other Topics



### 11.1 JSON Path in Kubernetes

- Kubectl and JSON

  - Request to Kube-apiserver and get response in JSON format
  - Make response to readable format and print out to screen

- JSON Path in K8s
  ```bash
  kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'
  
  kubectl get nodes -o=jsonpath='{.items[*].status.capacity.cpu}'
  
  kubectl get nodes -o=jsonpath='{.items[*].metadata.name}{"\n"}{.items[*].status.capacity.cpu}'
  ```

- Loops - Range
  ```
  '{range .items[*]}
  	{.metadata.name} {"\t"} {.status.capacity.cpu}{"\n"}
  {end}'
  ```

- Sort
  ```bash
  kubectl get nodes --sort-by=.status.capacity.cpu
  ```

  





