use<./helpers.scad>;

zipwidth=4.5;
zipthickness=3;
    
    
clipx=4.43;
cliptrianglex=1.36;
cliptriangley=1.5;
cliplength=1.58;  
clipheight=1.4;

tabtrianglex=2.9;
tabtriangley=1.5;
tablength=4.02;  
tabheight=2.9+tabtriangley;

slop=0.2;
wall=1.2;

frontwidth=15;
frontheight=16.45;
frontlength=9;

backwidth=15.0;
backlength=1.3;
backheight=18.78;

cavitywidth=20.0;
cavitylength=31.6-frontlength-backlength;
cavityheight=30.5;
cavityoffset=-5.82;

jackbackpad=5;

reartabheight=3.3;
reartabwidth=5;
reartablength=10;

wall_height = 10;
wall_thickness = 4;
cliptriangletop=22;


module right_triangle_extrude(x,y,h) {
    translate([-x,0,-h/2])
    difference() {
        cube([x,y,h]);
        translate([0,0,-.5]) rotate(atan(y/x)) cube([x+y,x+y,h+1]);
    }
}
module clip2(trix,triy,length,height,width) {
    difference() {
        translate([0,-width/2,0]) cube([length+trix,width,height]);
        translate([-.001,0,-.001]) rotate([90,0,180]) right_triangle_extrude(trix,triy,width+.002);
    }
}
module clip(trix,triy,length,height,width) {
    union() {
        translate([0,-width/2,0]) cube([length+trix,width,height-triy]);
        translate([length,0,height-.001-triy]) rotate([90,0,180]) right_triangle_extrude(trix,triy,width+.002);
    }
}
module keystone(solid = false) {
    mirror([0,0,1]) rotate([0,180,0]) translate([0,-0.01,-frontheight/2]) 
    union() {
        translate([-frontwidth/2,0,0]) cube([frontwidth,frontlength+.001,frontheight]);
        translate([-backwidth/2,frontlength-0.001,0]) cube([backwidth,backlength+.001,frontheight]);
        translate([-cavitywidth/2,frontlength+backlength-0.001,cavityoffset]) cube([cavitywidth,cavitylength+.001,cavityheight]);
        translate([0,frontlength+backlength,frontheight-.001]) rotate([0,0,-90]) clip(tabtrianglex,tabtriangley,backlength,tabheight,frontwidth);
        #translate([0,frontlength+backlength,.001])rotate([0,0,-90]) mirror([0,0,1]) clip(cliptrianglex,cliptriangley,backlength,clipheight,frontwidth);
    }
}
module keystone2(solid = false) {
    rotate([0,180,0]) translate([0,-0.01,-frontheight/2]) 
    union() {
        translate([-frontwidth/2,0,0]) cube([frontwidth,frontlength+.001,frontheight]);
        translate([-backwidth/2,frontlength-0.001,0]) cube([backwidth,backlength+.001,backheight]);
        translate([-cavitywidth/2,frontlength+backlength-0.001,cavityoffset]) cube([cavitywidth,cavitylength+.001,cavityheight]);
        translate([0,frontlength+backlength,frontheight+tabheight-.001]) rotate([0,0,-90]) mirror([0,0,1]) clip2(tabtrianglex,tabtriangley,tablength,tabheight,frontwidth);
        translate([0,frontlength+backlength,-clipheight+.001])rotate([0,0,-90]) clip2(cliptrianglex,cliptriangley,cliplength,clipheight,frontwidth);
    }
}
module cavityarch(ir,or,w,t,a) {
    id=ir*2;
    od=or*2;
    rotate([90,0,0]) {
        intersection() {
            difference() {
                cylinder(r=or,h=w);
                translate([0,0,-0.001]) cylinder(r=ir,h=w+0.002);
            }
            translate([-or-0.001,0,-0.001]) cube([od+0.002,or+0.001,w+0.002]);
        }
        difference() {
            translate([-or,-a-0.001,0]) cube([od,a+0.002,w]);
            translate([-ir,-a-0.002,-0.001]) cube([id,a+0.004,w+0.002]);
        }
    }
}

keystonezipmountsliceat=cavityheight/2+wall;
ir=2+sqrt(pow(cavityheight/2,2)+pow(cavitywidth/2,2));
    or=(ir+zipthickness);
keystonezipmountheight=or+keystonezipmountsliceat+wall;

module keystonezipmount(r=0) {
    arch=keystonezipmountsliceat;
    w=or*2+2*wall;
    h=keystonezipmountheight;
    l=frontlength+backlength+cavitylength+wall*4;
    translate([0,-l/2,arch])
    difference() 
    { 
            translate([-w/2,0,-arch+.001]) cube([w,l,h]);
            keystone();
            translate([0,(cavitylength+2*zipwidth+frontlength+backlength)/2,0]) {
                translate([0,zipwidth*3,0]) cavityarch(ir,or,zipwidth,zipthickness,arch);
                cavityarch(ir,or,zipwidth,zipthickness,arch);
                translate([0,-zipwidth*3,0]) cavityarch(ir,or,zipwidth,zipthickness,arch);
            }
            rotate([-90,0,0]) cylinder(d=9,h=l+0.002);
        }
}

module keystonezipmounts() {
    o=8;
    s=48;
    b=0;
    y=1;
    s=1;
    for (x=[-2,0,2]) 
        //for(y=[-1,1]) 
            //for(s=[-1,1])
                translate([x*30,y*50+y*s*-25]) sliceat(keystonezipmountheight(),keystonezipmountsliceat(),s==1) keystonezipmount();
}
module keystonezipmountpair() {
    o=8;
    s=48;
    b=0;
    for (x=[1]) for(y=[1]) for(s=[-1,1])  translate([x*30,y*50+y*s*-25]) sliceat(keystonezipmountheight(),keystonezipmountsliceat(),s==1) keystonezipmount();
}

function keystonezipmountsliceat() = keystonezipmountsliceat;
function keystonezipmountheight() = keystonezipmountheight;
keystone(true);
!keystonezipmounts();
