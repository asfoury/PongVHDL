architecture rtl of movement_full is

    component movement is
        port(dir    : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     pos    : out std_logic_vector(WIDTH - 1 downto 0));
     
     end component;
    
    component direction is
        port(change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     dir    : out std_logic);
     
     end component;

     SIGNAL s_dir:std_logic;
     SIGNAL s_pos:std_logic_vector(WIDTH - 1 downto 0);
     SIGNAL s_and1 : std_logic;
     SIGNAL s_and2: std_logic;
     SIGNAL s_or: std_logic;


begin

    mov : movement
    GENERIC MAP(
        WIDTH => WIDTH,
        INIT => INIT
    )
    PORT MAP(
        enable => enable,
        reset => reset,
        clock => clock,
        dir => s_dir,
        pos => s_pos

    );

    dir : direction
    PORT MAP(
        enable => enable,
        reset => reset,
        clock => clock,
        dir => s_dir,
        change => s_or

    );

    dir_o <= s_dir;
    pos <= s_pos;
    s_and1 <= s_pos(WIDTH -2) and s_dir;
    s_and2 <= s_pos(1) and not(s_dir);
    s_or <= s_and1 or s_and2 or ext_change;


    



end architecture rtl;
