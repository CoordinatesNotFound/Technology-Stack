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

  - To isolate different set of kubernetes obects

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

  







> 129, 135
