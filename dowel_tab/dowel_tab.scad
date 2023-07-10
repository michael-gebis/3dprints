// Paramaterizable Window Security Dowel Tab by Michael Gebis
// ivymike at gmail and twitter. I'd love to hear from you!

// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty. Use at your own risk!

// I ask but do not require that you credit me if you use or remix this. Thank you!


// I suggest that you measure the dowel using calipers and test fit.  The nominal
// dimensions of the dowel may be slightly off, and you want a snug fit.
HOLE_DIA_MM         = 12.3;

// Reasonable defaults for everything else:
HEIGHT_MM           = 15;
TAB_THICKNESS_MM    = 1.5;
WALL_THICKNESS_MM   = 1;
LENGTH_MM           = 20;

$fn=50;

module create_tab() {
    hull() {
        cylinder(h=HEIGHT_MM, d=TAB_THICKNESS_MM);
        translate([LENGTH_MM,0,0]) {
            cylinder(h=HEIGHT_MM,d=TAB_THICKNESS_MM);
        }
    }
    translate([LENGTH_MM,0,0]) {
        cylinder(h=HEIGHT_MM, d=TAB_THICKNESS_MM*2);
    }
}

module create_all() {
    difference() {
        union() {
            create_tab();
            // Create the main body
            cylinder(h=HEIGHT_MM, d=HOLE_DIA_MM+WALL_THICKNESS_MM*2);
        }
        translate([0,0,WALL_THICKNESS_MM]) {
            // "Drill" out the dowel hole
            cylinder(h=HEIGHT_MM, d=HOLE_DIA_MM);
        }
    }
}

create_all();
