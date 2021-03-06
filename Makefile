GRLIB=/home/francesc/Projecte/grlib
TOP=leon3mp
BOARD=gr-pci-xc2v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
SYNPOPT="set_option -pipe 0; set_option -retiming 0; set_option -write_apr_constraint 0"
VHDLSYNFILES=config.vhd ahbrom.vhd ni/lib.vhd ni/ni_state_slv.vhd ni/packetizer.vhd ni/type_gen.vhd ni/counter.vhd ni/wormhole_splitter.vhd ni/wormhole_joiner.vhd ni/ni.vhd router/port_buffer.vhd #leon3mp.vhd

#type_gen.vhd 

# ni.vhd leon3mp.vhd

VHDLSIMFILES=testbench_test.vhd
SIMTOP=testbench_test
#VHDLSIMFILES=testbench_ni.vhd
#SIMTOP=testbench_ni
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

#TECHLIBS = unisim
include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

