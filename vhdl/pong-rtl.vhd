architecture rtl of pong is


    component movement_full is
        port(
     ext_change : in std_logic;
     enable     : in std_logic;
     reset      : in std_logic;
     clock      : in std_logic;
     pos        : out std_logic_vector(WIDTH - 1 downto 0);
     dir_o      : out std_logic);
     end component;

     component clock_divide is
        PORT ( clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic );
          end component;

    SIGNAL s_enable: std_logic; 
    SIGNAL s_ext_change: std_logic;
    SIGNAL s_dir_o1, s_dir_o2: std_logic;
    SIGNAL s_X_pos: std_logic_vector(11 downto 0);
    SIGNAL s_Y_pos: std_logic_vector(8 downto 0);

begin

    movementFullY : movment_full
    GENERIC MAP(
        WIDTH => WIDTH,
        INIT  => '000100000'
    )
    PORT MAP(
        ext_change => s_ext_change,
        enable => enable,
        reset => n_reset,
        clock => clock,
        pos => s_Y,
        dir_o => s_sir_o1
    );

    movementFullX : movment_full
    GENERIC MAP(
        WIDTH => 12,
        INIT  => '000100000000'
    )
    PORT MAP(
        ext_change => s_ext_change,
        enable => enable,
        reset => n_reset,
        clock => clock,
        pos => s_X,
        dir_o => s_sir_o2

        
    );

    clockDivider : clock_divider
    PORT MAP(
        reste => reset,
        clock => clock,
        enable => s_enable
    );

    display : FOR y IN 8 DOWNTO 0 GENERATE
        oneline : FOR x IN 11 DOWNTO 0 GENERATE
            playfield(y*12+x) <= s_Y_pos(y) AND s_X_pos(x);
        END GENERATE oneline;
    END GENERATE display;


    
    





end architecture rtl; 
