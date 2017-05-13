function dsink(dmaj) = dmaj*2.35-2.08;//
function hsink(dmaj,angle) = sin(90-angle/2)*((dsink(dmaj)-dmaj)/2/sin(angle/2));
function dmin(screw) = screw[0]-1.082532*screw[1];
function dp(screw) = screw[0]-0.649519*screw[1];
function dfree(screw) = screw[0]+0.649519*screw[1];
function dsinkfree(screw) = dsink(dfree(screw));
function hsinkfree(screw,angle) = hsink(dfree(screw),angle);
function num(n) =  n * 0.013 + 0.060;
function inch(i) = i*25.4;
function p(size,thread) =(thread=="extrafine"?pow(size,.5)/3.8:(thread=="fine"?pow(size,.6)/3.4:pow(size,.7)/3));

function profile(screw,screwlength,angle=82,headlength=2.54) = [
    screw[1],
    screw[0],
    dsinkfree(screw,angle,headlength),
    dsink(screw[0],angle,headlength),
    dfree(screw),
    dp(screw),
    dmin(screw),
    screwlength,
    hsink(screw[0],angle),
    hsinkfree(screw,angle)
];

function screw(size) = [size,p(size)];

function screwprofile(size,screwlength,angle=82,headlength=2.54) = profile(screw(size),screwlength,angle,headlength);

function inchprofile(size,screwlength,angle=82,headlength=2.54) = screwprofile(inch(size),screwlength,angle,headlength);

function numprofile(size,screwlength,angle=82,headlength=2.54) = inchprofile(num(size),screwlength,angle,headlength);

module screw(profile=numprofile(6,inch(.75)),depth=inch(.3),extralength=20,bitdia=0) {
        union() { //used to highlight screws without their extra hole length
            translate([0,0,depth+.001]) cylinder(d1=profile[5],d2=.001,h=profile[5]/2);
            cylinder(d=profile[5],h=depth+.001);
            cylinder(d1=profile[4],d2=profile[5],h=profile[4]-profile[5]);
        
            mirror([0,0,1]) {
                translate([0,0,-.001]) cylinder(d=profile[4],h=profile[7]-depth+.001);
                translate([0,0,profile[7]-profile[9]-depth]) cylinder(d2=profile[2],d1=profile[4],h=profile[9]);
                
                if (bitdia!=0) {
                    #translate([0,0,profile[7]-depth-0.001]) cylinder(d2=bitdia,d1=profile[2],h=(bitdia-profile[2]));
                }
                    
            }
        }
        if (bitdia==0) {
            mirror([0,0,1]) translate([0,0,profile[7]-depth-.001]) cylinder(d=profile[2],h=extralength+.001);
        } else {
            mirror([0,0,1]) translate([0,0,profile[7]-depth-.002+(bitdia-profile[2])]) cylinder(d=bitdia,h=extralength+.001);
        }
        
    
    
}

screw();
