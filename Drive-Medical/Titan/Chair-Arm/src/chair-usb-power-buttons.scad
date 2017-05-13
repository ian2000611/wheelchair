slop=.3;
gap=.4;
wall=2;
roundover=2;
screwwall=wall*2+dsinkfree(screw(inch(num(6))));//wall that contains a screw

use<./keystone.scad>;
use<./power.scad>;
use<./screw.scad>;
use<./helpers.scad>;
use<./supported_cylinder.scad>;
use<./radioshack.scad>;

//Mount specific below this point
platethickness=4;

armwidth=85;
armfrontr=armwidth/4;
armfrontrl=armfrontr/2;
armheight=35;

mountscrewdia=6.3;
mountscrewfromfront=20;
mountscrewfrombottom=4.4;
mountscrewspacing=40;
frontfrommount=78-armfrontrl;

mountdepth=mountscrewfromfront+mountscrewspacing+2*mountscrewdia+slop+wall*4;
mountwidth=24.5;
mountheight=19;

mountextraheight=40;


wiredia=9;
wirez=17;

sliceat=wirez+slop+wall;



mountoffsetsx=[(mountwidth/2+wiredia/2)*5/12,-(mountwidth/2+wiredia/2)*5/12];
mountoffsetsy=[mountdepth/3,-mountdepth/3-12];

height = mountextraheight+platethickness+armheight;

poweroffsetsx=[
    (mountwidth*0.9),
    -(mountwidth*0.9)
    ];
poweroffsetsy=[
    powerh(roundover)/2+3,
    0
    ];

sliceat=wirez+wall+slop;



module chairmount(ethernet=true,screws=true) {
    render() translate([0,-frontfrommount/2+mountdepth/2,0]) difference() {
        minkowski() {
            union() {
    //translate([0,0,mountextraheight])
        translate([0,-mountdepth/2+slop/2,(mountheight+mountextraheight)/2]) cube([mountwidth-2*roundover,mountdepth+slop-2*roundover,mountheight+mountextraheight-2*roundover],true);
            
        translate([-mountwidth/2+roundover,-slop-roundover,roundover]) cube([mountwidth-2*roundover,frontfrommount+2*slop+2*roundover,mountextraheight-2*roundover]);
            }
            sphere(r=roundover);
        }
    for (y=[mountscrewfromfront,mountscrewfromfront+mountscrewspacing]) translate([0,-y,mountscrewfrombottom+mountscrewdia/2+mountextraheight]) rotate([0,90,0]) cylinder(d=mountscrewdia+2*slop,h=mountwidth+2*slop,center=true);
        translate([0,slop*3/2+frontfrommount+8*slop+4,wirez+wall+slop]) rotate([90,0,0]) cylinder(d=wiredia,h=mountdepth+2*slop+frontfrommount+8*slop+4);
        if (ethernet) translate([0,-mountdepth,wirez+wall+slop]) keystone(true);
        
        if (screws) for(x=mountoffsetsx) for (y=mountoffsetsy) translate([x,y,sliceat]) screw();
    }
}

module powerholder(screws=true) {
    h=height;//inch(3);
sbx=32;
        sby=30;
        sbz=h-(25.4/4+5.25)-sliceat+wiredia/2;
        
    ff=powerh(roundover)/2+armfrontrl-armfrontrl-inch(1+15/32)-9;
    render() translate([0,0,0]) difference(){ 
        minkowski() {
            hull() {
                translate([0,ff,h]) power(true,roundover);
                for(i=[1,-1]) translate([i*16,-ff+2,h-roundover]) roundswitch(h-sliceat+wiredia/2,s=1,w=4);
                
                translate([0,ff,roundover]) cylinder(d=inch(2+1/8)*2/3-roundover,h=0.001);
                translate([-armwidth/2+roundover,(powerh(roundover)+armfrontr)/2-roundover,mountextraheight+roundover]) cube([armwidth-roundover*2,.001,h-.001-mountextraheight-roundover*2-.1]);
                translate([-mountwidth/2+roundover,(powerh(roundover)+armfrontr-roundover)/2,roundover]) cube([mountwidth-roundover*2,.001,mountextraheight-roundover*2]);
            for(x=poweroffsetsx) for (y=poweroffsetsy) translate([x,y,roundover]) cylinder(d=10,h=0.001);
            } 
            sphere(r=roundover);
        }
        translate([0,ff,h]) power();
        
        for(i=[1,-1]) translate([i*16,-ff+2,h+.002]) roundswitch(h-sliceat+wiredia/2);

        translate([-sbx/2,-ff/2-10,sliceat-wiredia/2])  difference() {
            cube([sbx,sby,sbz]);
    }
        
        //translate([-16,-ff/2,sliceat-wiredia/2]) cube([32,16,h-4-sliceat+wiredia/2]);
        
        
        translate([0,(powerh(roundover)+armfrontr)/2+armfrontr-armfrontrl,mountextraheight+0.001]) hull() {
            translate([armwidth/2-armfrontr,0,0]) cylinder(r=armfrontr,h=height-mountextraheight);
            translate([-armwidth/2+armfrontr,0,0]) cylinder(r=armfrontr,h=height-mountextraheight);
        }
        translate([0,(powerh(roundover)+armfrontr)/2+2.1,wirez+wall+slop]) rotate([90,0,0]) cylinder(d=wiredia,h=45);
        if (screws) for(x=poweroffsetsx) for (y=poweroffsetsy) translate([x,y,sliceat]) screw();
    }
}

module powermount(rotation=0) {
    render() rotate(45+rotation) translate([0,36,0]) {
        translate([0,(powerh(roundover)/2+armfrontrl),0]) rotate([0,0,180]) powerholder();
        translate([0,-(frontfrommount+mountdepth)/2,0]) chairmount(true,true);
    }
}
module power_mount_bottom_cover_area(plug=false) {
    render() minkowski() {
        rotate(180+45) translate([-22,63,0]) minkowski() {
            hull() {
                cube([43.5,22,14.5]);
                translate([43.5/2,35,0]) cylinder(r=12,h=14.5);
            }
            cylinder(r=4.5,h=0.001);
        }
        cylinder(r=plug?0:.45,h=plug?0:0.25);
    }	
}

module power_mount_top() { //test supported
    sliceat(height,sliceat,true) powermount();
}

module power_mount_bottom_full() { //test unsupported
    render() translate([+5,-5,0]) sliceat(height,sliceat,false) powermount(180);
}

module power_mount_bottom_open() { //test supportrd
    difference() {
        power_mount_bottom_full();
        power_mount_bottom_cover_area(false);
    }
}

module power_mount_bottom_cover() { //test unsupported
    intersection() {
        power_mount_bottom_full();
        power_mount_bottom_cover_area(true);
    }
}

module power_mount_bottom() { //test unsupported
    power_mount_bottom_open();
    power_mount_bottom_cover();
}

module power_mount_plate() { //make supported
    power_mount_bottom();
    power_mount_top();
}

power_mount_plate();

