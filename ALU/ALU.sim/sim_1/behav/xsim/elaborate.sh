#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu Oct 29 09:48:04 -03 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 4cc073956e75450f9e0af676ee74148c --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot mult_tb_behav xil_defaultlib.mult_tb -log elaborate.log"
xelab -wto 4cc073956e75450f9e0af676ee74148c --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot mult_tb_behav xil_defaultlib.mult_tb -log elaborate.log
