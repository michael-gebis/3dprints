$fn=50;

FRONT_WIDTH_MM          = 75;
FRONT_HEIGHT_MM         = 75;
FRONT_DEPTH_MM          = 15;
HOLE_CENTER_X_MM        = FRONT_WIDTH_MM/2;
HOLE_CENTER_Z_MM        = FRONT_WIDTH_MM/2;
HOLE_DISPLACEMENT_MM    = 27.7;
HOLE_DIA_MM             = 3.0; /* For M3 drive; actual holes measured on stand 4.4; */
PIPE_DIA_MM             = 48.4;
BRACE_THICK_MM          = FRONT_WIDTH_MM/2 - PIPE_DIA_MM/2;
NUT_DIA_MM              = 8;
NUT_THICK_MM            = 2;
ZIP_TIE_THICK_MM        = 1.0;
ZIP_TIE_WIDTH_MM        = 3.6;

module hole() {
    //rotate([ -90, 0, 0]) cylinder(h=FRONT_DEPTH_MM, r=HOLE_DIA_MM/2);
    
    translate([0,0, HOLE_DISPLACEMENT_MM]) {
        rotate([ -90, 0, 0]) {
            cylinder(h=FRONT_DEPTH_MM+20, d=HOLE_DIA_MM);
            translate([0,0,FRONT_DEPTH_MM-NUT_THICK_MM]) {
                cylinder(h=FRONT_DEPTH_MM+20, d=NUT_DIA_MM);
            };
        };
    };    
}
    
module holes() {
    translate([HOLE_CENTER_X_MM, 0, HOLE_CENTER_Z_MM]) {
        union() {
            rotate([0,0,0]) hole();
            rotate([0,120,0]) hole();
            rotate([0,240,0]) hole();
        };
    };
}

module zip_tie_holes() {
    union() {
        translate([0,FRONT_DEPTH_MM,15])                    cube([FRONT_WIDTH_MM, ZIP_TIE_THICK_MM, ZIP_TIE_WIDTH_MM]);
        translate([0,FRONT_DEPTH_MM,FRONT_HEIGHT_MM/2])     cube([FRONT_WIDTH_MM, ZIP_TIE_THICK_MM, ZIP_TIE_WIDTH_MM]);
        translate([0,FRONT_DEPTH_MM,FRONT_HEIGHT_MM-18])    cube([FRONT_WIDTH_MM, ZIP_TIE_THICK_MM, ZIP_TIE_WIDTH_MM]);
    };
}

module front() {
    difference() {
        cube([FRONT_WIDTH_MM,FRONT_DEPTH_MM,FRONT_HEIGHT_MM]);
        union() {
            holes();
            zip_tie_holes();
        };
    };
}

module brace() {
    translate([HOLE_CENTER_X_MM, FRONT_DEPTH_MM + PIPE_DIA_MM/2 + ZIP_TIE_THICK_MM*2,0]) {
        difference() {
            cylinder(h=FRONT_HEIGHT_MM, d=FRONT_WIDTH_MM);
            cylinder(h=FRONT_HEIGHT_MM, d=PIPE_DIA_MM);
        }
    }
    translate([0,FRONT_DEPTH_MM,0]) {
        cube([BRACE_THICK_MM,PIPE_DIA_MM/2, FRONT_HEIGHT_MM]);
    };
    translate([BRACE_THICK_MM+PIPE_DIA_MM, FRONT_DEPTH_MM, 0]) {
        cube([BRACE_THICK_MM,PIPE_DIA_MM/2, FRONT_HEIGHT_MM]);
    }        
}

module front_chopper() {
    union() {
        cube([FRONT_WIDTH_MM,FRONT_DEPTH_MM,FRONT_HEIGHT_MM]);
        translate([BRACE_THICK_MM,FRONT_DEPTH_MM,0]) {
           cube([PIPE_DIA_MM, PIPE_DIA_MM/4+ZIP_TIE_THICK_MM*2, FRONT_HEIGHT_MM]);
        };
    };
}

module back_chopper() {
    union() {
        translate([0, FRONT_DEPTH_MM + PIPE_DIA_MM/2, 0]) {
            cube([FRONT_WIDTH_MM, 100, FRONT_HEIGHT_MM]);
        };
        translate([0, FRONT_DEPTH_MM, 0]) {
            cube([BRACE_THICK_MM, 100, FRONT_HEIGHT_MM]);
        };
        translate([PIPE_DIA_MM + BRACE_THICK_MM, FRONT_DEPTH_MM, 0]) {
            cube([BRACE_THICK_MM, 100, FRONT_HEIGHT_MM]);
        };
    };
}
module main() {
    //front_chopper();
    FRONT=1;
    BRACE=0;
    if (FRONT) {
        difference() {
            intersection() {
                union() {
                    front();
                    brace();
                };
                front_chopper();
            };
            union() {
                holes();
                zip_tie_holes();
            };
        };
    }
    if (BRACE) {
        difference() {
            intersection() {
                union() {
                    front();
                    brace();
                };
                back_chopper();
            };
        };
        //brace();
    }
    //zip_tie_holes();
    
//    translate([0,FRONT_DEPTH_MM,0]) {
//        cube([BRACE_THICK_MM,PIPE_DIA_MM/2, FRONT_HEIGHT_MM]);
//    };    
}

main();