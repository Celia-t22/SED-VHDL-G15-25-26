----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 10:10:18
-- Design Name: 
-- Module Name: Visualizer_tb - Behavioral
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

entity Visualizer_tb is
-- Entidad vacía
end Visualizer_tb;

architecture Behavioral of Visualizer_tb is

    -- 1. Declaramos el componente "Jefe"
    component Visualizer
    Port ( 
        CLK       : in  STD_LOGIC;
        RESET_N   : in  STD_LOGIC;
        DIGIT_0   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_1   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_2   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_3   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_4   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_5   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_6   : in  STD_LOGIC_VECTOR (3 downto 0); 
        DIGIT_7   : in  STD_LOGIC_VECTOR (3 downto 0);
        ANODES    : out STD_LOGIC_VECTOR (7 downto 0);
        SEGMENTS  : out STD_LOGIC_VECTOR (6 downto 0)
    );
    end component;

    -- 2. Señales para conectar
    signal tb_clk     : STD_LOGIC := '0';
    signal tb_reset_n : STD_LOGIC := '0';
    
    -- Señales para las entradas de datos
    signal tb_d0 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0
    signal tb_d1 : STD_LOGIC_VECTOR(3 downto 0) := "0001"; -- 1
    signal tb_d2 : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- 2
    signal tb_d3 : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 3
    signal tb_d4 : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 4
    signal tb_d5 : STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- 5
    signal tb_d6 : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 6
    signal tb_d7 : STD_LOGIC_VECTOR(3 downto 0) := "0111"; -- 7
    
    -- Salidas
    signal tb_anodes   : STD_LOGIC_VECTOR(7 downto 0);
    signal tb_segments : STD_LOGIC_VECTOR(6 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- 3. Conectamos la UUT
    uut: Visualizer Port Map (
        CLK => tb_clk, RESET_N => tb_reset_n,
        DIGIT_0 => tb_d0, DIGIT_1 => tb_d1, DIGIT_2 => tb_d2, DIGIT_3 => tb_d3,
        DIGIT_4 => tb_d4, DIGIT_5 => tb_d5, DIGIT_6 => tb_d6, DIGIT_7 => tb_d7,
        ANODES => tb_anodes, SEGMENTS => tb_segments
    );

    -- 4. Generador de Reloj
    clk_process : process
    begin
        tb_clk <= '0'; wait for CLK_PERIOD/2;
        tb_clk <= '1'; wait for CLK_PERIOD/2;
    end process;

    -- 5. Proceso de prueba
    stim_proc: process
    begin
        -- Reset inicial
        tb_reset_n <= '0';
        wait for 50 ns;
        tb_reset_n <= '1'; -- ¡Arranca el sistema!

        -- Como ya hemos fijado los valores de tb_d0...tb_d7 arriba,
        -- solo tenemos que sentarnos a mirar cómo pasan los ciclos.
        
        -- Esperamos lo suficiente para ver varias vueltas completas del scanner
        wait for 2000 ns; 
        
        wait;
    end process;

end Behavioral;