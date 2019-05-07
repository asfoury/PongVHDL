architecture rtl of movement is

SIGNAL s_cur_state, s_next_state : std_logic_vector(WIDTH-1 DOWNTO 0);
CONSTANT s_oneZeros : std_logic_vector(WIDTH-1 DOWNTO 0) := (WIDTH -1 => '1',OTHERS => '0');
CONSTANT s_zerosOne : std_logic_vector(WIDTH-1 DOWNTO 0) := (0 => '1',OTHERS => '0');
begin
dff : PROCESS (clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_cur_state <= INIT;
				ELSE s_cur_state <= s_next_state;
			END IF;
		END IF;
	END PROCESS dff;

	transition : PROCESS (dir, enable, s_cur_state) IS
	BEGIN
	IF dir='1' AND enable = '1' and s_cur_state /= s_oneZeros   THEN
		s_next_state <= s_cur_state(WIDTH -2 DOWNTO 0) & '0';--shift_left
	ELSIF  dir='0' AND enable = '1' and s_cur_state /= s_zerosOne  THEN
		s_next_state <= '0'&s_cur_state(WIDTH-1 DOWNTO 1); --shift_right
	ELSE
		s_next_state <= s_cur_state;
	END IF;
	END PROCESS transition;
	
	pos <= s_cur_state;			

end architecture rtl;
