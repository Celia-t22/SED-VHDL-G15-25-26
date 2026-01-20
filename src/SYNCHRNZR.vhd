----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2026 15:03:48
-- Design Name: 
-- Module Name: SYNCHRNZR - Behavioral
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

entity SYNCHRNZR is
  port (
    CLK      : in  std_logic;
    RESET    : in  std_logic;  -- activo alto (si no se usa: conecta '0')
    ASYNC_IN : in  std_logic;
    SYNC_OUT : out std_logic
  );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is
  signal sreg : std_logic_vector(1 downto 0) := (others => '0');
begin
  process (CLK)
  begin
    if rising_edge(CLK) then
      if RESET = '1' then
        sreg     <= (others => '0');
        SYNC_OUT <= '0';
      else
        SYNC_OUT <= sreg(1);
        sreg     <= sreg(0) & ASYNC_IN;
      end if;
    end if;
  end process;

end Behavioral;

--Si reset activo a nivel bajo: (RESET => not RESET_N) en top

