library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project_7_Segment_Top is
    port (
        -- Main clock 25 Mhz
        i_Clk       : in std_logic;
        
        -- Input switch
        i_Switch_1   : in std_logic;

        -- Segment 2 is the display on the right side of the Go Board
        o_Segment2_A : out std_logic;
        o_Segment2_B : out std_logic;
        o_Segment2_C : out std_logic;
        o_Segment2_D : out std_logic;
        o_Segment2_E : out std_logic;
        o_Segment2_F : out std_logic;
        o_Segment2_G : out std_logic
    );
end entity Project_7_Segment_Top;

architecture RTL of Project_7_Segment_Top is

    signal w_Switch_1   : std_logic;
    signal r_Switch_1   : std_logic := '0';
    signal r_Count      : integer range 0 to 9 := 0;

    signal w_Segment2_A : std_logic;
    signal w_Segment2_B : std_logic;
    signal w_Segment2_C : std_logic;
    signal w_Segment2_D : std_logic;
    signal w_Segment2_E : std_logic;
    signal w_Segment2_F : std_logic;
    signal w_Segment2_G : std_logic;

begin

    -- Instantiate debounce filter
    Debounce_Inst : entity work.Debounce_Switch
        port map (
            i_Clk       => i_Clk,
            i_Switch    => i_Switch_1,

            o_switch    => w_Switch_1
        );

    -- When switch is pressed, increment counter, reset counter at 9
    p_Switch_Count : process (i_Clk)
    begin
        if rising_edge(i_Clk) then
            r_Switch_1 <= w_Switch_1;

            -- Increment counter when switch is pressed down
            if (w_Switch_1 ='1' and r_Switch_1 ='0') then
                if (r_Count = 9) then
                    r_Count <= 0;       -- Reset counter
                else
                    r_Count <= r_Count + 1;     -- Increment counter
                end if;
            end if;
        end if;
    end process p_Switch_Count;

    SevenSeg1_Inst: entity work.Binary_To_7Segment
        port map(
            i_Clk           => i_Clk,
            i_Binary_Num    => std_logic_vector(to_unsigned(r_Count, 4)),

            o_Segment_A     => w_Segment2_A,
            o_Segment_B     => w_Segment2_B,
            o_Segment_C     => w_Segment2_C,
            o_Segment_D     => w_Segment2_D,
            o_Segment_E     => w_Segment2_E,
            o_Segment_F     => w_Segment2_F,
            o_Segment_G     => w_Segment2_G
        );

    o_Segment2_A <= not w_Segment2_A;
    o_Segment2_B <= not w_Segment2_B;
    o_Segment2_C <= not w_Segment2_C;
    o_Segment2_D <= not w_Segment2_D;
    o_Segment2_E <= not w_Segment2_E;
    o_Segment2_F <= not w_Segment2_F;
    o_Segment2_G <= not w_Segment2_G;

end architecture RTL;