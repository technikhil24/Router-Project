# 1x3 Packet-Based Router (SystemVerilog + UVM)

This project implements a 1x3 router in SystemVerilog and verifies it using UVM methodology.

## 📁 Project Structure
- `router.v` – RTL Design
- `TestBench.sv` – Top module to connect DUT with UVM testbench
- `RouterInterface.sv` – Virtual interface for connecting DUT and UVM
- `RouterTransaction.sv`, `RouterSequence.sv`, `RouterDriver.sv` – UVM components
- `RouterScoreboard.sv` – Checks output against expected data

## 🛠️ Tools Used
- SystemVerilog
- UVM
- EDA Playground / ModelSim / Aldec Riviera pro 2023.04

## ▶️ How to Run (EDA Playground)
Click to run ➡️ [Run on EDA Playground](https://www.edaplayground.com/x/wuW5)

## 👤 Author
Nikhil K Thomas
