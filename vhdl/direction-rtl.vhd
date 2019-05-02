architecture rtl of direction is

SIGNAL s_cur_state, s_next_state : std_logic;

BEGIN

dff : PROCESS (clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_cur_state <= '0';
				ELSE s_cur_state <= s_next_state;
			END IF;
		END IF;
	END PROCESS dff;

transition : process(s_cur_state, change, enable)
	BEGIN
		CASE (s_cur_state) IS
			WHEN '0' => if change = '1' and enable = '1' THEN s_next_state <= '1'; 
			ELSE s_next_state <= '0';
					 END IF;
			
			WHEN '1' => if change = '1' and enable = '1' THEN s_next_state <= '0';
			ELSE s_next_state <= '1';
					 END IF;
			WHEN OTHERS => s_next_state <= s_cur_state;
		END CASE;
END process transition;
dir <= s_cur_state;


 		
end architecture rtl;      
