use <fuse.scad>;
use <relay.scad>;
use <switch.scad>;

sizex=fusey()+fusewall()*2+relayx()+relaywall()*2+switchy()+switchwall()*2;
sizey=relayy()+relaywall()*2;

difference() {
    union() {
        translate([-10,-10-sizey/2]) cube([20+sizex,sizey+20,3]);
        union() {
            hull() {                    
                translate([fusey()/2+fusewall(),0,0]) rotate(90) fuse(d=3,s=1);
                translate([fusey()+fusewall()*2+relayx()/2+relaywall(),0,0]) relay(d=3,s=1);
                translate([fusey()+fusewall()*2+relayx()+relaywall()*2+switchwall()+switchy()/2,0,0]) rotate(90) switch(d=3,s=1);
            }                    
                translate([fusey()/2+fusewall(),0,0]) rotate(90) fuse(d=3,s=2);
                translate([fusey()+fusewall()*2+relayx()/2+relaywall(),0,0]) relay(d=3,s=2);
        }
    }                    
    translate([fusey()/2+fusewall(),0,0]) rotate(90) fuse(d=3,s=0);
    translate([fusey()+fusewall()*2+relayx()/2+relaywall(),0,0]) relay(d=3,s=0);
    translate([fusey()+fusewall()*2+relayx()+relaywall()*2+switchwall()+switchy()/2,0,0]) rotate(90) switch(d=3,s=0);
}