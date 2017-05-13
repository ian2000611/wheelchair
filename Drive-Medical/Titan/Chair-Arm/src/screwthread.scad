$fa=1;
$fs=.3;

function seriesnames(size="size") = [ for (i=[3:len(pitches[0])-1]) if (pitches[row(size)][i]!=-1) pitches[0][i] ];

function seriescolumn(name) = search([name],pitches[0])[0];
function namedrow(name) = search([name],pitches)[0];
function nominalrow(diameter) = lookup(diameter,[ for(i=[1:len(pitches)-1]) [pitches[i][2],i] ] );

function row(size,rounding=0) = str(size)==size?
        namedrow(size):
        (rounding==0?
            round(nominalrow(size)):
            (rounding>0?
                ceil(nominalrow(size)):
                floor(nominalrow(size))
            )
        );

function pitchraw(size,series) = pitches[row(size)][seriescolumn(series)];
function pitch(size,series) = (pitchraw(size,series)==-1?undef:pitchraw(size,series));
function nominal(size,rounding) = pitches[row(size,rounding)][seriescolumn("nominal")];
function nearestnominal(size,rounding) = pitches[row(size,rounding)][seriescolumn("nominal")];
function preferred(size,rounding) = pitches[row(size,rounding)][seriescolumn("preferred")]==1;
function name(size,rounding) = pitches[row(size,rounding)][seriescolumn("name")];


function utspitch(d,grain) = pitch(d,grain);
echo (seriesnames("1/2"));
for (i=[0.02*25.4,0.06*25.4,0.062*25.4,.072*25.4,17*25.4,"#8"]) for(j=[-1,0,1]) echo (row(i,j),i,name(i,j),nominal(i,j));
echo (preferred("#6"));

echo (preferred("#3"));

pitches = 
[["name","preferred","nominal","UNC","UNF","UNEF","4-UN","6-UN","8-UN","12-UN","16-UN","20-UN","28-UN","32-UN"],
["#0",1,0.0600*25.4,-1,80,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#1",-1,0.0730*25.4,64,72,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#2",1,0.0860*25.4,56,64,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#3",-1,0.0990*25.4,48,56,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#4",1,0.1120*25.4,40,48,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#5",1,0.1250*25.4,40,44,-1,-1,-1,-1,-1,-1,-1,-1,-1],
["#6",1,0.1380*25.4,32,40,-1,-1,-1,-1,-1,-1,-1,-1,32],
["#8",1,0.1640*25.4,32,36,-1,-1,-1,-1,-1,-1,-1,-1,32],
["#10",1,0.1900*25.4,24,32,-1,-1,-1,-1,-1,-1,-1,-1,32],
["#12",-1,0.2160*25.4,24,28,32,-1,-1,-1,-1,-1,-1,28,32],
["1/4",1,0.2500*25.4,20,28,32,-1,-1,-1,-1,-1,,28,32],
["5/16",1,0.3125*25.4,18,24,32,-1,-1,-1,-1,-1,20,28,32],
["3/8",1,0.3750*25.4,16,24,32,-1,-1,-1,-1,16,20,28,23],
["7/16",1,0.4375*25.4,14,20,28,-1,-1,-1,-1,16,20,28,32],
["1/2",1,0.5000*25.4,13,20,28,-1,-1,-1,-1,16,20,28,32],
["9/16",1,0.5625*25.4,12,18,24,-1,-1,-1,,16,20,28,32],
["5/8",1,0.6250*25.4,11,18,24,-1,-1,-1,12,16,20,28,32],
["11/16",-1,0.6875*25.4,-1,-1,24,-1,-1,-1,12,16,20,28,32],
["3/4",1,0.7500*25.4,10,16,20,-1,-1,-1,12,16,20,28,32],
["13/16",-1,0.8125*25.4,-1,-1,20,-1,-1,-1,12,16,20,28,32],
["7/8",1,0.8750*25.4,9,14,20,-1,-1,-1,12,16,20,28,32],
["15/16",-1,0.9375*25.4,-1,-1,20,-1,-1,-1,12,16,20,28,32],
["1",1,1.0000*25.4,8,12,20,-1,-1,8,12,16,20,28,32],
["1-1/16",-1,1.0625*25.4,-1,-1,18,-1,-1,8,12,16,20,28,-1],
["1-1/8",1,1.1250*25.4,7,12,18,-1,-1,8,12,16,20,28,-1],
["1-3/16",-1,1.1875*25.4,-1,-1,18,-1,-1,8,12,16,20,28,-1],
["1-1/4",1,1.2500*25.4,7,12,18,-1,-1,8,12,16,20,28,-1],
["1-5/16",-1,1.3125*25.4,-1,-1,18,-1,-1,8,12,16,20,28,-1],
["1-3/8",1,1.3750*25.4,6,12,18,-1,6,8,12,16,20,28,-1],
["1-7/16",-1,1.4375*25.4,-1,-1,18,-1,6,8,12,16,20,28,-1],
["1-1/2",1,1.5000*25.4,6,12,18,-1,6,8,12,16,20,28,-1],
["1-9/16",-1,1.5625*25.4,-1,-1,18,-1,6,8,12,16,20,-1,-1],
["1-5/8",1,1.6250*25.4,-1,-1,18,-1,6,8,12,16,20,-1,-1],
["1-11/16",-1,1.6875*25.4,-1,-1,18,-1,6,8,12,16,20,-1,-1],
["1-3/4",1,1.7500*25.4,5,-1,-1,-1,6,8,12,16,20,-1,-1],
["1-13/16",-1,1.8125*25.4,-1,-1,-1,-1,6,8,12,16,20,-1,-1],
["1-7/8",1,1.8750*25.4,-1,-1,-1,-1,6,8,12,16,20,-1,-1],
["1-15/16",-1,1.9375*25.4,-1,-1,-1,-1,6,8,12,16,20,-1,-1],
["2",1,2.0000*25.4,4-1/2,-1,-1,-1,6,8,12,16,20,-1,-1],
["21/8",-1,2.1250*25.4,-1,-1,-1,-1,6,8,12,16,20,-1,-1],
["2-1/4",1,2.2500*25.4,4+1/2,-1,-1,-1,6,8,12,16,20,-1,-1],
["2-3/8",-1,2.3750*25.4,-1,-1,-1,-1,6,8,12,16,20,-1,-1],
["2-1/2",1,2.5000*25.4,4,-1,-1,,6,8,12,16,20,-1,-1],
["2-5/8",-1,2.6250*25.4,-1,-1,-1,4,6,8,12,16,20,-1,-1],
["2-3/4",1,2.7500*25.4,4,-1,-1,4,6,8,12,16,20,-1,-1],
["2-7/8",-1,2.8750*25.4,-1,-1,-1,4,6,8,12,16,20,-1,-1],
["3",1,3.0000*25.4,4,-1,-1,4,6,8,12,16,20,-1,-1],
["3-1/8",-1,3.1250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-1/4",1,3.2500*25.4,4,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-3/8",-1,3.3750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-1/2",1,3.5000*25.4,4,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-5/8",-1,3.6250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-3/4",1,3.7500*25.4,4,-1,-1,4,6,8,12,16,-1,-1,-1],
["3-7/8",-1,3.8750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4",1,4.0000*25.4,4,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-1/8",-1,4.1250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-1/4",1,4.2500*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-3/8",-1,4.3750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-1/2",1,4.5000*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-5/8",-1,4.6250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-3/4",1,4.7500*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["4-7/8",-1,4.8750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5",1,5.0000*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-1/8",-1,5.1250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-1/4",1,5.2500*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-3/8",-1,5.3750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-1/2",1,5.5000*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-5/8",-1,5.6250*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-3/4",1,5.7500*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["5-7/8",-1,5.8750*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1],
["6",1,6.0000*25.4,-1,-1,-1,4,6,8,12,16,-1,-1,-1]]
;


function unc(d) = uts(d,utspitch(d,"unc"));
module uncscrew(d,l,rt=0) { screw(unc(d),l,rt); }

function unf(d) = uts(d,utspitch(d,"unf"));
module unfscrew(d,l,rt=0) { screw(unf(d),l,rt); }

function unef(d) = uts(d,utspitch(d,"unef"));
module unefscrew(d,l,rt=0) { screw(unef(d),l,rt); }

function nunc(d) = n(d,utspitch(ndia(d),"unc"));
module nuncscrew(n,l,rt=0) { screw(nunc(n),l,rt); }

function nunf(d) = n(d,utspitch(ndia(d),"unf"));
module nunfscrew(n,l,rt=0) { screw(nunf(n),l,rt); }

function nunef(d) = n(d,utspitch(ndia(d),"unef"));
module nunefscrew(n,l,rt=0) { screw(nunef(n),l,rt); }

function metric(dmaj,p,pa=60) = [
    ["dmaj",dmaj],
    ["p",p],
    ["pa",pa],
    ["h",p/(2*tan(pa/2))],
    ["dmin",dmaj-(p/(2*tan(pa/2)))*10/8],
    ["dp",dmaj-(p/(2*tan(pa/2)))*6/8]
];    

function screw_param(screw,param) = screw[search([param],screw,1)[0]][1];


//nuncscrew(8,3,1);
translate([0,0,2]) screw(metric(5,.8),10);
// translate([10,0,0]) metricscrew(4.1656,0.7938,3,1);




module metricscrew(diameter,pitch,l,rt=0) {
    screw(metric(diameter,pitch),l,rt);
}
module screw(screw,l,rt=0) {
    dmaj = screw_param(screw,"dmaj");
    dmin = screw_param(screw,"dmin");
    h = screw_param(screw,"h");
    p = screw_param(screw,"p");
    pa = screw_param(screw,"pa");
    echo(dmaj,dmin,p,h,pa);
    
    sfa=ceil(360/$fa);
    sfs=ceil(dmaj*3.14159/$fs);
    s=($fn==0?min(sfa,sfs):$fn);
    a=360/s;
    echo (sfa,sfs,$fn,s,a);
    
    pc=ceil(l/p);
    
    intersection() {
        cylinder(d=dmaj+h,h=l);
    
        for (pn=[0:pc])
        translate([0,0,p*(pn-0.5)])
        thread3d(dmaj,dmin,h,p,pa,s,a,rt);
    }
}
module thread3d(dmaj,dmin,h,p,pa,s,a,ra,rt) {
    rtm = (rt==0?1:-1);
    for (sn=[0:s-1]) translate([0,0,(p/s)*sn]) rotate([0,0,(a)*sn*rtm]) union() {
        screwhull(a,s,p,rtm) {
            translate([0,0,-p/2]) sphere(0.001);
            translate([0,0,p/2]) sphere(0.001);
            translate([dmin/2,0,-p/2]) sphere(0.001);
            translate([dmin/2,0,-p/2+p/8]) sphere(0.001);
        }
        
        screwhull(a,s,p,rtm) {
            translate([0,0,-p/2]) sphere(0.001);
            translate([0,0,p/2]) sphere(0.001);
            translate([dmaj/2,0,-p/16]) sphere(0.001);
            translate([dmin/2,0,-p/2+p/8]) sphere(0.001);
        }
        
        screwhull(a,s,p,rtm) {
            translate([0,0,-p/2]) sphere(0.001);
            translate([0,0,p/2]) sphere(0.001);
            translate([dmaj/2,0,-p/16]) sphere(0.001);
            translate([dmaj/2,0,p/16]) sphere(0.001);
        }
        
        screwhull(a,s,p,rtm) {
            translate([0,0,-p/2]) sphere(0.001);
            translate([0,0,p/2]) sphere(0.001);
            translate([dmaj/2,0,p/16]) sphere(0.001);
            translate([dmin/2,0,p/2-p/8]) sphere(0.001);
        }
        
        screwhull(a,s,p,rtm) {
            translate([0,0,-p/2]) sphere(0.001);
            translate([0,0,p/2]) sphere(0.001);
            translate([dmin/2,0,p/2]) sphere(0.001);
            translate([dmin/2,0,p/2-p/8]) sphere(0.001);
        }
    }
}
module screwhull(a,s,p,rtm) {
    hull() {
        children(0);
        children(1);
        
        rotate(-a/2*rtm) translate([0,0,-p/s/2]) children(2);
        rotate(-a/2*rtm) translate([0,0,-p/s/2]) children(3);
        
        rotate(a/2*rtm) translate([0,0,p/s/2]) children(2);
        rotate(a/2*rtm) translate([0,0,p/s/2]) children(3);
    }
}

    