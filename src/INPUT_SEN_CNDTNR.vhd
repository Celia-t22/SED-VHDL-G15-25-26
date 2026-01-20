----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2026 16:14:29
-- Design Name: 
-- Module Name: INPUT_SEN_CNDTNR - Behavioral
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

entity INPUT_SEN_CNDTNR is
  port (
    CLK               : in  std_logic;
    RESET             : in  std_logic;

    S_Puerta          : in  std_logic;
    S_Presencia       : in  std_logic;
    S_Planta          : in  std_logic_vector(3 downto 0);

    S_Puerta_Clean    : out std_logic;
    S_Presencia_Clean : out std_logic;
    S_Planta_Clean    : out std_logic_vector(3 downto 0)
  );
end INPUT_SEN_CNDTNR;

architecture Behavioral of INPUT_SEN_CNDTNR is

  -- señales sincronizadas
  signal S_Puerta_Sync    : std_logic;
  signal S_Presencia_Sync : std_logic;
  signal S_Planta_Sync    : std_logic_vector(3 downto 0);

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

  -- PUERTA
  u_sync_puerta : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Puerta, SYNC_OUT=>S_Puerta_Sync);

  u_edge_puerta : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Puerta_Sync, EDGE_OUT=>S_Puerta_Clean);

  -- PRESENCIA
  u_sync_presencia : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Presencia, SYNC_OUT=>S_Presencia_Sync);

  u_edge_presencia : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Presencia_Sync, EDGE_OUT=>S_Presencia_Clean);

  -- PLANTA(0)
  u_sync_pl0 : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Planta(0), SYNC_OUT=>S_Planta_Sync(0));
  u_edge_pl0 : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Planta_Sync(0), EDGE_OUT=>S_Planta_Clean(0));

  -- PLANTA(1)
  u_sync_pl1 : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Planta(1), SYNC_OUT=>S_Planta_Sync(1));
  u_edge_pl1 : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Planta_Sync(1), EDGE_OUT=>S_Planta_Clean(1));

  -- PLANTA(2)
  u_sync_pl2 : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Planta(2), SYNC_OUT=>S_Planta_Sync(2));
  u_edge_pl2 : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Planta_Sync(2), EDGE_OUT=>S_Planta_Clean(2));

  -- PLANTA(3)
  u_sync_pl3 : SYNCHRNZR
    port map (CLK=>CLK, RESET=>RESET, ASYNC_IN=>S_Planta(3), SYNC_OUT=>S_Planta_Sync(3));
  u_edge_pl3 : EDGEDTCTR
    port map (CLK=>CLK, RESET=>RESET, SYNC_IN=>S_Planta_Sync(3), EDGE_OUT=>S_Planta_Clean(3));

end Behavioral;
