POST_WIDTH_MM       = 35.5;   // measured 35.5
WALL_THICKNESS_MM   = 4.0;    // a guess
BOARD_WIDTH_MM      = 20.0;   // measured 19.6
TOP_THICKNESS_MM    = 3.0;

BOARD_HEIGHT_MM     = 148.0;    // a skosh smaller than 6 inches
BLOCK_LENGTH_MM     = 101.6;    // 4 inches
EXTENSION_LENGTH_MM = 104.6;    // 4 inches + 3mm

BOTTOM_HOLE_HEIGHT_MM   = 27.0;
TOP_HOLE_HEIGHT_MM      = 88.0;
HOLE_DIA_MM             = 20.0;

OVERALL_WIDTH_MM    = POST_WIDTH_MM + WALL_THICKNESS_MM*2 + BOARD_WIDTH_MM*2;
OVERALL_LENGTH_MM   = BLOCK_LENGTH_MM + EXTENSION_LENGTH_MM + WALL_THICKNESS_MM;
OVERALL_HEIGHT_MM   = BOARD_HEIGHT_MM + WALL_THICKNESS_MM;
$eps=.01;
$fn=72;

module do_block() {
    difference() {
        union() {
            cube([OVERALL_WIDTH_MM, BLOCK_LENGTH_MM + WALL_THICKNESS_MM, BOARD_HEIGHT_MM+WALL_THICKNESS_MM]);
            translate([OVERALL_WIDTH_MM - WALL_THICKNESS_MM - $eps, $eps, $eps]) {
                cube([WALL_THICKNESS_MM, OVERALL_LENGTH_MM, OVERALL_HEIGHT_MM]);
            }
        }
        union() {
            translate([WALL_THICKNESS_MM, WALL_THICKNESS_MM+$eps, -1*$eps]) {
                cube([BOARD_WIDTH_MM, BLOCK_LENGTH_MM, BOARD_HEIGHT_MM]);
            }
            translate([WALL_THICKNESS_MM + BOARD_WIDTH_MM + POST_WIDTH_MM, WALL_THICKNESS_MM+$eps, -1*$eps]) {
                cube([BOARD_WIDTH_MM, BLOCK_LENGTH_MM, BOARD_HEIGHT_MM]);
            }    
        }
    }
    
}

module do_holes() {
    translate([OVERALL_WIDTH_MM*1.5,160,BOTTOM_HOLE_HEIGHT_MM]){
        rotate([0,-90,0]) {    
            cylinder(h=OVERALL_WIDTH_MM*2,d=HOLE_DIA_MM);
        };
    }
    translate([OVERALL_WIDTH_MM*1.5,160,TOP_HOLE_HEIGHT_MM]){
        rotate([0,-90,0]) {    
            cylinder(h=OVERALL_WIDTH_MM*2,d=HOLE_DIA_MM);
        };
    }

    translate([OVERALL_WIDTH_MM*1.5,BLOCK_LENGTH_MM/2, OVERALL_HEIGHT_MM/3]) {
        rotate([0,-90,0]) {
            cylinder(h=OVERALL_WIDTH_MM*2, d=4.0);
        }
    }
    translate([OVERALL_WIDTH_MM*1.5,BLOCK_LENGTH_MM/2, 2*OVERALL_HEIGHT_MM/3]) {
        rotate([0,-90,0]) {
            cylinder(h=OVERALL_WIDTH_MM*2, d=4.0);
        }
    }
            
    
}

module main() {
    //union() {
    difference() {
        do_block();
        do_holes();
    }
}

main();
    