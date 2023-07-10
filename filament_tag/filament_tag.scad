// Parameterizable Sheet Holder by Michael Gebis
// ivymike at gmail and twitter. I'd love to hear from you!

// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty. Use at your own risk!

// I ask but do not require that you credit me if you use or remix this. Thank you!
OUTER_DIA_MM    = 10;
INNER_DIA_MM    = 5;

LENGTH_MM       = 40;
WIDTH_MM        = 35;  // For up to 4-letter tags. For wider, try 50mm.
BODY_HEIGHT_MM  = 1.2; // Should be a multiple of your layer height
TEXT_HEIGHT_MM  = 0.8; // Should be a multiple of your layer height

TEXT            = "PLA";

$eps            = 0.0001;
$fn             = 50;

module ocyl() {
    cylinder(h = BODY_HEIGHT_MM, d = OUTER_DIA_MM);
}

module create_body() {
    hull() {
        translate([OUTER_DIA_MM/2,          OUTER_DIA_MM/2,             0]) { ocyl(); }
        translate([OUTER_DIA_MM/2,          LENGTH_MM-OUTER_DIA_MM/2,   0]) { ocyl(); }
        translate([WIDTH_MM-OUTER_DIA_MM/2, OUTER_DIA_MM/2,             0]) { ocyl(); }
        translate([WIDTH_MM-OUTER_DIA_MM/2, LENGTH_MM-OUTER_DIA_MM/2,   0]) { ocyl(); }
    }
}

module create_hole() {
    translate([0, 0, -.5*BODY_HEIGHT_MM]) {
        hull() {
            translate([OUTER_DIA_MM/2, OUTER_DIA_MM/2, 0]) { 
                cylinder( h = BODY_HEIGHT_MM*2, d = INNER_DIA_MM ); 
            }
            translate([WIDTH_MM-OUTER_DIA_MM/2, OUTER_DIA_MM/2,0]) {
                cylinder( h = BODY_HEIGHT_MM*2, d = INNER_DIA_MM ) ; 
            }
        }
    }
}


module create_filament_tag() {
    difference() {
        create_body();
        union() {
            create_hole();   
            translate([0, LENGTH_MM-OUTER_DIA_MM, 0]) { 
                create_hole(); 
            }
        }
    }

    translate([WIDTH_MM/2, LENGTH_MM/2, BODY_HEIGHT_MM-$eps]) {
        linear_extrude(TEXT_HEIGHT_MM) {
            // I find bold is more readable from a distance
            text(TEXT, size=8, halign="center", valign="center", font="Arial:style=Bold");
        }
    }
}

create_filament_tag();