$fn=100;
r=1.6;

module base() {
    difference() {
    linear_extrude(2.5) {
        difference() {
            circle(60);
            // Front Klappe
            translate([-40,0,0]) square(50, center=true);
            //translate([-11,0,0]) square([8,17], center=true);
            // Radschlitze
            translate([-25,45,0]) square([50,7]);
            translate([-25,-52,0]) square([50,7]);
            translate([-14.5,34.5,0]) circle(r);
            translate([-14.5,-34.5,0]) circle(r);
            translate([14.5,34.5,0]) circle(r);
            translate([14.5,-34.5,0]) circle(r);
            // Klippensensor
            translate([-38.42,36.42,0]) square(8, center=true);
            translate([-38.42,-36.42,0]) square(8, center=true);
            // Maussensor
            translate([23,0,0]) square([46,16], center=true);
            //translate([8,-15,0]) square([18,30]);
            //translate([29,0,0]) square([6,16], center=true);
            translate([32,-18,0]) square([14,10]);
            translate([5,12,0]) circle(r);
            translate([5,-12,0]) circle(r);
            translate([29,12,0]) circle(r);
            translate([29,-12,0]) circle(r);
            // Bohrungen
            translate([-48.48,28.72,0]) circle(r);
            translate([-48.48,-28.72,0]) circle(r);
            translate([0,56,0]) circle(r);
            translate([0,-56,0]) circle(r);
            translate([54,0,0]) circle(r);
            translate([-29.55,32,0]) circle(r);
            translate([-29.55,-32,0]) circle(r);
            translate([38,-38,0]) circle(r);
        }
    }
    translate([54,0,0]) cylinder(r=10,h=1);
    }
}

module top() {
    linear_extrude(2.5) {
        difference() {
            circle(60);
            // Front Klappe
            translate([-40,0,0]) square(50, center=true);
            // Servo
            translate([5,0,0]) square([22,12.5], center=true);
            translate([-9,0,0]) circle(r);
            translate([19,0,0]) circle(r);
            // Kabel Schlitze
            translate([-35,-45,0]) square([5,12], center=true);
            translate([-35,45,0]) square([5,12], center=true);
            translate([55,0,0]) square([10,5], center=true);
            // LCD Bohrungen
            translate([27.5,46.6,0]) circle(r);
            translate([27.5,-46.6,0]) circle(r);
            translate([-27.5,46.6,0]) circle(r);
            translate([-27.5,-46.6,0]) circle(r);
            // Bohrungen
            translate([-48.48,28.72,0]) circle(r);
            translate([-48.48,-28.72,0]) circle(r);
            translate([0,56,0]) circle(r);
            translate([0,-56,0]) circle(r);
            //translate([54,0,0]) circle(r);
            translate([-29.55,32,0]) circle(r);
            translate([-29.55,-32,0]) circle(r);
            translate([38,-38,0]) circle(r);
        }
    }
}

module connector() {
    difference() {
        cube([8,8,60], center=true);
        translate([0,0,-30]) cylinder(r=1,h=10);
        translate([0,0,20]) cylinder(r=1,h=10);
        translate([-5,0,23.5]) rotate([0,90,0]) cylinder(r=2,h=10);
        translate([-5,0,-13.5]) rotate([0,90,0]) cylinder(r=2,h=10);
        translate([0,5,-20]) rotate([90,0,0]) cylinder(r=2,h=10);
    }
}

module wheel() {
    difference() {
        union() {
            cylinder(r1=25,r2=23,h=2.5);
            translate([0,0,2.5]) cylinder(r1=23,r2=25,h=2.5);
            translate([0,0,5]) cylinder(r=5,h=5);
            for(i=[0:30]) {
                rotate([0,0,i*360/30]) {
                    translate([0,23,5.25]) cube([2.5,4,0.5], center=true);
//                    translate([0,21,5.25]) prism(2.5,4,0.5);

                }
            }
        }
        for(i=[0:6]) {
            rotate([0,0,i*360/6]) {
                translate([0,15,0]) cylinder(d=12,h=5);
            }
        }
        cylinder(r=1.5,h=10);
    }
}

module motormount() {
    difference() {
        cube([36,28,2], center=true);
        translate([0,0,-1]) cylinder(d=12, h=2);
        for(i=[0:3]) {
            rotate([0,0,i*360/3]) {
                translate([0,-8.5,-1]) cylinder(d=2,h=2);
            }
        }
    }
    translate([0,15,6.5])
    difference() {
        cube([36,2,15], center=true);
        translate([-14.5,2,0]) rotate([90,0,0]) cylinder(d=3.2, h=4);
        translate([14.5,2,0]) rotate([90,0,0]) cylinder(d=3.2, h=4);
    }
}

module support() {
    difference() {
        union() {
            cylinder(r=5,h=5);
            translate([0,0,5]) sphere(r=5);
        }
        cylinder(r=1,h=5);
    }
}

module pneu() {
    rotate_extrude(convexity = 10, $fn = 100)
    translate([25, 0, 0]) circle(r = 2.5, $fn = 100);

}

module ctbot() {
    color("silver") translate([0,0,0]) base();
    color("green") translate([0,0,62]) top();
    color("silver") translate([-29.55,32,32]) connector();
    color("silver") translate([-29.55,-32,32]) connector();
    color("silver") translate([38,-38,32]) connector();
    color("white") translate([0,51,19]) rotate([90,0,0]) wheel();
    color("white") translate([0,-51,19]) rotate([-90,0,0]) wheel();
    color("black") translate([0,48.5,19]) rotate([90,0,0]) pneu();
    color("black") translate([0,-48.5,19]) rotate([-90,0,0]) pneu();
    color("silver") translate([0,41,19]) rotate([-90,0,180]) motormount();
    color("silver") translate([0,-41,19]) rotate([-90,0,0]) motormount();
    color("white") translate([54,0,0]) rotate([180,0,0]) support(); 
}

ctbot();
base();
!top();
motormount();
connector();
wheel();
support();
pneu();