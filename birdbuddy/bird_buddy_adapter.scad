// This file uses units of inches
// OpenSCAD usually uses mm
// Conversion happens at the bottom

$fn = 100;

MM_PER_INCH         = 25.4;

ADAPTER_HEIGHT      = 2.0;      // 0.4 for testing
ADAPTER_OUTER_DIA   = 1.57;     // Measured 1.55
ADAPTER_INNER_DIA   = 1.39;     // Measured 1.37
ADAPTER_LIP_HEIGHT  = 0.10;     // Seems reasonable
PIPE_WALL_THICKNESS = 0.17;     // Measured 0.16
ADAPTER_LIP_DIA     = ADAPTER_OUTER_DIA + PIPE_WALL_THICKNESS*2;
FRICTION_GRIP_DIA   = 0.02;

module adapter() {
    difference() {
        union() {
            // Main barrel
            cylinder(h=ADAPTER_HEIGHT, r=ADAPTER_OUTER_DIA/2);
            // Lip
            cylinder(h=ADAPTER_LIP_HEIGHT, r = ADAPTER_LIP_DIA/2);
        }
        // Bore hole
        cylinder(h=ADAPTER_HEIGHT, r=ADAPTER_INNER_DIA/2);
    }
}

module friction_grip_single() {
     translate([ADAPTER_OUTER_DIA/2,0,0]) {
         cylinder(h=ADAPTER_HEIGHT, r=FRICTION_GRIP_DIA);
     }   
}

module friction_grips() {
    union() {
        rotate([  0,  0,  0]) friction_grip_single();
        rotate([  0,  0, 60]) friction_grip_single();        
        rotate([  0,  0,120]) friction_grip_single();
        rotate([  0,  0,180]) friction_grip_single();
        rotate([  0,  0,240]) friction_grip_single();
        rotate([  0,  0,300]) friction_grip_single();        
    }
}

scale([MM_PER_INCH, MM_PER_INCH, MM_PER_INCH]) {
    union() {
        adapter();
        friction_grips();
    }
};
