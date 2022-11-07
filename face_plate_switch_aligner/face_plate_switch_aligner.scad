// Sizes are in mm
$fn = 50;
CENTER_TO_HOLE_Y = 48.4;
HOLE_TO_HOLE_X = 46.0;
FRAME_Z = 5.0;
PIN_DIA = 2.7;
HEAD_DIA = 5.5;
HEAD_DEPTH = 3.0;
//PIN_Z = 2.0;

BEAM_WIDTH=8.0;


module beam(x,y,z) {
    difference() {
        translate([-x/2, -y/2, 0]) {
            cube([x,y,z]);
        }
        union() {
            cylinder(h=FRAME_Z,r=(PIN_DIA/2));
            translate([0, 0, FRAME_Z-HEAD_DEPTH]) {
                cylinder(h=HEAD_DEPTH, r=HEAD_DIA/2);
            }
        }
    }

}

module outlet() {
    union() {
        translate([0,CENTER_TO_HOLE_Y,0]) {
            beam(HOLE_TO_HOLE_X, BEAM_WIDTH, FRAME_Z);
        }
        translate([0,-CENTER_TO_HOLE_Y,0]){
            beam(HOLE_TO_HOLE_X, BEAM_WIDTH, FRAME_Z);
        }
    }
}

module gang(n) {
    union() {
        translate([-HOLE_TO_HOLE_X/2-BEAM_WIDTH, -CENTER_TO_HOLE_Y-BEAM_WIDTH/2,0]) {
            cube([BEAM_WIDTH,CENTER_TO_HOLE_Y*2+BEAM_WIDTH,FRAME_Z]);
        }
        for (i = [0:(n-1)]){
            translate([HOLE_TO_HOLE_X*i,0,0]) outlet();
        }
        translate([-HOLE_TO_HOLE_X/2 + n*HOLE_TO_HOLE_X, -CENTER_TO_HOLE_Y-BEAM_WIDTH/2, 0]) {
            cube([BEAM_WIDTH,CENTER_TO_HOLE_Y*2+BEAM_WIDTH,FRAME_Z]);
        }
            
    }
}

gang(4);