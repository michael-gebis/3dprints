// Parameterizable Sheet Holder by Michael Gebis
// ivymike at gmail and twitter. I'd love to hear from you!

// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty. Use at your own risk!

// I ask but do not require that you credit me if you use or remix this. Thank you!

// Remember to keep space for future expansion.
NUM_SLOTS               = 4;

// For more flexible printing, run this twice and create two stls.
DO_RIGHT                = true;
DO_LEFT                 = true;
DO_CENTER_HOLE          = true;

SLOT_HEIGHT_MM          = 2.0;      // Measure your thickest sheet, add around .5 mm

// Finer customization variables with reasonable defaults.
SLOT_SUPPORT_HEIGHT_MM  = 3;        // The size of the support below and top of each slot
WALL_MM                 = 3;        // The size of the wall
WIDTH_MM                = 20;       // The width of each support
LENGTH_MM               = 225;      // Prusa MK3S = 225
RAMP_LENGTH_MM          = 25;       
WEDGE_HEIGHT_MM         = 5;        // Gives "tilt" towards the back so sheets don't slide out

SCREW_HEAD_DIA_MM       = 8;
SCREW_HEAD_HEIGHT_MM    = 2.5;
SCREW_HOLE_DIA_MM       = 3;

REAR_HOLE_OFFSET_MM     = 40;       // Offset from rear
FRONT_HOLE_OFFSET_MM    = 40;       // Offset from front

BLUNTING_MM             = .6;       // Should be >= your nozzle width, plus maybe a little more
$fn                     = 50;       // How smooth are the circular holes.
eps                     = .0001;    // epsilon, used to avoid coincident faces

function get_single_slot_height() = SLOT_HEIGHT_MM+(SLOT_SUPPORT_HEIGHT_MM*2);
function get_height() = NUM_SLOTS*get_single_slot_height();

module create_wall() {
    translate([0,get_height(),0]) {
        rotate([90,0,0]) {
            linear_extrude(get_height()) {                
                polygon(
                    [
                        [0, 0],
                        [LENGTH_MM, 0],
                        [LENGTH_MM, BLUNTING_MM],
                        [LENGTH_MM-RAMP_LENGTH_MM, WALL_MM],
                        [0, WALL_MM]
                    ]
                );
            };
        };
    };
}

module create_single_slot(slot) {
    echo(str(" creating slot ", slot, "..."));
    translate([0, (get_single_slot_height()-eps)*slot, 0]) {
        linear_extrude(WIDTH_MM, convexity=4) {
            polygon(
                points=[
                    [0,0],
                    [LENGTH_MM, 0],
                    [LENGTH_MM, BLUNTING_MM],
                    [LENGTH_MM-RAMP_LENGTH_MM, SLOT_SUPPORT_HEIGHT_MM],
                    [WALL_MM, SLOT_SUPPORT_HEIGHT_MM],
                    [WALL_MM, SLOT_SUPPORT_HEIGHT_MM+SLOT_HEIGHT_MM],
                    [LENGTH_MM-RAMP_LENGTH_MM, SLOT_SUPPORT_HEIGHT_MM + SLOT_HEIGHT_MM],
                    [LENGTH_MM, SLOT_SUPPORT_HEIGHT_MM*2 + SLOT_HEIGHT_MM - BLUNTING_MM],
                    [LENGTH_MM, SLOT_SUPPORT_HEIGHT_MM*2 + SLOT_HEIGHT_MM],
                    [0, SLOT_SUPPORT_HEIGHT_MM*2+SLOT_HEIGHT_MM]
                ],
                convexity=4 // For proper preview rendering
            );

        };
    };
}

module create_top_wedge() {
    translate([0, get_height()-eps*NUM_SLOTS, 0]) {
        linear_extrude(WIDTH_MM) {
            polygon(
                [
                    [0,0],
                    [LENGTH_MM, 0],
                    [LENGTH_MM, BLUNTING_MM],
                    [0, WEDGE_HEIGHT_MM]
                ]
            );
        };
    };
}

module create_single_hole() {
    rotate([270, 0, 0]) {
        cylinder(h=WEDGE_HEIGHT_MM * 2, d=SCREW_HOLE_DIA_MM);
        translate([0, 0, -2*get_height() + SCREW_HEAD_HEIGHT_MM] ) {
            cylinder(h=get_height()*2, d=SCREW_HEAD_DIA_MM);
        };
    };
};

module create_holes() {
    // Rear
    translate([REAR_HOLE_OFFSET_MM, get_height()-SLOT_SUPPORT_HEIGHT_MM, WIDTH_MM/2,]) {
        create_single_hole();
    };

    // Center
    CENTER_HOLE_OFFSET_MM = (REAR_HOLE_OFFSET_MM + LENGTH_MM - FRONT_HOLE_OFFSET_MM)/2;
    translate([CENTER_HOLE_OFFSET_MM, get_height()-SLOT_SUPPORT_HEIGHT_MM, WIDTH_MM/2,]) {
        create_single_hole();
    };
  
    // Front
    translate([LENGTH_MM - FRONT_HOLE_OFFSET_MM, get_height()-SLOT_SUPPORT_HEIGHT_MM, WIDTH_MM/2,]) {
        create_single_hole();
    };
}

module create_right_holder() {
    translate([0, 10, 0]) {
        difference() {
            union() {
                for (slot = [0 : NUM_SLOTS-1]) {
                    create_single_slot(slot);
                }
                create_top_wedge();
                create_wall();
            };
            create_holes();
        };
    };
}

module create_left_holder() {
    // Let's hear it for mirror()!
    mirror([0, 1, 0]) {
        create_right_holder();
    };
}

module main() {
    if (DO_LEFT) {
        echo("Creating left holder...");
        create_left_holder();
    }

    if (DO_RIGHT) {
        echo("Creating right holder...");
        create_right_holder();
    };
    echo("Done!");
}

main();