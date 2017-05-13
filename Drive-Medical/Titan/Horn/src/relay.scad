function relayx() = 9/8*25.4;
function relayy() = 9/8*25.4;
function relaywall() = 5;
module relay(d=3,s=1,e=0,er=0) {
    x=relayx();
    y=relayy();
    z=3/4*25.4;
    tx=1/8*25.4;
    tz=2;
    ty=4;
    tsz=4.5;
    th=0;
    r=3/64*25.4;
    w=relaywall();
    $fn=32;
    translate([-x/2,-y/2,z+d])
    mirror([0,0,1])
    if (s==2) {
        translate([x/2-tx/2,y+w,th]) translate([0,1.2,tz+tsz+.25]) cube([tx,ty-1.2,z-d*1.5-tz-0.5]);
        translate([x/2-tx/2,y+w,th]) hull() {
            translate([0,0,tsz]) cube([tx,ty,tz]);
            cube([tx,0.1,.1]);
        }
    } else if (s==1) {
        linear_extrude(z+d) offset(r=w) square([x,y]);
    } else {
        translate([0,0,-0.005]) linear_extrude(z+d+0.01) offset(r=r) offset(r=-r) square([x,y]);
        if (e>0) {
            difference() {
                translate([0,0,e-d-0.005]) linear_extrude(e+d) offset(r=er) square([x,y]);
                if (er>=1) {
                    difference() {
                        translate([0,0,.25+e-d-0.005]) linear_extrude(e+d-.25) offset(r=0.3) square([x,y]);
                        translate([0,0,e-d-0.005]) linear_extrude(e+d+.25) offset(r=r+.7) offset(r=-r) square([x,y]);
                    }
                }
            }
        }
    }
}

module test () {
    translate([0,-y/2-w-1]) difference() {
        union() {
            translate([0,0,-14+1.5]) cube([relayx()+2*relaywall()+10,relayy()+2*relaywall()+10,28],true);
            relay(d=3,s=1);
            relay(d=3,s=2);
        }
        relay(d=3,s=0,e=25,er=1);
    }
}
test();