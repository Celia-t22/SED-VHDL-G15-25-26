#*****************************************************************************************
# Vivado (TM) v2025.1 - Script de reconstrucción FIXED
#*****************************************************************************************

# 1. Definimos la carpeta raíz del repositorio (ajustada a tu PC)
set repo_dir "C:/Users/USER/Documents/GitHub/SED-VHDL-G15-25-26"

# 2. Nombre del proyecto
set _xil_proj_name_ "ASCENSOR"

# 3. Crear el proyecto físicamente
# Se creará en C:/Users/USER/Documents/GitHub/SED-VHDL-G15-25-26/ASCENSOR
create_project -force ${_xil_proj_name_} "$repo_dir/${_xil_proj_name_}" -part xc7a100tcsg324-1

# 4. Configurar propiedades de la placa
set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:nexys-a7-100t:part0:1.3" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj

# 5. Añadir el archivo VHDL (Source)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
add_files -norecurse -fileset [get_filesets sources_1] "$repo_dir/src/Top_Ascensor.vhd"

# 6. Añadir el archivo de restricciones (XDC)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
add_files -norecurse -fileset [get_filesets constrs_1] "$repo_dir/xdc/Nexys-A7-100T-Master.xdc"

# 7. Definir el archivo Top
set_property "top" "Top_Ascensor" [current_fileset]

puts "INFO: ¡Proyecto reconstruido con éxito en $repo_dir/${_xil_proj_name_}!"