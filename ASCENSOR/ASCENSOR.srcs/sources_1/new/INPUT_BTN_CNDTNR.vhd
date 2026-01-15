----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2026 15:12:23
-- Design Name: 
-- Module Name: INPUT_BTN_CNDTNR - Behavioral
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

entity INPUT_BTN_CNDTNR is
  port (
    CLK       : in  std_logic;
    RESET     : in  std_logic;
    BTN       : in  std_logic_vector(3 downto 0);
    BTN_Clean : out std_logic_vector(3 downto 0)
  );
end INPUT_BTN_CNDTNR;

architecture behavioral of INPUT_BTN_CNDTNR is

  signal BTN_Sync : std_logic_vector(3 downto 0);

  component SYNCHRNZR
    port (
      CLK      : in  std_logic;
      RESET    : in  std_logic;
      ASYNC_IN : in  std_logic;
      SYNC_OUT : out std_logic
    );
  end component;

  component EDGEDTCTR
    port (
      CLK      : in  std_logic;
      RESET    : in  std_logic;
      SYNC_IN  : in  std_logic;
      EDGE_OUT : out std_logic
    );
  end component;

begin

  -- Botón 0
  u_sync0 : SYNCHRNZR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        ASYNC_IN=>BTN(0), 
        SYNC_OUT=>BTN_Sync(0)
    );

  u_edge0 : EDGEDTCTR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        SYNC_IN=>BTN_Sync(0), 
        EDGE_OUT=>BTN_Clean(0)
    );

  -- Botón 1
  u_sync1 : SYNCHRNZR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        ASYNC_IN=>BTN(1), 
        SYNC_OUT=>BTN_Sync(1)
    );

  u_edge1 : EDGEDTCTR
    port map (
        CLK=>CLK,
        RESET=>RESET, 
        SYNC_IN=>BTN_Sync(1), 
        EDGE_OUT=>BTN_Clean(1)
    );

  -- Botón 2
  u_sync2 : SYNCHRNZR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        ASYNC_IN=>BTN(2), 
        SYNC_OUT=>BTN_Sync(2)
    );

  u_edge2 : EDGEDTCTR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        SYNC_IN=>BTN_Sync(2), 
        EDGE_OUT=>BTN_Clean(2)
    );

  -- Botón 3
  u_sync3 : SYNCHRNZR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        ASYNC_IN=>BTN(3), 
        SYNC_OUT=>BTN_Sync(3)
    );

  u_edge3 : EDGEDTCTR
    port map (
        CLK=>CLK, 
        RESET=>RESET, 
        SYNC_IN=>BTN_Sync(3), 
        EDGE_OUT=>BTN_Clean(3)
    );

end behavioral;
