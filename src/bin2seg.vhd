----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 08:11:24
-- Design Name: 
-- Module Name: bin2seg - Behavioral
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

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin2seg is
    Port ( 
        binary_in : in  STD_LOGIC_VECTOR (3 downto 0); -- Número BCD (0-9)
        segments  : out STD_LOGIC_VECTOR (6 downto 0)  -- abcdefg (7 segmentos)
    );
end bin2seg;

architecture Behavioral of bin2seg is
begin
-- segmentos(0) = a, (1) = b, (2) = c, (3) = d, (4) = e, (5) = f, (6) = g
    process(binary_in)
    begin
        case binary_in is
            --NUMEROS
            when "0000" => segments <= "1000000"; -- 0
            when "0001" => segments <= "1111001"; -- 1
            when "0010" => segments <= "0100100"; -- 2
            when "0011" => segments <= "0110000"; -- 3
            when "0100" => segments <= "0011001"; -- 4
            when "0101" => segments <= "0010010"; -- 5
            when "0110" => segments <= "0000010"; -- 6
            when "0111" => segments <= "1111000"; -- 7
            when "1000" => segments <= "0000000"; -- 8
            when "1001" => segments <= "0010000"; -- 9
            -- LETRAS 
            when "1010" => segments <= "0001000"; -- A
            when "1011" => segments <= "0000000"; -- B
            when "1110" => segments <= "0000110"; -- E
            when "1101" => segments <= "0010010"; -- S 
            when "1100" => segments <= "1000001"; -- U
            when "1111" => segments <= "1110001"; -- J
            --APAGADO
            when others => segments <= "1111111"; -- Apagado para errores
        end case;
    end process;


end Behavioral;