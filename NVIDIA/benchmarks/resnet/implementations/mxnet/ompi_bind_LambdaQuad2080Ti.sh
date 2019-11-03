#!/bin/bash

case "${OMPI_COMM_WORLD_LOCAL_RANK}" in
0)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=0-2,12-13 --membind=0 "${@}"
	;;
1)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=3-5,14-15 --membind=0 "${@}"
	;;
2)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=6-8,16-17 --membind=0 "${@}"
	;;
3)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=9-11,18-19 --membind=0 "${@}"
	;;
*)
	echo ==============================================================
	echo "ERROR: Unknown local rank ${OMPI_COMM_WORLD_LOCAL_RANK}"
	echo ==============================================================
	exit 1
	;;
esac
	
