# Number of threads
#threads=20
threads=$(expr $(nproc) + 2)
eval `grep "^ID=" /etc/os-release`
export ID
