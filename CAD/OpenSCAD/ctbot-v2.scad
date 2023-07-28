version = "v2"; // [v1: Version 1, v2: Version 2]
show_part = "all"; // [all: All Parts, top: Top Plate, base: Base Plate, connector: Connector, sensor_mount: Sensor Mount, wheel: Wheel, motor_mount: Motor Mount, support: Support Wheel, pneu: Pneu]
side_servo = false;
side_sensor = true;
/* [Hidden] */
$fn=100;
rm3=1.6;
rm25=1.4;

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
            translate([27.5,46.6,0]) circle(rm3);
            translate([27.5,-46.6,0]) circle(rm3);
            translate([-27.5,46.6,0]) circle(rm3);
            translate([-27.5,-46.6,0]) circle(rm3);
            // Bohrungen
            translate([-48.48,28.72,0]) circle(rm3);
            translate([-48.48,-28.72,0]) circle(rm3);
            translate([0,56,0]) circle(rm3);
            translate([0,-56,0]) circle(rm3);
            //translate([54,0,0]) circle(rm3);
            translate([-29.55,32,0]) circle(rm3);
            translate([-29.55,-32,0]) circle(rm3);
            translate([38,-38,0]) circle(rm3);
        }
    }
}

module crickit_cutout() {
    translate([37.5,16,0]) circle(rm3);
    translate([37.5,-16,0]) circle(rm3);
    translate([-37.5,16,0]) circle(rm3);
    translate([-37.5,-16,0]) circle(rm3);
}

module crickit_standoff() {
    translate(([37.5,16,0])) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
    translate(([37.5,-16,0])) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
    translate(([-37.5,16,0])) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
    translate(([-37.5,-16,0])) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
}

module base_v2() {
    difference() {
    linear_extrude(2.5) {
        difference() {
            circle(60);
            circle(6);
            // Radschlitze
            translate([0,52,0]) square([50,20], center = true);
            translate([0,-52,0]) square([50,20], center = true);
            // Crickit Bohrungen
            crickit_cutout();
            // Motor Mount Bohrungen
            translate([-14.5,34.5,0]) circle(rm3);
            translate([-14.5,-34.5,0]) circle(rm3);
            translate([14.5,34.5,0]) circle(rm3);
            translate([14.5,-34.5,0]) circle(rm3);
            // 6x Liniensensor      
            translate([-42,25.6,0]) circle(rm3);
            translate([-42,-25.6,0]) circle(rm3);
            //translate([-40,20, 0]) square([5,7], center = true);
            translate([-43,0, 0]) square([6,45], center = true);

            // Bohrungen
            translate([-48.48,28.72,0]) circle(rm3);
            translate([-48.48,-28.72,0]) circle(rm3);
            translate([0,56,0]) circle(rm3);
            translate([0,-56,0]) circle(rm3);
            translate([54,0,0]) circle(rm3);
            
            //translate([-29.55,32,0]) circle(rm3);
            //translate([-29.55,-32,0]) circle(rm3);
            //translate([38,-38,0]) circle(rm3);
        }
    }
    }
}

module top_v2() {
    linear_extrude(2.5) {
        difference() {
            circle(60);
            square([42,42], center=true);
            // Kabel Schlitze
            //translate([-35,-45,0]) square([5,12], center=true);
            //translate([-35,45,0]) square([5,12], center=true);
            //translate([55,0,0]) square([10,5], center=true);
            // Crickit Bohrungen
            crickit_cutout();
            //translate([16,37.5,0]) circle(rm3);
            //translate([-16,37.5,0]) circle(rm3);
            //translate([16,-37.5,0]) circle(rm3);
            //translate([-16,-37.5,0]) circle(rm3);
            // Crickit Kabel Bohrungen
            translate([44,0,0]) square([5,20], center=true);
            translate([-44,0,0]) square([5,20], center=true);
            translate([0,44,0]) square([20,5], center=true);
            translate([0,-44,0]) square([20,5], center=true);
            translate([32,32,0]) rotate([0,0,45]) square([5,20], center=true);
            translate([32,-32,0]) rotate([0,0,-45]) square([5,20], center=true);
            translate([-32,32,0]) rotate([0,0,-45]) square([5,20], center=true);
            translate([-32,-32,0]) rotate([0,0,-45]) square([20,5], center=true);
            // Motor Mount Bohrungen
            translate([-14.5,34.5,0]) circle(rm3);
            translate([-14.5,-34.5,0]) circle(rm3);
            translate([14.5,34.5,0]) circle(rm3);
            translate([14.5,-34.5,0]) circle(rm3);
            // LCD Bohrungen
            translate([27.5,46.6,0]) circle(rm3);
            translate([27.5,-46.6,0]) circle(rm3);
            translate([-27.5,46.6,0]) circle(rm3);
            translate([-27.5,-46.6,0]) circle(rm3);
            // Neopixel Ring Bohrungen
            translate([0,48.5,0]) circle(rm3);
            translate([0,-48.5,0]) circle(rm3);
            translate([48.5,0,0]) circle(rm3);
            translate([-48.5,0,0]) circle(rm3);

            // Bohrungen
            translate([-48.48,28.72,0]) circle(rm3);
            translate([-48.48,-28.72,0]) circle(rm3);
            translate([0,56,0]) circle(rm3);
            translate([0,-56,0]) circle(rm3);
            //translate([54,0,0]) circle(rm3);
            //translate([-29.55,32,0]) circle(rm3);
            //translate([-29.55,-32,0]) circle(rm3);
            //translate([38,-38,0]) circle(rm3);
        }
    }
    crickit_standoff();
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

module m25_nutmount() {
    difference() {
         cylinder(d=10, h=2);
         cylinder(d=5.8, h=2, $fn=8);
    }
}

module motormount_connector() {
    difference() {
        cube([44,13,3], center=true);
        translate([-14.5,1,0]) cylinder(r=rm3, h=4, center=true);
        translate([14.5,1,0]) cylinder(r=rm3, h=4, center=true);
    }
    translate([-22,6.5,0]) rotate([45,0,0]) cube([44,2,2]);
    translate([-14.5,1,1.5]) m25_nutmount();
    translate([14.5,1,1.5]) m25_nutmount();
}

module motor_cutout() {
    cylinder(d=12, h=4, center=true);
    for(i=[0:3]) {
        rotate([0,0,i*360/3]) {
            translate([0,-8.5,0]) cylinder(r=rm25,h=4, center=true);
        }
    }
}

module wheelsensor_cutout() {
    translate([17,0,0]) cylinder(r=rm25, h=4, center=true);
    translate([-17,0,0]) cylinder(r=rm25, h=4, center=true);
}

module side_servo_cutout() {
    // servo cutout
        translate([0,0,0]) cube([22.5,13,4], center=true);
        translate([11.5,0,0]) cylinder(r=rm25,h=4, center=true);
        translate([-11.5,0,0]) cylinder(r=rm25,h=4, center=true);
}

module side_sensor_cutout() {
    // sensor cutout
    translate([0,0,0]) cube([14,7,4], center=true);
    translate([9.5,0,0]) cylinder(r=rm3, h=4, center=true);
    translate([-9.5,0,0]) cylinder(r=rm3, h=4, center=true);
}

module motormount_v2(left = true) {
    difference() {
        translate([0,-14,0]) cube([44,60,3], center=true);
        motor_cutout();
        wheelsensor_cutout();

        if (side_servo == true) {
            translate([0,-32,0]) side_servo_cutout();
        }
        else if (side_sensor == true) {
            translate([0,-32,0]) side_sensor_cutout();
        }
    }
    difference() {
        translate([0,14.5,7.5]) rotate([-90,0,180]) motormount_connector();
        translate([0,0,0]) cylinder(d=26, h=4);
    }
    translate([0,-42.5,7.5]) rotate([-90,0,0]) motormount_connector();
}

module ultrasonic_cutout() { 
    // ultrasonic sensor
    translate([13,0,0]) cylinder(d=17, h=4, center=true);
    translate([-13,0,0]) cylinder(d=17, h=4, center=true);
    translate([20.5,-11,0]) cylinder(r=rm3, h=4, center=true);
    translate([-20.5,-11,0]) cylinder(r=rm3, h=4, center=true);
}

module ultrasonic_standoff() {
    //standoffs ultrasonic sensor
    translate([0,6,0]) cylinder(h=6, r=3);
    
    translate([20.5,-11,0]) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
    translate([-20.5,-11,0]) difference() {
        cylinder(h=6, r=3);
        cylinder(r=rm3, h=10);
    }
}

module thermogrid_cutout() { 
    // thermo grid
    translate([0,0,0]) cube([10,6,4], center=true);
    translate([10.5,10,0]) cylinder(r=rm3, h=4,center=true);
    translate([-10.5,10,0]) cylinder(r=rm3, h=4, center=true);
}

module thermogrid_standoff() {
    //standoffs thermo grid
    translate([10.5,10,0]) difference() {
        cylinder(h=3.3, r=3);
        cylinder(r=rm3, h=4);
    };
    translate([-10.5,10,0]) difference() {
        cylinder(h=3.3, r=3);
        cylinder(r=rm3, h=4);
    };
}

module sensor_mount_connector() {
    cube([54,8,3], center=true);
    translate([28.72,0,0])  difference() {
        cylinder(d=10, h=3, center=true);
        cylinder(r=rm3, h=3, center=true);
    }
    translate([28.72,0,1.5]) m25_nutmount();
    translate([-28.72,0,0])  difference() {
        cylinder(d=10, h=3, center=true);
        cylinder(r=rm3, h=3, center=true);
    }
    translate([-28.72,0,1.5]) m25_nutmount();
}

module mouth() {
}

module sensor_mount() {
    difference() {
        cube([52,60,2.5], center=true);
        translate([0,15,0]) ultrasonic_cutout(); 
        translate([0,-12,0]) rotate([0,0,-90]) thermogrid_cutout();
    }
    translate([0,-28.5,-4]) rotate([-90,0,0]) sensor_mount_connector();
    translate([0,28.5,-4]) rotate([90,0,0]) sensor_mount_connector();
    translate([0,15,-7.25]) ultrasonic_standoff();
    translate([0,-12,-4.25]) rotate([0,0,-90])thermogrid_standoff();
   
}


module support(siz=5) {
    difference() {
        union() {
            cylinder(r=siz,h=siz);
            translate([0,0,siz]) sphere(r=siz);
        }
        cylinder(r=1,h=siz);
    }
}

module pneu() {
    rotate_extrude(convexity = 10, $fn = 100)
    translate([25, 0, 0]) circle(r = 2.5, $fn = 100);

}

module line_sensor() {
    difference() {
        cube([13,56,2], center= true);
        translate([3.5,25.6,-2]) cylinder(r=rm3, h=4);
        translate([3.5,-25.6,-2]) cylinder(r=rm3, h=4);
    }    
}
        

module ctbot() {
    color("silver") translate([0,0,0]) base();
    color("green") translate([0,0,63]) top();
    color("silver") translate([-29.55,32,33]) connector();
    color("silver") translate([-29.55,-32,33]) connector();
    color("silver") translate([38,-38,33]) connector();
    color("white") translate([0,51,19]) rotate([90,0,0]) wheel();
    color("white") translate([0,-51,19]) rotate([-90,0,0]) wheel();
    color("black") translate([0,48.5,19]) rotate([90,0,0]) pneu();
    color("black") translate([0,-48.5,19]) rotate([-90,0,0]) pneu();
    color("silver") translate([0,41,19]) rotate([-90,0,180]) motormount();
    color("silver") translate([0,-41,19]) rotate([-90,0,0]) motormount();
    color("white") translate([54,0,0]) rotate([180,0,0]) support(); 
}

module ctbot_v2() {
    color("silver") translate([0,0,0]) base_v2();
    color("silver") translate([0,0,63]) top_v2();
    //color("silver") translate([-29.55,32,32]) connector();
    //color("silver") translate([-29.55,-32,32]) connector();
    //color("silver") translate([38,-38,32]) connector();
    color("red") translate([-45,0,-4]) line_sensor();
    color("white") translate([0,51,19]) rotate([90,0,0]) wheel();
    color("white") translate([0,-51,19]) rotate([-90,0,0]) wheel();
    color("black") translate([0,48.5,19]) rotate([90,0,0]) pneu();
    color("black") translate([0,-48.5,19]) rotate([-90,0,0]) pneu();
    color("silver") translate([0,41,19]) rotate([-90,0,180]) motormount_v2();
    color("silver") translate([0,-41,19]) rotate([-90,0,0]) motormount_v2(left=false);
    color("white") translate([54,0,0]) rotate([180,0,0]) support(4.5); 
    color("white") translate([-53,0,33]) rotate([90,0,-90]) sensor_mount();

}

if (show_part == "all") {
    if (version == "v1") {
        ctbot();
    }
    else if (version == "v2") {
        ctbot_v2();
    }
}
else if (show_part == "base") {
    if (version == "v1") {
        base();
    }
    else if (version == "v2") {
        base_v2();
    }
}
else if (show_part == "top") {
    if (version == "v1") {
        top();
    }
    else if (version == "v2") {
        top_v2();
    }
}
else if (show_part == "motor_mount") {
    if (version == "v1") {
        motormount();
    }
    else if (version == "v2") {
        motormount_v2();
    }
}
else if (show_part == "sensor_mount") {
    sensor_mount();
}
else if (show_part == "connector") {
    connector();
}
else if (show_part == "wheel") {
    wheel();
}
else if (show_part == "support") {
    if (version == "v1") {
        support();
    }
    else if (version == "v2") {
        support(4.5);
    }
}
else if (show_part == "pneu") {
    pneu();
}