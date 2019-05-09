architecture rtl of debouncer is

SIGNAL s_1, s_2, s_3, s_and1, s_and2, s_or, s_button_o: std_logic;




begin

    dff1 : PROCESS (clock, reset,button, s_1)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_1<= '0';
				ELSE s_1 <= button;
			END IF;
		END IF;
	END PROCESS dff1;
    
    dff2 : PROCESS (clock, reset,s_1,s_2)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_2 <= '0';
				ELSE s_2 <= s_1;
			END IF;
		END IF;
    END PROCESS dff2;

    dff3 : PROCESS (clock, reset,s_2, s_3)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_3 <= '0';
				ELSE s_3 <= s_2;
			END IF;
		END IF;
    END PROCESS dff3;
    
    s_and1 <= s_2 and not(s_3);
    s_or <= s_and1 or s_button_o;
    s_and2 <= not(reset or enable) and s_or;

    dff4 : PROCESS (clock, reset,s_button_o, s_and2)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN s_button_o <= '0';
				ELSE s_button_o <= s_and2;
			END IF;
		END IF;
    END PROCESS dff4;

    button_o <= s_button_o;

    




end architecture rtl; 
   
