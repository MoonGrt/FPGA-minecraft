`timescale  1ns / 1ps

module tb_DDR_tester;

// tester Parameters
parameter PERIOD  = 10;
parameter PERIOD_x1  = 5;

// tester Inputs
reg   clk                                  = 0 ;
reg   clk_x1                               = 0 ;
reg   app_cmd_rdy                          = 1 ;
reg   app_data_rdy                         = 1 ;
reg   app_rdata_valid                      = 0 ;
reg   app_rdata_end                        = 0 ;
reg   [128-1:0]  app_rdata                 = 0 ;
reg   init_calib_complete                  = 1 ;

// tester Outputs
wire  rst_n                                ;
wire  [27-1:0]  app_addr                   ;
wire  app_cmd_en                           ;
wire  [2:0]  app_cmd                       ;
wire  app_wren                             ;
wire  app_data_end                         ;
wire  [128-1:0]  app_data                  ;
wire  [5:0]  app_burst_number              ;
wire  txp                                  ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end
initial
begin
    forever #(PERIOD_x1/2)  clk_x1=~clk_x1;
end

DDR_tester  u_tester (
    .clk                     ( clk                            ),
    .clk_x1                  ( clk_x1                         ),
    .app_cmd_rdy             ( app_cmd_rdy                    ),
    .app_data_rdy            ( app_data_rdy                   ),
    .app_rdata_valid         ( app_rdata_valid                ),
    .app_rdata_end           ( app_rdata_end                  ),
    .app_rdata               ( app_rdata            [128-1:0] ),
    .init_calib_complete     ( init_calib_complete            ),

    .rst_n                   ( rst_n                          ),
    .app_addr                ( app_addr             [27-1:0]  ),
    .app_cmd_en              ( app_cmd_en                     ),
    .app_cmd                 ( app_cmd              [2:0]     ),
    .app_wren                ( app_wren                       ),
    .app_data_end            ( app_data_end                   ),
    .app_data                ( app_data             [128-1:0] ),
    .app_burst_number        ( app_burst_number     [5:0]     ),
    .txp                     ( txp                            )
);



endmodule