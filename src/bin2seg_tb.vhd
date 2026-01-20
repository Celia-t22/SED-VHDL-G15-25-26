----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 08:28:46
-- Design Name: 
-- Module Name: bin2seg_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Para poder hacer bucles con números

entity bin2seg_tb is
-- Entidad vacía para Testbench
end bin2seg_tb;

architecture Behavioral of bin2seg_tb is
    -- 1. Declarar el componente que vamos a probar (UUT - Unit Under Test)
    component bin2seg
        Port ( binary_in : in STD_LOGIC_VECTOR (3 downto 0);
               segments  : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    -- 2. Señales locales para conectar a la UUT
    signal tb_binary_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal tb_segments  : STD_LOGIC_VECTOR(6 downto 0);

begin
    -- 3. Instanciar la UUT
    uut: bin2seg Port Map (
        binary_in => tb_binary_in,
        segments  => tb_segments
    );

    -- 4. Proceso de estímulos
    stim_proc: process
    begin
        -- Probamos todos los números del 0 al 9
        for i in 0 to 9 loop
            tb_binary_in <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns; -- Esperamos un poco para ver el cambio en el cronograma
        end loop;
        
        -- Caso de error (otros)
        tb_binary_in <= "1111";
        wait for 10 ns;

        wait; -- Detiene la simulación
    end process;
end Behavioral;