use <fuse.scad>;
use <relay.scad>;

cubex=20+fusey()+6+relayx()+8;
cubey=relayy()+8+20;
cubez=28;
zipw=10;
zipt=6;
blockface=25;
difference() {
    union() {
        translate([0,0,-cubez/2+3]) cube([cubex,cubey,cubez],true);
        translate([cubex/2-zipt/2-3-1.5,0,-cubez/2+3+3/4*25.4/2]) cube([zipt+6+3,cubey,cubez+3/4*25.4],true);
        translate([(-fusey()-6+relayx()+8)/-2-1,0]) union() {
            hull() {                    
                translate([-fusey()/2-3,0,0]) rotate(90) fuse(d=3,s=1);
                translate([relayx()/2+4,0,0]) relay(d=3,s=1);
            }
            translate([-fusey()/2-3,0,0]) rotate(90) fuse(d=3,s=2);
            translate([relayx()/2+4,0,0]) relay(d=3,s=2);
        }
    }
    translate([(-fusey()-6+relayx()+8)/-2-1,0]) union() {
        translate([-fusey()/2-3,0,0]) rotate(90) fuse(d=3,s=0,s=0,e=25,er=6);
        translate([relayx()/2+4,0,0]) relay(d=3,s=0,e=25,er=0);
    }
    #for (i=[-1,1]) translate([cubex/2-zipt/2-3,i*(cubey/2-zipw/2-5),-cubez/2+3+3/4*25.4/2]) cube([zipt,zipw,cubez+3/4*25.4+.002],true);
}