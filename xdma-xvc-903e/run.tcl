###################################### project settings ######################################
set launchDir [file dirname [file normalize [info script]]]
set srcDir ${launchDir}/src
set xdcDir ${launchDir}/xdc
set projName "proj"
set projDir "./$projName"
set projPart "xcvu37p-fsvh2892-2L-e"
create_project $projName $projDir -part $projPart

##################################### add source files ######################################
# add verilog  file
add_files -norecurse ${srcDir}/hdl/judge.v
add_files -norecurse ${srcDir}/hdl/vsec_null.v

# add block design
set bdName xdma
source ${srcDir}/tcl/xdma.tcl
regenerate_bd_layout
validate_bd_design
save_bd_design
make_wrapper -files [get_files ${projDir}/${projName}.srcs/sources_1/bd/${bdName}/${bdName}.bd] -top
add_files -norecurse ${projDir}/${projName}.gen/sources_1/bd/${bdName}/hdl/${bdName}_wrapper.v

# add constrains
add_files -fileset constrs_1 -norecurse ${xdcDir}/xdma.xdc

########################################## compile ###########################################
## synth
#launch_runs synth_1 -jobs 20
#wait_on_run synth_1
## impl
#launch_runs impl_1 -jobs 20
#wait_on_run impl_1
## generate bitstream
#launch_runs impl_1 -to_step write_bitstream -jobs 20