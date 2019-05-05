architecture rtl of bat is

SIGNAL s_cur_state, s_next_state : std_logic_vector(8 DOWNTO 0);
CONSTANT c_max_down: std_logic_vector(8 DOWNTO 0)   := "000000111";
CONSTANT c_max_up: std_logic_vector(8 DOWNTO 0) := "111000000";
CONSTANT c_inital_value: std_logic_vector(8 DOWNTO 0) := "000111000";

begin
    dff : PROCESS (clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_cur_state <= c_inital_value;
				ELSE s_cur_state <= s_next_state;
			END IF;
		END IF;
    END PROCESS dff;
    
    transition: PROCESS(s_cur_state,button_up, button_down, enable) IS
    begin
        if button_up='1' and button_down = '0' and s_cur_state /= c_max_up and enable = '1'THEN
            s_next_state <=  s_cur_state(7 downto 0)&'0'; --shift left
        ELSIF button_up='0' and button_down = '1' and s_cur_state /= c_max_down and enable = '1' THEN
            s_next_state <= '0'& s_cur_state(8 downto 1); --shift right

        ELSE
            s_next_state <= s_cur_state;
        END IF;
        END PROCESS transition;
        bat_o <= s_cur_state;   
end architecture rtl;
