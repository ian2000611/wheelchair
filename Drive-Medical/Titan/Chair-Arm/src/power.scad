squarewidth=25.4*(1+1/32);
rounddia=25.4*(1+5/32);
height=65;
discdia=25.4*(1+31/64);
discheight=5.25;
discthickness=25.4*(1/4);
flaphingewidth=25.4*(1/2);
nutdia=25.4*(1+5/8);
protect=9;
pad=.4;
hpad=.2;

module power(solid=false,r=4,sliceat=17,support=false) {
    mirror([0,0,1]) 
    if (!solid) {
        rotate(180) {
            translate([0,0,discheight]) cylinder(d=discdia,h=hpad);
            translate([0,0,discheight+discthickness]) cylinder(d=nutdia,h=hpad);
            //translate([0,0,height]) cylinder(d=nutdia,h=hpad);
            difference() {
                union() {
                        translate([0,discdia/2+discheight/4,discheight/4]) cube([flaphingewidth,discheight/2,discheight/2],true); 
                    translate([0,0,discheight/2])rotate([0,90,0]) hull() { 
                        translate([0,discdia/2,0]) cylinder(d=discheight,h=flaphingewidth,center=true); 
                        
                        cylinder(d=discheight,h=flaphingewidth,center=true);}
                    cylinder(d=discdia,h=discheight);
                    intersection() {
                        cylinder(d=rounddia,h=height);
                        translate([-squarewidth/2,-(rounddia+1)/2,0]) cube([squarewidth,rounddia+1,height]);
                    }
                    translate([0,0,discheight+discthickness]) cylinder(d=nutdia,h=height-discheight-discthickness);
                }
                if (support) {
                    difference() {
                        translate([0,0,-pad/2]) intersection() {
                            cylinder(d=rounddia+2*pad,h=height+pad);
                            translate([-squarewidth/2-pad,-(rounddia+1)/2-pad,0]) cube([squarewidth+2*pad,rounddia+1+2*pad,height+pad]);
                        }
                        translate([0,0,-pad]) intersection() {
                            cylinder(d=rounddia,h=height+2*pad);
                            translate([-squarewidth/2,-(rounddia+1)/2,0]) cube([squarewidth,rounddia+1,height+2*pad]);
                        }
                    }
                }
            }
        }
    } else {
        translate([0,0,r+0.001]) cylinder(d1=nutdia+protect*2-r,d2=nutdia+protect*1-r,h=height+2.999-2*r);
       
    }
}
function powerr(r) = nutdia+protect*2-r;
function powerh(r) = height+2.999-2*r;
difference() { 
    power(true); 
    !power(false);
}