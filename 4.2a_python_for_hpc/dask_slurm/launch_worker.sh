echo "Launching dask worker"
MEM_GB=180
SIMG='/expanse/lustre/projects/sds166/zonca/dask-numba-si23.sif'
# memory limit is in bytes
MEM=$(( $MEM_GB*1024**3 ))
module load singularitypro
singularity exec $SIMG dask worker --scheduler-file ~/.dask_scheduler.json --memory-limit $MEM --nworkers 1
