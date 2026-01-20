----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 09:14:44
-- Design Name: 
-- Module Name: muxer - Behavioral
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

entity muxer is
    Port ( 
        sel     : in  STD_LOGIC_VECTOR (2 downto 0); -- El selector (3 bits para contar de 0 a 7)
        
        -- Las 8 posibles entradas (4 bits cada una)
        digit_0 : in  STD_LOGIC_VECTOR (3 downto 0); 
        digit_1 : in  STD_LOGIC_VECTOR (3 downto 0); 
        digit_2 : in  STD_LOGIC_VECTOR (3 downto 0); 
        digit_3 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_4 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_5 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_6 : in  STD_LOGIC_VECTOR (3 downto 0);
        digit_7 : in  STD_LOGIC_VECTOR (3 downto 0);
        
        -- La salida elegida
        bcd_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end muxer;

architecture Behavioral of muxer is
begin
    -- Este proceso se activa si cambia el selector O cualquiera de los datos
    process(sel, digit_0, digit_1, digit_2, digit_3, digit_4, digit_5, digit_6, digit_7)
    begin
        case sel is
            when "000" => bcd_out <= digit_0; -- Turno del display 0
            when "001" => bcd_out <= digit_1; -- Turno del display 1
            when "010" => bcd_out <= digit_2; -- ...
            when "011" => bcd_out <= digit_3;
            when "100" => bcd_out <= digit_4;
            when "101" => bcd_out <= digit_5;
            when "110" => bcd_out <= digit_6;
            when "111" => bcd_out <= digit_7;
            when others => bcd_out <= "1111"; -- Por seguridad (apagado)
        end case;
    end process;
end Behavioral;