#!/bin/bash

case "${OMPI_COMM_WORLD_LOCAL_RANK}" in
0)
    export OMPI_MCA_btl_openib_if_include=mlx5_0
    exec numactl --physcpubind=0-2,24-26 --membind=0 "${@}"
    ;;
1)
    export OMPI_MCA_btl_openib_if_include=mlx5_0
    exec numactl --physcpubind=3-5,27-29 --membind=0 "${@}"
    ;;
2)
    export OMPI_MCA_btl_openib_if_include=mlx5_1
    exec numactl --physcpubind=6-8,30-32 --membind=0 "${@}"
    ;;
3)
    export OMPI_MCA_btl_openib_if_include=mlx5_1
    exec numactl --physcpubind=9-11,33-35 --membind=0 "${@}"
    ;;
4)
    export OMPI_MCA_btl_openib_if_include=mlx5_2
    exec numactl --physcpubind=12-14,36-38 --membind=1 "${@}"
    ;;
5)
    export OMPI_MCA_btl_openib_if_include=mlx5_2
    exec numactl --physcpubind=15-17,39-41 --membind=1 "${@}"
    ;;
6)
    export OMPI_MCA_btl_openib_if_include=mlx5_3
    exec numactl --physcpubind=18-20,42-44 --membind=1 "${@}"
    ;;
7)
    export OMPI_MCA_btl_openib_if_include=mlx5_3
    exec numactl --physcpubind=21-23,45-47 --membind=1 "${@}"
    ;;
*)
    echo ==============================================================
    echo "ERROR: Unknown local rank ${OMPI_COMM_WORLD_LOCAL_RANK}"
    echo ==============================================================
    exit 1
    ;;
esac

