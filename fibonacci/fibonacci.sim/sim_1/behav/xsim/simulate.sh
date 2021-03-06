#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Nov 11 09:34:40 -03 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim tb_fibonacci_behav -key {Behavioral:sim_1:Functional:tb_fibonacci} -tclbatch tb_fibonacci.tcl -view /home/inox/Documents/Vivado/fibonacci/tb_fibonacci_behav.wcfg -log simulate.log"
xsim tb_fibonacci_behav -key {Behavioral:sim_1:Functional:tb_fibonacci} -tclbatch tb_fibonacci.tcl -view /home/inox/Documents/Vivado/fibonacci/tb_fibonacci_behav.wcfg -log simulate.log

