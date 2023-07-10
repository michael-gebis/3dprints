// Parameterizable safety razor holder by Michael Gebis
// ivymike at gmail and twitter. I'd love to hear from you!

// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty. Use at your own risk!

// I ask but do not require that you credit me if you use or remix this. Thank you!

// Dimensions for the shower hanger
OVERHANG_MM     = 25.4; // The vertical part of the "hook"
MAIN_HANG_MM    = 50.8; // The other vertical part of the "hook"
SHOWER_WALL_MM  = 26.0; // How thick the shower wall is

// Dimensions for the razor holder. Fits most standard safety razors.
RAZOR_LENGTH_MM = 44.0;
RAZOR_WIDTH_MM  = 25.4;
HANDLE_DIA_MM   = 12.0;

// General parameters
THICKNESS_MM    = 3.0;
CHAMFER_MM      = 2.0;
$fn=50;

module rounded_wall(start_x, start_y, end_x, end_y, height, thickness) {
    hull() {
        translate([start_x, start_y, 0]) {
            cylinder(h=height, d=thickness);
        }
        translate([end_x, end_y, 0]) {
            cylinder(h=height, d=thickness);
        }
    }
}

module create_shower_hanger() {
    rounded_wall(-1*(SHOWER_WALL_MM+THICKNESS_MM), MAIN_HANG_MM - OVERHANG_MM,  -1*(SHOWER_WALL_MM+THICKNESS_MM), MAIN_HANG_MM, RAZOR_LENGTH_MM, THICKNESS_MM);
    rounded_wall(-1*(SHOWER_WALL_MM+THICKNESS_MM), MAIN_HANG_MM, 0, MAIN_HANG_MM, RAZOR_LENGTH_MM, THICKNESS_MM);
    rounded_wall(0, MAIN_HANG_MM, 0, 0, RAZOR_LENGTH_MM, THICKNESS_MM);
}

module create_razor_slot() {
    translate([(RAZOR_WIDTH_MM+THICKNESS_MM)/2, -1*(CHAMFER_MM+THICKNESS_MM)*2, RAZOR_LENGTH_MM/2]){
        rotate([-90,0,0]) {
            rounded_wall(0,0,(RAZOR_WIDTH_MM+THICKNESS_MM),0, RAZOR_WIDTH_MM, HANDLE_DIA_MM);
        }
    }
}

module create_razor_holder() {
    difference() {
        union() {
            rounded_wall(0,0, CHAMFER_MM, -1*CHAMFER_MM, RAZOR_LENGTH_MM, THICKNESS_MM);
            rounded_wall(CHAMFER_MM, -1*CHAMFER_MM, RAZOR_WIDTH_MM+THICKNESS_MM-CHAMFER_MM, -1*CHAMFER_MM, RAZOR_LENGTH_MM, THICKNESS_MM);
            rounded_wall(RAZOR_WIDTH_MM+THICKNESS_MM-CHAMFER_MM, -1*CHAMFER_MM, RAZOR_WIDTH_MM+THICKNESS_MM, 0, RAZOR_LENGTH_MM, THICKNESS_MM);
        }
        create_razor_slot();
   }
}

module main() {
    union() {
        create_shower_hanger();
        create_razor_holder();
    }
}

main();


