architecture rtl of collision is

    SIGNAL s_colli: std_logic;
    CONSTANT c_zero:std_logic_vector(8 downto 0) := "000000000";

    begin



    


   s_colli <= '1' WHEN ((y_pos and bat_pos) /= c_zero) ELSE '0';     
   change <= (x_pos(9) and x_dir and s_colli);

end architecture rtl;

