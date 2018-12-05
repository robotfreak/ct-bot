$fn=100;
r=1.6;

module base() {
    linear_extrude(2) {
        difference() {
            circle(60);
            // Front Klappe
            translate([-40,0,0]) square(50, center=true);
            translate([-11,0,0]) square([8,17], center=true);
            // Radschlitze
            translate([-25,45,0]) square([50,7]);
            translate([-25,-52,0]) square([50,7]);
            translate([-14.5,34.5,0]) circle(r);
            translate([-14.5,-34.5,0]) circle(r);
            translate([14.5,34.5,0]) circle(r);
            translate([14.5,-34.5,0]) circle(r);
            // Klippensensor
            translate([-38.42,30.42,0]) square(8, center=true);
            translate([-38.42,-30.42,0]) square(8, center=true);
            // Maussensor
            translate([5,0,0]) square([6,16], center=true);
            translate([8,-18.9,0]) square([18,33.9]);
            translate([29,0,0]) square([6,16], center=true);
            translate([32,-21.4,0]) square([18,40.07]);
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
}

module top() {
    linear_extrude(2) {
        difference() {
            circle(60);
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
        
module ctbot() {
    translate([0,0,0]) base();
    translate([0,0,62]) top();
    translate([-29.55,32,32]) connector();
    translate([-29.55,-32,32]) connector();
    translate([38,-38,32]) connector();
    translate([0,51,19]) rotate([90,0,0]) wheel();
    translate([0,-51,19]) rotate([-90,0,0]) wheel();
    translate([0,41,19]) rotate([-90,0,180]) motormount();
    translate([0,-41,19]) rotate([-90,0,0]) motormount();
}

!ctbot();
base();
top();
motormount();
connector();
wheel();