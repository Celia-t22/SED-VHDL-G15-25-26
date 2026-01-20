----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2026 14:57:39
-- Design Name: 
-- Module Name: EDGEDTCTR - Behavioral
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

entity EDGEDTCTR is
    port (
        CLK      : in  std_logic;
        RESET    : in  std_logic;  -- activo alto
        SYNC_IN  : in  std_logic;
        EDGE_OUT : out std_logic
    );
end EDGEDTCTR;

architecture Behavioral of EDGEDTCTR is
  signal sreg : std_logic_vector(2 downto 0) := (others => '0');
begin
  process (CLK)
  begin
    if rising_edge(CLK) then
      if RESET = '1' then
        sreg     <= (others => '0');
        EDGE_OUT <= '0';
      else
        -- desplazamiento
        sreg <= sreg(1 downto 0) & SYNC_IN;

        -- pulso 1 ciclo cuando detecta 0->1
        if sreg = "011" then
          EDGE_OUT <= '1';
        else
          EDGE_OUT <= '0';
        end if;
      end if;
    end if;
  end process;
end Behavioral;



