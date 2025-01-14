#!/bin/bash

case "${OMPI_COMM_WORLD_LOCAL_RANK}" in
0)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=0-4,10-14 --membind=0 "${@}"
	;;
1)
	export OMPI_MCA_btl_openib_if_include=mlx5_0
	exec numactl --physcpubind=5-9,15-19 --membind=0 "${@}"
	;;
*)
	echo ==============================================================
	echo "ERROR: Unknown local rank ${OMPI_COMM_WORLD_LOCAL_RANK}"
	echo ==============================================================
	exit 1
	;;
esac
	
