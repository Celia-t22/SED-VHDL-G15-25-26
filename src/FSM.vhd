----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2026 11:16:06
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
port(
  reset : in std_logic;  -- activo bajo
  CLK   : in std_logic;

  -- Entradas
  BTN_Clean         : in std_logic_vector(3 downto 0);
  S_Puerta_Clean    : in std_logic;
  S_Presencia_Clean : in std_logic;
  S_Planta_Clean    : in std_logic_vector(3 downto 0);
  p_actual          : in integer range 0 to 3;

  -- Temporizadores
  TIM_STOP          : in std_logic;
  inicia_TIM_STOP   : out std_logic;
  TIM_CORTESIA      : in std_logic;
  inicia_TIM_CORTESIA : out std_logic;

  -- Salidas
  motor_ascensor : out std_logic_vector(1 downto 0);
  motor_puertas  : out std_logic_vector(1 downto 0)
);
end FSM;

architecture Behavioral of FSM is

  type STATE is (S0_STDBY, S1_CERRAR, S2_TIMER, S3_SELECTOR, S4_ABRIR, S_BAJAR, S_SUBIR, S_DETENER);
  signal current_state, next_state : STATE;

  signal flag        : std_logic := '0';
  signal piso_destino: integer range 0 to 3 := 0;

begin

  --------------------------------------------------------------------
  -- Registro de estado + registro de piso_destino + flag
  --------------------------------------------------------------------
  state_register : process (CLK, reset)
  begin
    if reset = '0' then
      current_state <= S0_STDBY;
      piso_destino  <= 0;
      flag          <= '0';
    elsif rising_edge(CLK) then
      current_state <= next_state;

      -- Guardar botón pulsado (solo cuando estás en STDBY)
      if current_state = S0_STDBY then
        if    BTN_Clean(0) = '1' then piso_destino <= 0;
        elsif BTN_Clean(1) = '1' then piso_destino <= 1;
        elsif BTN_Clean(2) = '1' then piso_destino <= 2;
        elsif BTN_Clean(3) = '1' then piso_destino <= 3;
        end if;
      end if;

      -- Flag para distinguir caso de presencia durante el cierre
      if (current_state = S1_CERRAR) and (S_Presencia_Clean = '1') then
        flag <= '1';
      elsif current_state = S3_SELECTOR then
        flag <= '0';
      end if;

    end if;
  end process;

  --------------------------------------------------------------------
  -- Lógica de siguiente estado
  --------------------------------------------------------------------
  nextstate_dec : process(current_state, BTN_Clean, p_actual, piso_destino,
                          S_Presencia_Clean, S_Puerta_Clean, S_Planta_Clean,
                          TIM_STOP, TIM_CORTESIA, flag)
  begin
    next_state <= current_state;

    case current_state is

      when S0_STDBY =>
        -- FIX: no uses piso_destino aquí, se actualiza 1 ciclo después del pulso de BTN_Clean
        if (BTN_Clean /= "0000") then
          next_state <= S1_CERRAR;
        end if;

      when S1_CERRAR =>
        if S_Presencia_Clean = '1' then
          next_state <= S4_ABRIR;
        elsif S_Puerta_Clean = '1' then
          next_state <= S3_SELECTOR;
        end if;

      when S3_SELECTOR =>
        if p_actual > piso_destino then
          next_state <= S_BAJAR;
        elsif p_actual < piso_destino then
          next_state <= S_SUBIR;
        else
          next_state <= S4_ABRIR;
        end if;

      when S_SUBIR | S_BAJAR =>
        if S_Planta_Clean(piso_destino) = '1' then
          next_state <= S_DETENER;
        end if;

      when S_DETENER =>
        if TIM_STOP = '1' then
          next_state <= S4_ABRIR;
        end if;

      when S4_ABRIR =>
        if S_Puerta_Clean = '1' then
          if flag = '1' then
            next_state <= S2_TIMER;
          else
            next_state <= S0_STDBY;
          end if;
        end if;

      when S2_TIMER =>
        if TIM_CORTESIA = '1' then
          next_state <= S1_CERRAR;
        end if;

      when others =>
        next_state <= S0_STDBY;

    end case;
  end process;

  --------------------------------------------------------------------
  -- Salidas (Moore)
  --------------------------------------------------------------------
  salida : process(current_state)
  begin
    -- por defecto
    motor_puertas        <= "00";
    motor_ascensor       <= "00";
    inicia_TIM_CORTESIA  <= '0';
    inicia_TIM_STOP      <= '0';

    case current_state is
      when S1_CERRAR  => motor_puertas  <= "10";
      when S4_ABRIR   => motor_puertas  <= "01";
      when S_SUBIR    => motor_ascensor <= "10";
      when S_BAJAR    => motor_ascensor <= "01";
      when S_DETENER  => inicia_TIM_STOP <= '1';
      when S2_TIMER   => inicia_TIM_CORTESIA <= '1';
      when others     => null;
    end case;
  end process;

end Behavioral;


