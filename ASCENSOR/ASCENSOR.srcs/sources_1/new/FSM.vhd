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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
port(
reset : in std_logic;
CLK : in std_logic;
--Sensoreds y botoneras
BTN_clean: in std_logic_vector(3 downto 0);
S_Puerta_Clean    : in std_logic;
S_Presencia_Clean : in std_logic;
S_Planta_Clean    : in std_logic;
p_actual: in integer range 0 to 3;
--temporizador
TIM_STOP: in std_logic ;
inicia_TIM_STOP: out std_logic;
TIM_CORTESIA: in std_logic ;
inicia_TIM_CORTESIA: out std_logic;
--salidas
motor_ascensor: out std_logic_vector(1 downto 0);
motor_puertas: out std_logic_vector(1 downto 0);
inicio_tim1: out std_logic
 );
end FSM;

architecture Behavioral of FSM is
type STATE is(S0_STDBY,S1_CERRAR,S2_TIMER,S3_SELECTOR,S4_ABRIR,S_BAJAR,S_SUBIR,S_DETENER);
signal current_state,next_state: STATE;
signal flag:std_logic := '0';
signal piso_destino : integer range 0 to 3 :=0;
begin
--registro de estados
state_register: process (reset,CLK)
begin
if reset = '0' then 
current_state <= S0_STDBY;
piso_destino<= 0;
flag <= '0';
elsif rising_edge(CLK) THEN 
current_state<= next_state;
--PARA GUARDAR EL BOTON QUE HEMOS PULSADO
if current_state= S0_STDBY then 
if BTN_Clean(0)= '1' then piso_destino<='0';
elsif BTN_Clean(1)= '1' then piso_destino<='1';
elsif BTN_Clean(2)= '1' then piso_destino<='2';
elsif BTN_Clean(3)= '1' then piso_destino<='3';
end if;

--flag para diferenciar el abrir que antes era 2 y que ahora esta incluido en 4
if current_state= S1_CERRAR and S_Presencia_Clean= '1' then 
    flag<='1';
elsif current_state=S3_SELECTOR THEN 
    flag<='0';
end if;
end if;
end process;

nexstate_dec:process(current_state,BTN_Clean,p_actual,piso_destino,
S_Presencia_Clean,S_Puerta_Clean,S_Planta_Clean,TIM_STOP,TIM_CORTESIA,flag)
begin
next_state<=current_state;
case current_state is
    when S0_STDBY=>
    if (BTN_CLEAN/="0000") and (piso_destino /= p_actual) then
        next_state<=S1_CERRAR;
    end if;
    
    when S1_CERRAR =>
    if S_Presencia_Clean= '1' then next_state <= S4_abrir;
    elsif S_Puerta_Clean= '1' then next_state <= S3_SELECTOR;
    end if;
    
    when S3_SELECTOR =>
    if p_actual > piso_destino then next_state <= S_BAJAR;
    elsif p_actual< piso_destino then next_state <= S_SUBIR;
    else  next_state<= S4_ABRIR;
    end if;
    
    when S_SUBIR|S_BAJAR =>
    if S_Planta_Clean(piso_destino)='1' then 
    next_state <= S_DETENER;
    end if;
    
    when S_DETENER =>
        if TIM_STOP='1' then next_state<= S4_ABRIR;
        end if;
    when S4_ABRIR=>
        if S_Puerta_Clean='1' then 
            if flag='1' then next_state<=S2_TIMER;
            else next_state<=S0_STDBY;
            end if;
        end if;
    when S2_TIMER =>
    if TIM_CORTESIA='1' then next_state<= S1_CERRAR;
    end if;
    
    when others =>
    next_state<=S0_STDBY;
  end case;
end process;

salida: process(current_state)
begin
--por defecto
motor_puertas <= "00";
motor_ascensor <="00";
inicia_TIM_CORTESIA<= '0';
inicia_TIM_STOP <= '0';

case current_state is 
    when S1_CERRAR => motor_puertas<= "10";
    when S4_ABRIR => motor_puertas<= "01";
    when S_SUBIR => motor_ascensor<= "10";
    when S_BAJAR => motor_ascensor<= "01";
    when S_DETENER => inicia_TIM_STOP<='1';
    when S2_TIMER=> inicia_TIM_CORTESIA<='1';
    when others => NULL ;
  end case;
end process;

end Behavioral
