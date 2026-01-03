# Subnet Calculator using Dart

## 📌 Project Overview

This project is a **Subnet Calculator** developed using the **Dart programming language**.  
It helps users understand and calculate IPv4 subnetting concepts by providing detailed
network information based on user input.

The program works through a **menu-driven approach**, allowing users to calculate subnet
details using different methods such as:

* Number of subnets
* CIDR notation
* Number of hosts per subnet

This project is mainly intended for **networking students**, **ECE / IT students**, and
beginners learning IPv4 subnetting.

---

## ⚙️ Program Flow

1. The user enters an IPv4 address.
2. The program identifies and displays the **IP class** (Class A, B, or C).
3. The user is prompted to choose one of the following options:

   * **Press 1** → Subnet calculation based on **number of subnets**
   * **Press 2** → Subnet calculation using **CIDR notation**
   * **Press 3** → Subnet calculation based on **number of hosts required**

4. Based on the selected option, the program calculates and displays:

   * Subnet Mask
   * CIDR notation
   * Number of subnets
   * Number of hosts per subnet
   * Network IP address
   * First usable IP address
   * Last usable IP address
   * Broadcast IP address

5. The results are displayed for **all generated subnets**.

---

## ✨ Features

* Accepts any valid IPv4 address
* Automatically detects IP class (A / B / C)
* Menu-driven user interaction
* Supports three subnetting methods:

  * By number of subnets
  * By CIDR notation
  * By number of hosts

* Displays complete subnet details
* Clear and readable command-line output

---

## 🧠 Networking Concepts Used

* IPv4 Addressing
* IP Address Classes (A, B, C)
* Subnet Mask Calculation
* CIDR Notation
* Host and Network Bits
* Network Address
* Broadcast Address
* Usable IP Address Range

---

## 🛠️ Technologies Used

* Dart Programming Language
* Command Line Interface (CLI)

---

## 📥 Sample Input

```

Enter the IPv4 address: 172.168.14.3
Press 1 for subnet
Press 2 for CIDR notation
Press 3 for number of hosts
CIDR notation /25
```

## 📥 Sample Output

```

IP Class: Class B
CIDR: /25
Subnet Mask: 255.255.255.128
Hosts per subnet: 126
Number of subnets: 2

Network IP   : 172.168.14.0
First IP     : 172.168.14.1
Last IP      : 172.168.14.126
Broadcast IP : 172.168.14.127
-------------------------
Network IP   : 172.168.14.128
First IP     : 172.168.14.129
Last IP      : 172.168.14.254
Broadcast IP : 172.168.14.255
```

---

## 🎯 Use Cases

* Learning IPv4 subnetting concepts
* Academic projects and lab work
* Exam preparation (CN / CCNA basics)
* Quick offline subnet calculations
