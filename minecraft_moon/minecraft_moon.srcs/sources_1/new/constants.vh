`ifndef CONSTANTS
`define CONSTANTS

// --constants--
// display constants. (dimension divided by 2)
parameter H_SYNC_PULSE = 96;
parameter H_BACK_PORCH = 48;
parameter H_ACTIVE = 640;
parameter H_FRONT_PORCH = 16;
parameter H_LINE_PERIOD = H_SYNC_PULSE + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH;
parameter H_REAL = H_ACTIVE / 2;
parameter V_SYNC_PULSE = 2;
parameter V_BACK_PORCH = 33;
parameter V_ACTIVE = 480;
parameter V_FRONT_PORCH = 10;
parameter V_FRAME_PERIOD = V_SYNC_PULSE + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH;
parameter V_REAL = V_ACTIVE / 2;

// block constants.
parameter TEXTURE_RES = 16;
parameter BLOCK_TYPE = 24;

// map constants.
parameter MAXD = 160000;
parameter MIND = 7;
parameter MAPSIZE_X = 64;
parameter MAPSIZE_Y = 64;
parameter MAPSIZE_Z = 32;
//function is_in_map

// tracing constants.
//parameter SKY_COLOR = (160, 224, 240, 255); // r g b a
parameter TRACE_DIST_RAD_SQUARED = 24 ** 2;

// viewport constants.
parameter LOOKAT_REL_FAC = 2;
parameter CENTER_ADDR = H_REAL * V_REAL / 2 + H_REAL / 2;
parameter EOF_ADDR = H_REAL * V_REAL - 1;

// math constants.
parameter ANGLE_RADIUS = 225;
parameter ANGLE_EIGHTH = 158;
parameter ANGLE_QUARTER = ANGLE_EIGHTH * 2 + 1;
parameter ANGLE_HALF = ANGLE_EIGHTH * 4 + 2;
parameter ANGLE_MODULO = ANGLE_EIGHTH * 8 + 4;

// control constants.
parameter POS_STEP = 32;
parameter ANGLE_STEP = 5;

// time constants.
parameter PPL_FREQ = 40000000;





// --types--
// radix
parameter DISP_RAM_ADDR_RADIX = 17;
parameter BLOCK_TYPE_RADIX = 5;
parameter TEXTURE_ADDR_RADIX = 13;
parameter TEXTURE_IDX_ADDR_RADIX = 8;
parameter TEXTURE_TYPE_RADIX = 5;
parameter MAP_ADDR_RADIX = 17;
parameter INT_RADIX = 22;

// gamepad
parameter PSS_MIDDLE = 128;





`endif // CONSTANTS