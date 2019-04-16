/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

module mem_system(/*AUTOARG*/
    // Outputs
    DataOut, Done, Stall, CacheHit, err,
    // Inputs
    Addr, DataIn, Rd, Wr, createdump, clk, rst
    );

    input [15:0] Addr;
    input [15:0] DataIn;
    input        Rd;
    input        Wr;
    input        createdump;
    input        clk;
    input        rst;

    output [15:0] DataOut;
    output Done;
    output Stall;
    output CacheHit;
    output err;

    wire [15:0] ctrl_addr_out,
                ctrl_data_out,
                mem_data_out,
                mux_data_out,
                cache_data_out;

    wire[4:0] cache_tag_out,
              mux_tag_out;

    wire [2:0] cache_offset,
               mem_offset;

    wire data_src,
         ctrl_comp,
         ctrl_write,
         tag_src,
         ctrl_rd_out,
         ctrl_wr_out,
         cache_valid_out,
         cache_dirty_out,
         cache_hit_out,
         cache_err,
         cache_enable,
         mem_err,
         ctrl_err;

    /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
    parameter memtype = 0;
    cache #(0 + memtype) c0(
        // Outputs
        .tag_out              (cache_tag_out),
        .data_out             (cache_data_out),
        .hit                  (cache_hit_out),
        .dirty                (cache_dirty_out),
        .valid                (cache_valid_out),
        .err                  (cache_err),
        // Inputs
        .enable               (cache_enable),
        .clk                  (clk),
        .rst                  (rst),
        .createdump           (createdump),
        .tag_in               (ctrl_addr_out[15:11]),
        .index                (ctrl_addr_out[10:3]),
        .offset               (cache_offset),
        .data_in              (mux_data_out),
        .comp                 (ctrl_comp),
        .write                (ctrl_write),
        .valid_in             (1'b1));

    four_bank_mem mem(
        // Outputs
        .data_out          (mem_data_out),
        .stall             (Stall),
        .busy              (),
        .err               (mem_err),
        // Inputs
        .clk               (clk),
        .rst               (rst),
        .createdump        (createdump),
        .addr              ({mux_tag_out,
                             ctrl_addr_out[10:3], 
                             mem_offset}),
        .data_in           (cache_data_out),
        .wr                (ctrl_wr_out),
        .rd                (ctrl_rd_out));


    // your code here
    cache_controller controller(
        // Outputs
        .addr_out(ctrl_addr_out),
        .data_out(ctrl_data_out),
        .cache_offset(cache_offset),
        .cache_enable(cache_enable),
        .mem_offset(mem_offset),
        .write(ctrl_write),
        .comp(ctrl_comp),
        .wr_out(ctrl_wr_out),
        .rd_out(ctrl_rd_out),
        .data_src(data_src),
        .tag_src(tag_src),
        .done(Done),
        .err(ctrl_err),
        // Inputs
        .addr_in(Addr),
        .data_in(DataIn),
        .rd_in(Rd),
        .wr_in(Wr),
        .cache_valid(cache_valid_out),
        .cache_dirty(cache_dirty_out),
        .cache_hit(cache_hit_out),
        .clk(clk),
        .rst(rst)
    );

    mux2_1_16b mux_data(
        .InA(ctrl_data_out),
        .InB(mem_data_out),
        .S(data_src),
        .Out(mux_data_out));

    mux2_1 mux_tag_0(
        .InA(ctrl_addr_out[0]),
        .InB(cache_tag_out[0]),
        .S(tag_src),
        .Out(mux_tag_out[0]));

    mux2_1 mux_tag_1(
        .InA(ctrl_addr_out[1]),
        .InB(cache_tag_out[1]),
        .S(tag_src),
        .Out(mux_tag_out[1]));

    mux2_1 mux_tag_2(
        .InA(ctrl_addr_out[2]),
        .InB(cache_tag_out[2]),
        .S(tag_src),
        .Out(mux_tag_out[2]));

    mux2_1 mux_tag_3(
        .InA(ctrl_addr_out[3]),
        .InB(cache_tag_out[3]),
        .S(tag_src),
        .Out(mux_tag_out[3]));

    mux2_1 mux_tag_4(
        .InA(ctrl_addr_out[4]),
        .InB(cache_tag_out[4]),
        .S(tag_src),
        .Out(mux_tag_out[4]));

    assign DataOut = cache_data_out;
    assign CacheHit = cache_hit_out;
    assign err = cache_err | mem_err | ctrl_err;

endmodule // mem_system

// DUMMY LINE FOR REV CONTROL :9:
