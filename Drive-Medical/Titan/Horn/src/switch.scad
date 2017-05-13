function switchx() = 9/8*25.4;
function switchy() = 5/8*25.4;
function switchwall() = 3;
module switch(d=3,s=1) {
    x=switchx();
    y=switchy();
    z=3/4*25.4;
    w=switchwall();
    r=1/2*25.4/2+.4;
    if (s==1) {
        translate([0,0,(z+d)/2]) cube([x+2*w,y+2*w,z+d],true);
    } else {
        translate([0,0,z/2+d]) cube([x,y,z+0.01],true);
        translate([0,0,-0.005]) cylinder(r=r,h=d+0.01);
    }
}
module test() {
    difference() {
        union() {
            translate([0,0,1.5]) cube([switchx()+2*switchwall()+10,switchy()+2*switchwall()+10,3],true);
            switch(d=3,s=1);
        }
        switch(d=3,s=0);
    }
}

module barmount(d=1.6*25.4) {
    zipt=4;
    zipw=8;
    w=2;
    sz=(d+4*w+2*zipt)/2;
    y=switchx()+2*switchwall();
    translate([0,0,(d+4*w+2*zipt)/2+.5]) rotate([-90,0,0]) intersection() {
        //difference() {
        //    translate([0,0,100]) cube(200,true);
            rotate([-60,0,0]) translate([0,0,90]) cube(200,true);
        //}
        difference() {
            union() {
                translate([0,sz,(d+4*w+2.5*zipt+switchy())/2]) rotate([90,0,0]) switch(d=3,s=1);
                hull() {
                    translate([0,sz/2,(d+4*w+2.5*zipt)/2]) cube([y,sz,0.01],true);
                    rotate([0,90,0]) cylinder(d=d+4*w+2*zipt,h=y,center=true);
                }
            }
            rotate([0,90,0]) cylinder(d=d,h=y+0.01,center=true);
            for (m=[0,1]) mirror([m,0,0]) translate([zipw/2-y/2+w,0,0]) rotate([0,90,0]) difference() {
                cylinder(d=d+2*w+2*zipt,h=zipw,center=true);
                cylinder(d=d+2*w,h=zipw+0.01,center=true);
            }
                translate([0,sz,(d+4*w+2.5*zipt+switchy())/2]) rotate([90,0,0]) switch(d=3,s=0);
        }
    }
}
barmount();