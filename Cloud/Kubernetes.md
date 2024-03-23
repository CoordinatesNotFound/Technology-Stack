# Kubernetes

```
## 1 Intro

[What is Kubernetes? | DigitalOcean](https://www.digitalocean.com/community/tutorials/an-introduction-to-kubernetes)

[Glossary | Kubernetes](https://kubernetes.io/docs/reference/glossary/?fundamental=true)



## 2 Documentation

[Kubernetes Documentation | Kubernetes](https://kubernetes.io/docs/home/)



## 3 Tools

- Running a cluster
  - Kind
    - Intro: kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
    - Guide: [kind](https://kind.sigs.k8s.io/)
  - Minikube
    - Intro: minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.
    - Guide: [minikube start | minikube](https://minikube.sigs.k8s.io/docs/start/)

- Command line
  - Kubectl
    - Intro: provided by Kubernetes, which is a command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
    - Guide
      - [Command line tool (kubectl) | Kubernetes](https://kubernetes.io/docs/reference/kubectl/)
      - [kubectl Cheat Shee t | Kubernetes](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- Plugin Manager
  - Krew 
    - Intro: Krew is the plugin manager for `kubectl` command-line tool
    - Guide: [User Guide · Krew](https://krew.sigs.k8s.io/docs/user-guide/)
```



## 1 Kubernetes Basic



### 1.1 Cluster Architecture

- Master
- Worker Nodes
