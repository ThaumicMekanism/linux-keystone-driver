DRIVER = keystone-driver.ko

ifneq ($(KERNELRELEASE),)
	keystone-driver-y := \
		keystone.o \
		keystone-rtld.o \
		keystone-page.o \
		keystone-ioctl.o \
		keystone-enclave.o
	obj-m += keystone-driver.o
else

PWD := $(shell pwd)
KDIR := $(PWD)/../riscv-linux/
KEYSTONE_SDK_DIR := $(PWD)/../sdk/

default:
	$(MAKE) -C $(KDIR) ARCH=riscv SUBDIRS=$(PWD) modules

copy:
	cp $(DRIVER) $(KEYSTONE_SDK_DIR)/bin/
	cd $(KEYSTONE_SDK_DIR)/.. && make hifive


endif

clean:
	rm -rvf *.o *.ko *.order *.symvers *.mod.c .tmp_versions .*o.cmd
