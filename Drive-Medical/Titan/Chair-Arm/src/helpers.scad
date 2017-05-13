module sliceat(total,slice,top=true,x=205,y=205) {
    remain=total-slice;
    translate([0,0,top?remain:slice]) 
    rotate([180,0,0]) 
    render() intersection() { 
        translate([-x/2,-y/2,0]) 
        cube([x,y,top?remain:slice]);
        
        rotate([(top?0:180),0,0]) 
        translate([0,0,-slice]) 
        children();
    }
}

module partarc(r,w,h) {
    
    D=(pow(r,2)+pow(w/2,2))/r;
    translate([0,-D/2+r,h/2])
    difference() {
        cylinder(d=D,h=h,center=true);
        translate([0,-r,0]) cube([D+1,D,h+7],true);
    }
}

module midslice(bottom,h,x=5000,y=5000,center=true) {
    intersection() {
        translate([-2500,-2500,0]) cube([5000,5000,h]);
        translate([0,0,-bottom]) children();
    }
}