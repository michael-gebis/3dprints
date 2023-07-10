
MAX_SIZE_MM = 30;
//BLUNTNESS_MM = .6;

DIAMETER_MM_LIST = [15, 18, 20, 22, 25, 28, 30];
ANGLE_LIST = [ 15, 20, 25, 30, 35, 40, 45, 50 ];
BLUNTNESS_MM = 1;
TEXT_DEPTH_MM=0.2;

module create_wedge(diameter, angle) {
    translate([-0.5*diameter, -0.5*diameter, 0]) {
        rotate([90,0,90]) {
            linear_extrude(MAX_SIZE_MM) {
                polygon([
                    [0,0],
                    [MAX_SIZE_MM, 0],
                    [MAX_SIZE_MM, BLUNTNESS_MM],
                    [MAX_SIZE_MM, MAX_SIZE_MM * tan(angle)],
                    [0, BLUNTNESS_MM]
                ]);
            };
        };
    };
}

module create_stand(diameter, angle) {
/*
        TEXT_SIZE=3;

                rotate([180, 0, 0]) {
                    linear_extrude(TEXT_DEPTH_MM) {
                        //translate([0, TEXT_SIZE+1,0]) { 
                            text(str("d=", diameter), size=TEXT_SIZE, halign="center", valign="top");
                        //}
                        text(str("a=",angle), size=TEXT_SIZE, halign="center", valign="bottom");
                    }
                }

*/

    difference() {

        intersection() {
            create_wedge(diameter, angle);
            cylinder(h=MAX_SIZE_MM*2*tan(angle), d=diameter);
        }

        //mytext();
        TEXT_SIZE=3;

        translate([0, 0, TEXT_DEPTH_MM-.01]) {
            rotate([180, 0, 180]) {
                linear_extrude(TEXT_DEPTH_MM+.01) {
                    //translate([0, TEXT_SIZE+1,0]) { 
                        text(str("d", diameter), size=TEXT_SIZE, halign="center", valign="top");
                    //}
                    text(str("a",angle), size=TEXT_SIZE, halign="center", valign="bottom");
                }
            }
        }

    }

}


module demo() {
    
    diameters   = [10, 15, 20, 25];
    angles      = [20,25, 30, 35, 40];
    
    for (i = [0: len(diameters) - 1]) {
        for (j = [0: len(angles) - 1]) {
            echo(str("d=", diameters[i], " a=", angles[j]));
            translate([i*MAX_SIZE_MM, j*MAX_SIZE_MM, 0]) {
               create_stand(diameters[i], angles[j]);
            }
       }
   } 
}

module main() {
    demo();
}

main();