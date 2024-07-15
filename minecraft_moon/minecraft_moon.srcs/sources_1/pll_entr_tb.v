`timescale 1ns / 1ps

module pll_entr_tb;

// ppl_entry Parameters
parameter PERIOD          = 10;
parameter PREPARE_CYCLES  = 4;

// ppl_entry Inputs
reg   clk_ppl                              = 0 ;        
reg   rst                                  = 0 ;        
reg   enable                               = 0 ;        
reg   [31:0]  p_pos_x                      = 0 ;        
reg   [31:0]  p_pos_y                      = 0 ;        
reg   [31:0]  p_pos_z                      = 0 ;        
reg   [31:0]  p_angle_x                    = 0 ;        
reg   [31:0]  p_angle_y                    = 0 ;        
reg   next_pixel_pplout                    = 0 ;        
reg   [DISP_RAM_ADDR_RADIX-1:0]  pixel_addr_pplout = 0 ;
reg   [31:0]  to_color_acc_pplout          = 0 ;        
reg   [2:0]  to_block_p_pplout             = 0 ;        
reg   [1:0]  to_dir_pplout                 = 0 ;
reg   [2:0]  to_hit_p_pplout               = 0 ;
reg   [2:0]  start_p_pplout                = 0 ;
reg   [2:0]  end_p_pplout                  = 0 ;
reg   to_is_behind_pplout                  = 0 ;

// ppl_entry Outputs
wire  is_preparing                         ;
wire  is_eof                               ;
wire  [1:0]  towards_h                     ;
wire  idle                                 ;
wire  [DISP_RAM_ADDR_RADIX-1:0]  pixel_addr ;
wire  [31:0]  color_acc                    ;
wire  [1:0]  from_dir                      ;
wire  [2:0]  block_p                       ;
wire  [2:0]  hit_p                         ;
wire  [2:0]  start_p                       ;
wire  [2:0]  end_p                         ;
wire  is_behind                            ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end


ppl_entry #(
    .PREPARE_CYCLES ( PREPARE_CYCLES ))
 u_ppl_entry (
    .clk_ppl                 ( clk_ppl             ),
    .rst                     ( rst                 ),
    .enable                  ( enable              ),
    .p_pos_x                 ( p_pos_x             ),
    .p_pos_y                 ( p_pos_y             ),
    .p_pos_z                 ( p_pos_z             ),
    .p_angle_x               ( p_angle_x           ),
    .p_angle_y               ( p_angle_y           ),
    .next_pixel_pplout       ( next_pixel_pplout   ),
    .pixel_addr_pplout       ( pixel_addr_pplout   ),
    .to_color_acc_pplout     ( to_color_acc_pplout ),
    .to_block_p_pplout       ( to_block_p_pplout   ),
    .to_dir_pplout           ( to_dir_pplout       ),
    .to_hit_p_pplout         ( to_hit_p_pplout     ),
    .start_p_pplout          ( start_p_pplout      ),
    .end_p_pplout            ( end_p_pplout        ),
    .to_is_behind_pplout     ( to_is_behind_pplout ),
    .is_preparing            ( is_preparing        ),
    .is_eof                  ( is_eof              ),
    .towards_h               ( towards_h           ),
    .idle                    ( idle                ),
    .pixel_addr              ( pixel_addr          ),
    .color_acc               ( color_acc           ),
    .from_dir                ( from_dir            ),
    .block_p                 ( block_p             ),
    .hit_p                   ( hit_p               ),
    .start_p                 ( start_p             ),
    .end_p                   ( end_p               ),
    .is_behind               ( is_behind           )
);

// initial
// begin

//     $finish;
// end




endmodule
