----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.12.2025 23:09:49
-- Design Name: 
-- Module Name: Top_Ascensor - Behavioral
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


-------------------------------------------------
--PRUEBAAAAAAA para ver entrada de sensores y botones funcionan con el sincronizador y el edge

entity Top_Test is
  port (
    CLK        : in  std_logic;
    RESET      : in  std_logic;

    BTN        : in  std_logic_vector(3 downto 0);

    S_Puerta   : in  std_logic;
    S_Presencia: in  std_logic;
    S_Planta   : in  std_logic;

    LED        : out std_logic_vector(7 downto 0)
  );
end Top_Test;

architecture behavioral of Top_Test is

  -- salidas limpias
  signal BTN_Clean : std_logic_vector(3 downto 0);
  signal S_Puerta_Clean, S_Presencia_Clean, S_Planta_Clean : std_logic;

  -- latches para LEDs
  signal led_reg : std_logic_vector(7 downto 0) := (others => '0');

  component INPUT_BTN_CNDTNR
    port (
      CLK       : in  std_logic;
      RESET     : in  std_logic;
      BTN       : in  std_logic_vector(3 downto 0);
      BTN_Clean : out std_logic_vector(3 downto 0)
    );
  end component;

  component INPUT_SEN_CNDTNR
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
  end component;

begin

  -- Instancia botones
  u_btn : INPUT_BTN_CNDTNR
    port map (
      CLK       => CLK,
      RESET     => RESET,
      BTN       => BTN,
      BTN_Clean => BTN_Clean
    );

  -- Instancia sensores
  u_sen : INPUT_SEN_CNDTNR
    port map (
      CLK               => CLK,
      RESET             => RESET,
      S_Puerta          => S_Puerta,
      S_Presencia       => S_Presencia,
      S_Planta          => S_Planta,
      S_Puerta_Clean    => S_Puerta_Clean,
      S_Presencia_Clean => S_Presencia_Clean,
      S_Planta_Clean    => S_Planta_Clean
    );

  -- Lógica de prueba: cualquier evento deja el LED encendido
  process (CLK)
  begin
    if rising_edge(CLK) then
      if RESET = '1' then
        led_reg <= (others => '0');
      else
        if BTN_Clean(0) = '1' then led_reg(0) <= '1'; end if;
        if BTN_Clean(1) = '1' then led_reg(1) <= '1'; end if;
        if BTN_Clean(2) = '1' then led_reg(2) <= '1'; end if;
        if BTN_Clean(3) = '1' then led_reg(3) <= '1'; end if;

        if S_Puerta_Clean    = '1' then led_reg(4) <= '1'; end if;
        if S_Presencia_Clean = '1' then led_reg(5) <= '1'; end if;
        if S_Planta_Clean    = '1' then led_reg(6) <= '1'; end if;
      end if;
    end if;
  end process;

  LED <= led_reg;

end behavioral;
