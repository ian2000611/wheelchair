
function horny() = 81;
function hornx() = 89;
function hornz() = 80;


module horn2(d=3) {
    dia=6;
    hornoutletx=58;
    hornoutlety = d;
    hornoutletz = 48;

    hornzinset = d;

    translate([0,d,hornx()+d]) 
    rotate([0,90,0]) 
    union() {
        translate([0,0,hornzinset]) cube([hornx(),horny()-hornoutlety,hornz()+hornzinset]);
        
        translate([hornx()-hornoutletx,horny()-hornoutlety-0.01,hornz()-hornoutletz]) cube([hornoutletx,hornoutlety+0.02,hornoutletz]);
        
        translate([horny()/2,horny()/2,-0.01]) cylinder(d=dia,h=(hornz()+hornzinset())/2,h=hornz());
    }
}
difference() {
    wall=1.5;
    cube([hornz()+3*wall,horny()+wall,hornx()+wall-0.01]);
    horn2(wall);
}