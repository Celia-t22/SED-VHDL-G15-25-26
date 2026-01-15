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
    S_Planta          : in  std_logic;

    S_Puerta_Clean    : out std_logic;
    S_Presencia_Clean : out std_logic;
    S_Planta_Clean    : out std_logic
  );

end INPUT_SEN_CNDTNR;

architecture Behavioral of INPUT_SEN_CNDTNR is

  -- señales sincronizadas
  signal S_Puerta_Sync    : std_logic;
  signal S_Presencia_Sync : std_logic;
  signal S_Planta_Sync    : std_logic;

  -- componentes reutilizados del laboratorio
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

  ------------------------------------------------------------------
  -- SENSOR PUERTA
  ------------------------------------------------------------------
  u_sync_puerta : SYNCHRNZR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      ASYNC_IN => S_Puerta,
      SYNC_OUT => S_Puerta_Sync
    );

  u_edge_puerta : EDGEDTCTR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      SYNC_IN  => S_Puerta_Sync,
      EDGE_OUT => S_Puerta_Clean
    );

  ------------------------------------------------------------------
  -- SENSOR PRESENCIA
  ------------------------------------------------------------------
  u_sync_presencia : SYNCHRNZR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      ASYNC_IN => S_Presencia,
      SYNC_OUT => S_Presencia_Sync
    );

  u_edge_presencia : EDGEDTCTR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      SYNC_IN  => S_Presencia_Sync,
      EDGE_OUT => S_Presencia_Clean
    );

  ------------------------------------------------------------------
  -- SENSOR PLANTA
  ------------------------------------------------------------------
  u_sync_planta : SYNCHRNZR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      ASYNC_IN => S_Planta,
      SYNC_OUT => S_Planta_Sync
    );

  u_edge_planta : EDGEDTCTR
    port map (
      CLK      => CLK,
      RESET    => RESET,
      SYNC_IN  => S_Planta_Sync,
      EDGE_OUT => S_Planta_Clean
    );

end Behavioral;
