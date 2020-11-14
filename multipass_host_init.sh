CODE=/Volumes/ssd/code
VM_NAME=ubuntu_net5

multipass launch ubuntu --name $VM_NAME
multipass mount $CODE $VM_NAME
