----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2026 09:55:12
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    Port ( 
        clk     : in  STD_LOGIC;
        reset_n : in  STD_LOGIC;
        strobe  : out STD_LOGIC -- El pulso para el Scanner
    );
end timer;

architecture Behavioral of timer is
    -- Constante para definir la velocidad. 
    -- 100,000 ciclos @ 100MHz = 1ms.
    constant MAX_COUNT : integer := 10; --tiene q estar en 100000
    signal count       : integer range 0 to MAX_COUNT;
    
begin

    process(clk, reset_n)
    begin
        if reset_n = '0' then
            count <= 0;
            strobe <= '0';
        elsif rising_edge(clk) then
            if count = MAX_COUNT - 1 then
                strobe <= '1'; -- ¡Disparo!
                count <= 0;    -- Reiniciamos cuenta
            else
                strobe <= '0'; -- Silencio...
                count <= count + 1;
            end if;
        end if;
    end process;

end Behavioral;