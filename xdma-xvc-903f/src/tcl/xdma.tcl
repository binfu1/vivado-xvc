
################################################################
# This is a generated script based on design: xdma
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source xdma_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# judge, xdma_v4_1_10_vsec_null

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu37p-fsvh2892-2L-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name xdma

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:ila:6.2\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xdma:4.1\
xilinx.com:ip:debug_bridge:3.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
judge\
xdma_v4_1_10_vsec_null\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt ]

  set sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $sys_clk


  # Create ports
  set sys_rstn [ create_bd_port -dir I -type rst sys_rstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $sys_rstn

  # Create instance: bram_axi, and set properties
  set bram_axi [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 bram_axi ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
 ] $bram_axi

  # Create instance: bram_axil, and set properties
  set bram_axil [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 bram_axil ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
 ] $bram_axil

  # Create instance: bram_ctrl_axi, and set properties
  set bram_ctrl_axi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 bram_ctrl_axi ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $bram_ctrl_axi

  # Create instance: bram_ctrl_axil, and set properties
  set bram_ctrl_axil [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 bram_ctrl_axil ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.ECC_TYPE {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $bram_ctrl_axil

  # Create instance: buf_sysclk, and set properties
  set buf_sysclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 buf_sysclk ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $buf_sysclk

  # Create instance: ila_axi, and set properties
  set ila_axi [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_axi ]

  # Create instance: ila_axil, and set properties
  set ila_axil [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_axil ]

  # Create instance: interconnect_axi, and set properties
  set interconnect_axi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 interconnect_axi ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $interconnect_axi

  # Create instance: interconnect_axil, and set properties
  set interconnect_axil [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 interconnect_axil ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $interconnect_axil

  # Create instance: judge, and set properties
  set block_name judge
  set block_cell_name judge
  if { [catch {set judge [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $judge eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: logic_or, and set properties
  set logic_or [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 logic_or ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $logic_or

  # Create instance: vsec_null, and set properties
  set block_name xdma_v4_1_10_vsec_null
  set block_cell_name vsec_null
  if { [catch {set vsec_null [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $vsec_null eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xdma, and set properties
  set xdma [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma ]
  set_property -dict [ list \
   CONFIG.PF0_DEVICE_ID_mqdma {903F} \
   CONFIG.PF0_SRIOV_VF_DEVICE_ID {A03F} \
   CONFIG.PF1_SRIOV_VF_DEVICE_ID {0000} \
   CONFIG.PF2_DEVICE_ID_mqdma {903F} \
   CONFIG.PF2_SRIOV_VF_DEVICE_ID {0000} \
   CONFIG.PF3_DEVICE_ID_mqdma {903F} \
   CONFIG.PF3_SRIOV_VF_DEVICE_ID {0000} \
   CONFIG.axi_bypass_64bit_en {false} \
   CONFIG.axi_data_width {512_bit} \
   CONFIG.axil_master_64bit_en {true} \
   CONFIG.axil_master_prefetchable {true} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_size {256} \
   CONFIG.axist_bypass_en {false} \
   CONFIG.axisten_freq {250} \
   CONFIG.cfg_ext_if {true} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.enable_pcie_debug {False} \
   CONFIG.ext_xvc_vsec_enable {true} \
   CONFIG.pcie_blk_locn {PCIE4C_X1Y0} \
   CONFIG.pf0_device_id {903F} \
   CONFIG.pf0_msi_cap_multimsgcap {1_vector} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_3:2} \
   CONFIG.pf0_msix_cap_table_bir {BAR_3:2} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X16} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTY_Quad_227} \
   CONFIG.vendor_id {1BD4} \
   CONFIG.xdma_pcie_64bit_en {true} \
   CONFIG.xdma_pcie_prefetchable {true} \
 ] $xdma

  # Create instance: xvc_vsec, and set properties
  set xvc_vsec [ create_bd_cell -type ip -vlnv xilinx.com:ip:debug_bridge:3.0 xvc_vsec ]
  set_property -dict [ list \
   CONFIG.C_BSCAN_MUX {1} \
   CONFIG.C_DEBUG_MODE {5} \
   CONFIG.C_NUM_BS_MASTER {0} \
   CONFIG.C_PCIE_EXT_CFG_BASE_ADDR {0xEA0} \
   CONFIG.C_XVC_HW_ID {0x0001} \
 ] $xvc_vsec

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins interconnect_axil/S00_AXI] [get_bd_intf_pins xdma/M_AXI_LITE]
  connect_bd_intf_net -intf_net bram_ctrl_axi_BRAM_PORTA [get_bd_intf_pins bram_axi/BRAM_PORTA] [get_bd_intf_pins bram_ctrl_axi/BRAM_PORTA]
  connect_bd_intf_net -intf_net bram_ctrl_axil_BRAM_PORTA [get_bd_intf_pins bram_axil/BRAM_PORTA] [get_bd_intf_pins bram_ctrl_axil/BRAM_PORTA]
  connect_bd_intf_net -intf_net interconnect_axi_M01_AXI [get_bd_intf_pins bram_ctrl_axi/S_AXI] [get_bd_intf_pins interconnect_axi/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets interconnect_axi_M01_AXI] [get_bd_intf_pins ila_axi/SLOT_0_AXI] [get_bd_intf_pins interconnect_axi/M00_AXI]
  connect_bd_intf_net -intf_net interconnect_axil_M00_AXI [get_bd_intf_pins bram_ctrl_axil/S_AXI] [get_bd_intf_pins interconnect_axil/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets interconnect_axil_M00_AXI] [get_bd_intf_pins ila_axil/SLOT_0_AXI] [get_bd_intf_pins interconnect_axil/M00_AXI]
  connect_bd_intf_net -intf_net sys_clk_1 [get_bd_intf_ports sys_clk] [get_bd_intf_pins buf_sysclk/CLK_IN_D]
  connect_bd_intf_net -intf_net xdma_M_AXI [get_bd_intf_pins interconnect_axi/S00_AXI] [get_bd_intf_pins xdma/M_AXI]
  connect_bd_intf_net -intf_net xdma_soc_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins xdma/pcie_mgt]

  # Create port connections
  connect_bd_net -net buf_sysclk_IBUF_DS_ODIV2 [get_bd_pins buf_sysclk/IBUF_DS_ODIV2] [get_bd_pins xdma/sys_clk]
  connect_bd_net -net buf_sysclk_IBUF_OUT [get_bd_pins buf_sysclk/IBUF_OUT] [get_bd_pins xdma/sys_clk_gt]
  connect_bd_net -net judge_data [get_bd_pins judge/data] [get_bd_pins xdma/cfg_ext_read_data]
  connect_bd_net -net logic_or_Res [get_bd_pins logic_or/Res] [get_bd_pins xdma/cfg_ext_read_data_valid]
  connect_bd_net -net sys_rstn_1 [get_bd_ports sys_rstn] [get_bd_pins xdma/sys_rst_n]
  connect_bd_net -net vsec_null_control_reg_out [get_bd_pins vsec_null/control_reg_out] [get_bd_pins vsec_null/status_reg_in]
  connect_bd_net -net vsec_null_read_data [get_bd_pins judge/data2] [get_bd_pins vsec_null/read_data]
  connect_bd_net -net vsec_null_read_data_valid [get_bd_pins logic_or/Op1] [get_bd_pins vsec_null/read_data_valid]
  connect_bd_net -net xdma_axi_aclk [get_bd_pins bram_ctrl_axi/s_axi_aclk] [get_bd_pins bram_ctrl_axil/s_axi_aclk] [get_bd_pins ila_axi/clk] [get_bd_pins ila_axil/clk] [get_bd_pins interconnect_axi/ACLK] [get_bd_pins interconnect_axi/M00_ACLK] [get_bd_pins interconnect_axi/S00_ACLK] [get_bd_pins interconnect_axil/ACLK] [get_bd_pins interconnect_axil/M00_ACLK] [get_bd_pins interconnect_axil/S00_ACLK] [get_bd_pins vsec_null/clk] [get_bd_pins xdma/axi_aclk] [get_bd_pins xvc_vsec/clk]
  connect_bd_net -net xdma_axi_aresetn [get_bd_pins bram_ctrl_axi/s_axi_aresetn] [get_bd_pins bram_ctrl_axil/s_axi_aresetn] [get_bd_pins interconnect_axi/ARESETN] [get_bd_pins interconnect_axi/M00_ARESETN] [get_bd_pins interconnect_axi/S00_ARESETN] [get_bd_pins interconnect_axil/ARESETN] [get_bd_pins interconnect_axil/M00_ARESETN] [get_bd_pins interconnect_axil/S00_ARESETN] [get_bd_pins xdma/axi_aresetn]
  connect_bd_net -net xdma_cfg_ext_function_number [get_bd_pins vsec_null/function_number] [get_bd_pins xdma/cfg_ext_function_number] [get_bd_pins xvc_vsec/pcie3_cfg_ext_function_number]
  connect_bd_net -net xdma_cfg_ext_read_received [get_bd_pins vsec_null/read_received] [get_bd_pins xdma/cfg_ext_read_received] [get_bd_pins xvc_vsec/pcie3_cfg_ext_read_received]
  connect_bd_net -net xdma_cfg_ext_register_number [get_bd_pins vsec_null/register_number] [get_bd_pins xdma/cfg_ext_register_number] [get_bd_pins xvc_vsec/pcie3_cfg_ext_register_number]
  connect_bd_net -net xdma_cfg_ext_write_byte_enable [get_bd_pins vsec_null/write_byte_enable] [get_bd_pins xdma/cfg_ext_write_byte_enable] [get_bd_pins xvc_vsec/pcie3_cfg_ext_write_byte_enable]
  connect_bd_net -net xdma_cfg_ext_write_data [get_bd_pins vsec_null/write_data] [get_bd_pins xdma/cfg_ext_write_data] [get_bd_pins xvc_vsec/pcie3_cfg_ext_write_data]
  connect_bd_net -net xdma_cfg_ext_write_received [get_bd_pins vsec_null/write_received] [get_bd_pins xdma/cfg_ext_write_received] [get_bd_pins xvc_vsec/pcie3_cfg_ext_write_received]
  connect_bd_net -net xvc_vsec_pcie3_cfg_ext_read_data [get_bd_pins judge/data1] [get_bd_pins xvc_vsec/pcie3_cfg_ext_read_data]
  connect_bd_net -net xvc_vsec_pcie3_cfg_ext_read_data_valid [get_bd_pins judge/valid] [get_bd_pins logic_or/Op2] [get_bd_pins xvc_vsec/pcie3_cfg_ext_read_data_valid]

  # Create address segments
  assign_bd_address -offset 0xC0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces xdma/M_AXI] [get_bd_addr_segs bram_ctrl_axi/S_AXI/Mem0] -force
  assign_bd_address -offset 0xC0000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces xdma/M_AXI_LITE] [get_bd_addr_segs bram_ctrl_axil/S_AXI/Mem0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


