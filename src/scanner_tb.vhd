----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 09:50:01
-- Design Name: 
-- Module Name: scanner_tb - Behavioral
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

entity scanner_tb is
-- Vacio
end scanner_tb;

architecture Behavioral of scanner_tb is

    component scanner
    Port ( 
        clk     : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        ce      : in STD_LOGIC;
        sel     : out STD_LOGIC_VECTOR (2 downto 0);
        anodes  : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;

    -- Señales
    signal tb_clk     : STD_LOGIC := '0';
    signal tb_reset_n : STD_LOGIC := '0';
    signal tb_ce      : STD_LOGIC := '0';
    signal tb_sel     : STD_LOGIC_VECTOR(2 downto 0);
    signal tb_anodes  : STD_LOGIC_VECTOR(7 downto 0);

    -- Constante para definir la velocidad del reloj simulado
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: scanner Port Map (
        clk => tb_clk, reset_n => tb_reset_n, ce => tb_ce,
        sel => tb_sel, anodes => tb_anodes
    );

    -- 1. Proceso generador de RELOJ (Clock)
    clk_process : process
    begin
        tb_clk <= '0';
        wait for CLK_PERIOD/2;
        tb_clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- 2. Proceso de estímulos (Prueba)
    stim_proc: process
    begin
        -- Reset inicial
        tb_reset_n <= '0';
        wait for 20 ns;
        tb_reset_n <= '1'; -- Soltamos el reset
        wait for 20 ns;

        -- Simulamos que el Timer manda pulsos (CE)
        -- Queremos ver como cuenta: 0 -> 1 -> 2...
        
        for i in 0 to 10 loop
            tb_ce <= '1'; -- Pulso del timer
            wait for CLK_PERIOD; -- Dura un ciclo de reloj
            tb_ce <= '0'; -- Se apaga
            wait for 20 ns; -- Esperamos un rato hasta el siguiente pulso
        end loop;

        wait;
    end process;

end Behavioral;