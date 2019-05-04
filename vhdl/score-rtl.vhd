architecture rtl of score is


CONSTANT c_ZERO : std_logic_vector(7 downto 0) :=  "11111100";
CONSTANT c_ONE : std_logic_vector(7 downto 0) :=   "01100000";
CONSTANT c_TWO : std_logic_vector(7 downto 0) :=   "11011010";
CONSTANT c_THREE : std_logic_vector(7 downto 0) := "11110010";
CONSTANT c_FOUR : std_logic_vector(7 downto 0) :=  "01100110";
CONSTANT c_FIVE : std_logic_vector(7 downto 0) :=  "10110110";
CONSTANT c_SIX : std_logic_vector(7 downto 0) :=   "10111110";
CONSTANT c_SEVEN : std_logic_vector(7 downto 0) := "11100000";
CONSTANT c_EIGHT : std_logic_vector(7 downto 0) := "11111110";
CONSTANT c_NINE : std_logic_vector(7 downto 0) :=  "11110110";

SIGNAL s_cur_state_user, s_next_state_user: std_logic_vector(7 downto 0);
SIGNAL s_cur_state_sys, s_next_state_sys: std_logic_vector(7 downto 0);



begin

    dff_user : PROCESS (clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_cur_state_user <= c_ZERO;
				ELSE s_cur_state_user <= s_next_state_user;
			END IF;
		END IF;
    END PROCESS dff_user;

    dff_sys : PROCESS (clock, reset)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_cur_state_sys <= c_ZERO;
				ELSE s_cur_state_sys <= s_next_state_sys;
			END IF;
		END IF;
    END PROCESS dff_sys;
    

transition_user : process(s_cur_state_user, x_pos, enable)
	BEGIN
		CASE (s_cur_state_user) IS
			WHEN c_ZERO => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_ONE; 
			ELSE s_next_state_user <= c_ZERO;
                     END IF;
            WHEN c_ONE => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_TWO; 
			ELSE s_next_state_user <= c_ONE;
                     END IF;
            WHEN c_TWO => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_THREE; 
			ELSE s_next_state_user <= c_TWO;
                     END IF;
            WHEN c_THREE => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_FOUR; 
			ELSE s_next_state_user <= c_THREE;
                     END IF;
            WHEN c_FOUR => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_FIVE; 
			ELSE s_next_state_user <= c_FOUR;
                     END IF;
            WHEN c_FIVE => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_SIX; 
			ELSE s_next_state_user <= c_FIVE;
                     END IF;
            WHEN c_SIX => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_SEVEN; 
			ELSE s_next_state_user <= c_SIX;
                     END IF;
            WHEN c_SEVEN => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_EIGHT; 
			ELSE s_next_state_user <= c_SEVEN;
                     END IF;
            WHEN c_EIGHT => if x_pos(11)='1' and enable = '1' THEN s_next_state_user <= c_NINE; 
            ELSE s_next_state_user <= c_EIGHT;
                     END IF;
            
             WHEN OTHERS => s_next_state_user <= s_cur_state_user;
		END CASE;
END process transition_user;

transition_sys : process(s_cur_state_sys, x_pos, enable)
BEGIN
CASE (s_cur_state_sys) IS
    WHEN c_ZERO => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_ONE; 
        ELSE s_next_state_sys <= c_ZERO;
        END IF;

    WHEN c_ONE => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_TWO; 
        ELSE s_next_state_sys <= c_ONE;
        END IF;

    WHEN c_TWO => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_THREE; 
        ELSE s_next_state_sys <= c_TWO;
        END IF;

    WHEN c_THREE => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_FOUR; 
        ELSE s_next_state_sys <= c_THREE;
        END IF;

    WHEN c_FOUR => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_FIVE; 
        ELSE s_next_state_sys <= c_FOUR;
        END IF;

    WHEN c_FIVE => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_SIX; 
        ELSE s_next_state_sys <= c_FIVE;
        END IF;

        WHEN c_SIX => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_SEVEN; 
        ELSE s_next_state_sys <= c_SIX;
        END IF;

    WHEN c_SEVEN => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_EIGHT; 
        ELSE s_next_state_sys <= c_SEVEN;
        END IF;

    WHEN c_EIGHT => if x_pos(0)='1' and enable = '1' THEN s_next_state_sys <= c_NINE; 
    ELSE s_next_state_sys <= c_EIGHT;
        END IF;

 WHEN OTHERS => s_next_state_sys <= s_cur_state_sys;
END CASE;   
END process transition_sys;

user <= s_cur_state_user;
sys <= s_cur_state_sys;

over <= '1' WHEN s_cur_state_sys = c_NINE or s_cur_state_user = c_NINE ELSE '0';




end architecture rtl;
