----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 09:22:25
-- Design Name: 
-- Module Name: muxer_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity muxer_tb is
-- Entidad vacía
end muxer_tb;

architecture Behavioral of muxer_tb is

    component muxer
    Port ( 
        sel     : in  STD_LOGIC_VECTOR (2 downto 0);
        digit_0 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_1 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_2 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_3 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_4 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_5 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_6 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_7 : in  STD_LOGIC_VECTOR (3 downto 0);
        bcd_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
    end component;

    -- Señales para conectar
    signal tb_sel     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal tb_bcd_out : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Señales para los dígitos (les damos valor inicial ya para no escribir tanto luego)
    signal d0 : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- 0
    signal d1 : STD_LOGIC_VECTOR(3 downto 0) := "0001"; -- 1
    signal d2 : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- 2
    signal d3 : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- 3
    signal d4 : STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- 4
    signal d5 : STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- 5
    signal d6 : STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 6
    signal d7 : STD_LOGIC_VECTOR(3 downto 0) := "0111"; -- 7

begin

    uut: muxer Port Map (
        sel => tb_sel,
        digit_0 => d0, digit_1 => d1, digit_2 => d2, digit_3 => d3,
        digit_4 => d4, digit_5 => d5, digit_6 => d6, digit_7 => d7,
        bcd_out => tb_bcd_out
    );

    stim_proc: process
    begin
        -- Vamos a cambiar el selector cada 10 nanosegundos
        -- Deberíamos ver salir: 0 -> 1 -> 2 -> ... -> 7
        
        for i in 0 to 7 loop
            tb_sel <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        wait;
    end process;

end Behavioral;
