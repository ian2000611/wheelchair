gap=0.3;
function fusex() = 13/16*25.4;
function fusey() = 11/32*25.4;
function fusewall() = 3;
module fuse(d=3,s=1,e=0,er=0) {
    x=fusex();
    y=fusey();
    z=3/4*25.4;
    tx=1/8*25.4;
    tz=1;
    ty=1/8*25.4;
    tsz=2*ty;
    th=(11/32)*25.4-2;
    r=3/64*25.4;
    w=fusewall();
    $fn=32;
    translate([-x/2,-y/2,z+d])
    mirror([0,0,1])
    if (s==2) {
        translate([x/2-tx/2,y+w,th]) translate([0,1.2,tsz+tz+.25]) cube([tx,ty-1.2,z-th-tsz-tz-0.5]);
        translate([x/2-tx/2,y+w,th]) hull() {
            translate([0,0,tsz]) cube([tx,ty,tz]);
            cube([tx,0.1,.1]);
        }
    } else if (s==1) {
        linear_extrude(z+d) offset(r=w) square([x,y]);
    } else {
        translate([0,0,-0.5]) linear_extrude(z+d+1) offset(r=r) offset(r=-r) square([x,y]);
        if (e>0) {
            difference() {
                translate([0,0,e-d-0.005]) linear_extrude(e+d+0.56) offset(r=er) square([x,y]);
                if (er>=1) {
                    difference() {
                        translate([0,0,0.25+e-d-0.005]) linear_extrude(e+d+0.56-.25) offset(r=.3) square([x,y]);
                        translate([0,0,e-d-0.005]) linear_extrude(e+d+0.56+.25) offset(r=r-.7) offset(r=-r) square([x,y]);
                    }
                }
            }
        }
    }
}

module test() {
    difference() {
        union() {
            translate([0,0,-14+3]) cube([fusex()+fusewall()+10,fusey()+fusewall()+10,25+3],true);
            fuse(3,1);
            fuse(3,2);
        }
        fuse(3,0,25,3);
    }
}
test();