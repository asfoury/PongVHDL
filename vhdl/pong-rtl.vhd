architecture rtl of pong is


    component movement_full is
        generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);      
        port(
     ext_change : in std_logic;
     enable     : in std_logic;
     reset      : in std_logic;
     clock      : in std_logic;
     pos        : out std_logic_vector;
     dir_o      : out std_logic);
     end component;

        component clock_divider is
        PORT ( 
          clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic );
          end component;

    component score is
        port(x_pos  : in std_logic_vector(11 downto 0);
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     user   : out std_logic_vector(7 downto 0);
     sys    : out std_logic_vector(7 downto 0);
     over   : out std_logic);
    end component;

    component bat is
        port(button_up   : in std_logic;
     button_down : in std_logic;
     enable      : in std_logic;
     reset       : in std_logic;
     clock       : in std_logic;
     bat_o       : out std_logic_vector(8 downto 0));
     end component;

    component debouncer is
        port(button   : in std_logic;
     enable   : in std_logic;
     reset    : in std_logic;
     clock    : in std_logic;
     button_o : out std_logic);
     end component;

    component collision is 
    port(x_dir   : in std_logic;
     y_dir   : in std_logic;
     x_pos   : in std_logic_vector(11 downto 0);
     y_pos   : in std_logic_vector(8 downto 0);
     bat_pos : in std_logic_vector(8 downto 0);
     change  : out std_logic);
     end component;

    SIGNAL s_enable: std_logic; 
    SIGNAL s_reset: std_logic;
    SIGNAL s_ext_change_X: std_logic;
    SIGNAL s_ext_change_Y: std_logic:='0';

    SIGNAL s_dir_X, s_dir_Y: std_logic;
    SIGNAL s_X_pos: std_logic_vector(11 downto 0);
    SIGNAL s_Y_pos: std_logic_vector(8 downto 0);
    SIGNAL s_over: std_logic;
    SIGNAL s_bat_Y_pos: std_logic_vector(8 downto 0);
    SIGNAL s_button_up, s_button_down: std_logic;
    SIGNAL s_n_button_up, s_n_button_down: std_logic;

    CONSTANT c_bat_pos_X:std_logic_vector(11 downto 0) := "010000000000";

begin


    s_reset <= not(n_reset);
  

    movementFullY : movement_full
    GENERIC MAP(
        WIDTH => 9,
        INIT  => "000100000"
    )
    PORT MAP(
        ext_change => s_ext_change_Y,
        enable => s_enable,
        reset => s_reset,
        clock => clock,
        pos => s_Y_pos,
        dir_o => s_dir_Y
    );  

    movementFullX : movement_full
    GENERIC MAP(
        WIDTH => 12,
        INIT  => "000100000000"
    )
    PORT MAP(
        ext_change => s_ext_change_X,
        enable => s_enable,
        reset =>s_reset,
        clock => clock,
        pos => s_X_pos  ,
        dir_o => s_dir_X

        
    );

    gameScore : score
    PORT MAP(
        x_pos => s_X_pos,
        enable => s_enable,
        reset => s_reset,
        clock => clock,
        user => user,
        sys => sys,
        over => s_over
    );

    col: collision
    PORT MAP(
        x_pos => s_X_pos,
        y_pos => s_Y_pos,
        bat_pos => s_bat_Y_pos,
        x_dir => s_dir_X,
        y_dir => s_dir_Y,
        change => s_ext_change_X
);

    userBat : bat
    PORT MAP(
            enable => s_enable,
            reset => s_reset,
            bat_o => s_bat_Y_pos,
            button_up => s_button_up,
            button_down => s_button_down,
            clock => clock
    );

    decouncerButtonUp : debouncer
    PORT MAP(
        button => n_button_up,
        clock => clock,
        enable => s_enable,
        reset => s_reset,
        button_o => s_button_up
    );

    decouncerButtonDown : debouncer
    PORT MAP(
        button => n_button_down,
        clock => clock,
        enable => s_enable,
        reset => s_reset,
        button_o => s_button_down   
    );


    



    clockDivider : clock_divider
    PORT MAP(
        reset =>s_reset,
        clock => clock,
        enable => s_enable
    );
    

    display : FOR y IN 8 DOWNTO 0 GENERATE
        oneline : FOR x IN 11 DOWNTO 0 GENERATE
            playfield(y*12+x) <= (s_Y_pos(y) AND s_X_pos(x)) OR (s_bat_Y_pos(y) and c_bat_pos_X(x));
        END GENERATE oneline;
    END GENERATE display;


    
    





end architecture rtl; 
