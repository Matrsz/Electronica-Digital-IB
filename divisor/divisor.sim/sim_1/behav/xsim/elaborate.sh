#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Mon Nov 16 12:02:01 -03 2020
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 3d29cbf732554fb98523fb61cc9137b8 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot toplevel_tb_behav xil_defaultlib.toplevel_tb -log elaborate.log"
xelab -wto 3d29cbf732554fb98523fb61cc9137b8 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot toplevel_tb_behav xil_defaultlib.toplevel_tb -log elaborate.log

