help:
	@echo make create-rk0
	@echo '  or'
	@echo make remove-rk0

update-hosts:
	sudo sed -i /etc/hosts -e '/^192.168.122.20/d' \
		-e '$$a192.168.122.200 rk0 rk0.dev.local'\
		-e '$$a192.168.122.201 rk1 rk1.dev.local'\
		-e '$$a192.168.122.202 rk2 rk2.dev.local'

create-rk0:
	./kvm-install-vm create -c2 -m 2048 -t rocky86 -v -D dev.local -M 52:54:00:11:22:00 -s $(shell pwd)/init-rk0.sh rk0
	./kvm-install-vm attach-disk -d 20 -t vdc rk0

create-rk1:
	./kvm-install-vm create -c2 -m 2048 -t rocky86 -v -D dev.local -M 52:54:00:11:22:01 -s $(shell pwd)/init-rk1.sh rk1
	./kvm-install-vm attach-disk -d 20 -t vdc rk1

create-rk2:
	./kvm-install-vm create -c2 -m 2048 -t rocky86 -v -D dev.local -M 52:54:00:11:22:02 -s $(shell pwd)/init-rk2.sh rk2
	./kvm-install-vm attach-disk -d 20 -t vdc rk2

create-all: create-rk0 create-rk1 create-rk2
ssh=ssh -o StrictHostKeychecking=no
reboot-rk0:
	-$(ssh) rocky@rk0 sudo reboot

reboot-rk1:
	-$(ssh) rocky@rk1 sudo reboot

reboot-rk2:
	-$(ssh) rocky@rk2 sudo reboot

reboot-all: reboot-rk0 reboot-rk1 reboot-rk2

remove-rk0:
	./kvm-install-vm remove rk0
remove-rk1:
	./kvm-install-vm remove rk1
remove-rk2:
	./kvm-install-vm remove rk2

remove-all: remove-rk2 remove-rk1 remove-rk0

list:
	./kvm-install-vm list

whoami-rk0:
	@$(ssh) rocky@rk0 "whoami; hostname -f"

whoami-rk1:
	@$(ssh) rocky@rk1 "whoami; hostname -f"

whoami-rk2:
	@$(ssh) rocky@rk2 "whoami; hostname -f"

