library ieee;
use ieee.std_logic_1164.all;

entity LED_Blink_Top is
    port (
        i_Clk       : in std_logic;

        o_LED_1     : out std_logic;
        o_LED_2     : out std_logic;
        o_LED_3     : out std_logic;
        o_LED_4     : out std_logic    
    );
end LED_Blink_Top;

architecture RTL of LED_Blink_Top is
begin

    -- Input clock is 25 MHz
    -- Generics represent count values to which interals count before toggling LEDs
    LED_Blink_Inst : entity work.LED_Blink
        generic map (
            g_COUNT_10HZ    => 1250000,
            g_COUNT_5HZ     => 2500000,
            g_COUNT_2HZ     => 6250000,
            g_COUNT_1HZ     => 12500000
        )

        port map (
            i_Clk   => i_Clk,

            o_LED_1 => open,
            o_LED_2 => o_LED_2,
            o_LED_3 => o_LED_3,
            o_LED_4 => o_LED_4
        );
end architecture RTL;