# Virtualization




## 1 Concept

- Virtualization is a technology that allows you to create virtual, simulated environments from a single, physical machine. 



## 2 Terminalogies

- Host OS
  - operating system of the physical machine
- Guest OS
  - operating system of virtual machines
- Virtual Machine (VM)
  - guest machines
- Snapshot
  - a way of VM backup
- Hypervisor
  - software that separates a system’s physical resources and divides those resources so that virtual environments can use them as needed
    - enable virtualization
  - 2 types
    - type 1: bare-metal hypervisor
      - run as base OS
      - only for production
      - e.g. VMware esxi, Xen Hypervisor
    - type 2: hosted hypervisor
      - runs a software
      - learn and test
      - e.g. Oracle Virtualbox, VMware server