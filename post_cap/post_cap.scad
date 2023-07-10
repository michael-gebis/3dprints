

INNER_WIDTH_MM          = 36;
INNER_LENGTH_MM         = 36;
HEIGHT_MM               = 36;
WALL_THICKNESS_MM       = 2;
BASE_THICKNESS_MM       = 4;
FILLET_RAD_MM           = 4;

HOLE_DIA_MM             = 3;


FILLED_DIA_MM           = FILLET_RAD_MM*2;
$fn=72;

module rounded_cube(length, width, height, fillet_radius) {
    hull() {
        translate([-1*(length/2-fillet_radius), -1*(width/2 - fillet_radius), 0]) {
            cylinder(h=height, r=fillet_radius);
        }
        translate([-1*(length/2-fillet_radius), (width/2 - fillet_radius), 0]) {
            cylinder(h=height, r=fillet_radius);
        }
        translate([(length/2-fillet_radius), -1*(width/2 - fillet_radius), 0]) {
            cylinder(h=height, r=fillet_radius);
        }
        translate([(length/2-fillet_radius), (width/2 - fillet_radius), 0]) {
            cylinder(h=height, r=fillet_radius);
        }
    };
}

module main_body() {
    difference() {
        rounded_cube(INNER_WIDTH_MM  + WALL_THICKNESS_MM*2,
                     INNER_LENGTH_MM + WALL_THICKNESS_MM*2,
                     HEIGHT_MM, 
                     FILLET_RAD_MM+WALL_THICKNESS_MM);
        translate([0,0,BASE_THICKNESS_MM]) {
            rounded_cube(INNER_WIDTH_MM, INNER_LENGTH_MM, HEIGHT_MM, FILLET_RAD_MM);
        }
    }
}

module holes() {
   translate([0,0,HEIGHT_MM/2]) {
        union() {
            rotate([90,0,0]) {
                cylinder(h=INNER_WIDTH_MM*2, d=HOLE_DIA_MM, center=true);
            }
            rotate([0,90,0]) {
                cylinder(h=INNER_LENGTH_MM*2, d=HOLE_DIA_MM, center=true);
            }
        }
    } 
}

module main() {
    
    difference() {
        main_body();
        holes();
    }
}

main();

