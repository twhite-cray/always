#!/bin/bash
source ./env
module -t list
set -x
export OMP_NUM_THREADS=7
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_VERSION_DISPLAY=1
NODES=${1}
TASKS=$(( NODES * 8 ))
SIZE=${2}
STRIDED=${3}
ldd ./iall
srun -t 15:00 -n${TASKS} -N${NODES} -c${OMP_NUM_THREADS} --gpus-per-task=1 --gpu-bind=closest --exclusive --unbuffered ./iall ${SIZE} ${STRIDED}
