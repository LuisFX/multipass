CODE=/Volumes/ssd/code
VM_NAME=ubuntu-net5

multipass launch ubuntu --name $VM_NAME
multipass mount $CODE $VM_NAME
