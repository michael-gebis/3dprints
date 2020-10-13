wall_thickness = .25;
board_thickness = 1.5;
hinge_width = 1;
hinge_depth = 1.5;
pvc_od = 1.1; //1.060;
thickness = wall_thickness*2 + board_thickness;
radius = thickness/2;

module screwhole()
{
    translate([thickness/2,hinge_width/2,0]) {
        union() {
            cylinder(h=hinge_depth+radius-pvc_od/2, r=.1, $fn=100);
            translate([0,0, hinge_depth+radius-pvc_od/2-.124])
                cylinder(h=.25, r=.140, $fn=100);
        }
    }
}

module screwhole2()
{
    translate([0,hinge_width/2,hinge_depth/4]) {
        rotate([0,90,0]) {
            cylinder(h=thickness*2+.2, r=.1, center=true, $fn=100);
        }
    }
}

module hinge() 
{
    difference() {
        union() {
            cube([thickness, hinge_width, hinge_depth+radius]);
            translate([radius,hinge_width/2,hinge_depth+radius]) {
                rotate([90,0,0]) {
                    difference() {
                        cylinder(h=hinge_width, r=radius, center=true, $fn=100);
                        cylinder(h=hinge_width+1, r=pvc_od/2, center=true, $fn=100);
                    };
                };
            };
        }
        // Notch out board
        translate([wall_thickness,-.05,0]) {
            cube([board_thickness, hinge_width+.1, hinge_depth+.25]);
        }
        // Notch out PVC hole
        translate([radius, hinge_width/2, hinge_depth+radius]) {
            rotate([90,0,0])
                cylinder(h=hinge_width+1, r=pvc_od/2, center=true, $fn=100);
        }
        // Notch out vertical screwhole
        screwhole();
        // Notch out the horizontal screwholes
        screwhole2();
    }
}

module chopper()
{
    translate([wall_thickness+.005, -.5, 0]) {
        cube([board_thickness-.01, hinge_width+1, hinge_depth+radius]);
    }
}

scale([25.4, 25.4, 25.4]) {
    //screwhole2();
    
    difference() {
        hinge();
        chopper();
    }
    
    intersection() {
        hinge();
        chopper();
    }
    
}