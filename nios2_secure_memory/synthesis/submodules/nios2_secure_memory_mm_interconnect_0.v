// nios2_secure_memory_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 20.1 720

`timescale 1 ps / 1 ps
module nios2_secure_memory_mm_interconnect_0 (
		input  wire        clk_0_clk_clk,                                                         //                                                       clk_0_clk.clk
		input  wire        custom_secure_mem_instructions_reset_sink_reset_bridge_in_reset_reset, // custom_secure_mem_instructions_reset_sink_reset_bridge_in_reset.reset
		input  wire [31:0] custom_secure_mem_instructions_avalon_master_address,                  //                    custom_secure_mem_instructions_avalon_master.address
		output wire        custom_secure_mem_instructions_avalon_master_waitrequest,              //                                                                .waitrequest
		input  wire [3:0]  custom_secure_mem_instructions_avalon_master_byteenable,               //                                                                .byteenable
		input  wire        custom_secure_mem_instructions_avalon_master_chipselect,               //                                                                .chipselect
		output wire [31:0] custom_secure_mem_instructions_avalon_master_readdata,                 //                                                                .readdata
		input  wire        custom_secure_mem_instructions_avalon_master_write,                    //                                                                .write
		input  wire [31:0] custom_secure_mem_instructions_avalon_master_writedata,                //                                                                .writedata
		output wire [12:0] onchip_mem_s2_address,                                                 //                                                   onchip_mem_s2.address
		output wire        onchip_mem_s2_write,                                                   //                                                                .write
		input  wire [31:0] onchip_mem_s2_readdata,                                                //                                                                .readdata
		output wire [31:0] onchip_mem_s2_writedata,                                               //                                                                .writedata
		output wire [3:0]  onchip_mem_s2_byteenable,                                              //                                                                .byteenable
		output wire        onchip_mem_s2_chipselect,                                              //                                                                .chipselect
		output wire        onchip_mem_s2_clken                                                    //                                                                .clken
	);

	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_waitrequest;   // onchip_mem_s2_translator:uav_waitrequest -> custom_secure_mem_instructions_avalon_master_translator:uav_waitrequest
	wire  [31:0] custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdata;      // onchip_mem_s2_translator:uav_readdata -> custom_secure_mem_instructions_avalon_master_translator:uav_readdata
	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_debugaccess;   // custom_secure_mem_instructions_avalon_master_translator:uav_debugaccess -> onchip_mem_s2_translator:uav_debugaccess
	wire  [33:0] custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_address;       // custom_secure_mem_instructions_avalon_master_translator:uav_address -> onchip_mem_s2_translator:uav_address
	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_read;          // custom_secure_mem_instructions_avalon_master_translator:uav_read -> onchip_mem_s2_translator:uav_read
	wire   [3:0] custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_byteenable;    // custom_secure_mem_instructions_avalon_master_translator:uav_byteenable -> onchip_mem_s2_translator:uav_byteenable
	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdatavalid; // onchip_mem_s2_translator:uav_readdatavalid -> custom_secure_mem_instructions_avalon_master_translator:uav_readdatavalid
	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_lock;          // custom_secure_mem_instructions_avalon_master_translator:uav_lock -> onchip_mem_s2_translator:uav_lock
	wire         custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_write;         // custom_secure_mem_instructions_avalon_master_translator:uav_write -> onchip_mem_s2_translator:uav_write
	wire  [31:0] custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_writedata;     // custom_secure_mem_instructions_avalon_master_translator:uav_writedata -> onchip_mem_s2_translator:uav_writedata
	wire   [2:0] custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_burstcount;    // custom_secure_mem_instructions_avalon_master_translator:uav_burstcount -> onchip_mem_s2_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (32),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (34),
		.UAV_BURSTCOUNT_W            (3),
		.USE_READ                    (0),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (1),
		.USE_BURSTCOUNT              (0),
		.USE_READDATAVALID           (0),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (0),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) custom_secure_mem_instructions_avalon_master_translator (
		.clk                    (clk_0_clk_clk),                                                                                   //                       clk.clk
		.reset                  (custom_secure_mem_instructions_reset_sink_reset_bridge_in_reset_reset),                           //                     reset.reset
		.uav_address            (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (custom_secure_mem_instructions_avalon_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (custom_secure_mem_instructions_avalon_master_waitrequest),                                        //                          .waitrequest
		.av_byteenable          (custom_secure_mem_instructions_avalon_master_byteenable),                                         //                          .byteenable
		.av_chipselect          (custom_secure_mem_instructions_avalon_master_chipselect),                                         //                          .chipselect
		.av_readdata            (custom_secure_mem_instructions_avalon_master_readdata),                                           //                          .readdata
		.av_write               (custom_secure_mem_instructions_avalon_master_write),                                              //                          .write
		.av_writedata           (custom_secure_mem_instructions_avalon_master_writedata),                                          //                          .writedata
		.av_burstcount          (1'b1),                                                                                            //               (terminated)
		.av_beginbursttransfer  (1'b0),                                                                                            //               (terminated)
		.av_begintransfer       (1'b0),                                                                                            //               (terminated)
		.av_read                (1'b0),                                                                                            //               (terminated)
		.av_readdatavalid       (),                                                                                                //               (terminated)
		.av_lock                (1'b0),                                                                                            //               (terminated)
		.av_debugaccess         (1'b0),                                                                                            //               (terminated)
		.uav_clken              (),                                                                                                //               (terminated)
		.av_clken               (1'b1),                                                                                            //               (terminated)
		.uav_response           (2'b00),                                                                                           //               (terminated)
		.av_response            (),                                                                                                //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                                            //               (terminated)
		.av_writeresponsevalid  ()                                                                                                 //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (34),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) onchip_mem_s2_translator (
		.clk                    (clk_0_clk_clk),                                                                                   //                      clk.clk
		.reset                  (custom_secure_mem_instructions_reset_sink_reset_bridge_in_reset_reset),                           //                    reset.reset
		.uav_address            (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (custom_secure_mem_instructions_avalon_master_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (onchip_mem_s2_address),                                                                           //      avalon_anti_slave_0.address
		.av_write               (onchip_mem_s2_write),                                                                             //                         .write
		.av_readdata            (onchip_mem_s2_readdata),                                                                          //                         .readdata
		.av_writedata           (onchip_mem_s2_writedata),                                                                         //                         .writedata
		.av_byteenable          (onchip_mem_s2_byteenable),                                                                        //                         .byteenable
		.av_chipselect          (onchip_mem_s2_chipselect),                                                                        //                         .chipselect
		.av_clken               (onchip_mem_s2_clken),                                                                             //                         .clken
		.av_read                (),                                                                                                //              (terminated)
		.av_begintransfer       (),                                                                                                //              (terminated)
		.av_beginbursttransfer  (),                                                                                                //              (terminated)
		.av_burstcount          (),                                                                                                //              (terminated)
		.av_readdatavalid       (1'b0),                                                                                            //              (terminated)
		.av_waitrequest         (1'b0),                                                                                            //              (terminated)
		.av_writebyteenable     (),                                                                                                //              (terminated)
		.av_lock                (),                                                                                                //              (terminated)
		.uav_clken              (1'b0),                                                                                            //              (terminated)
		.av_debugaccess         (),                                                                                                //              (terminated)
		.av_outputenable        (),                                                                                                //              (terminated)
		.uav_response           (),                                                                                                //              (terminated)
		.av_response            (2'b00),                                                                                           //              (terminated)
		.uav_writeresponsevalid (),                                                                                                //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                                             //              (terminated)
	);

endmodule