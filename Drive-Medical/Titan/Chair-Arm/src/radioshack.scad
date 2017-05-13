testd=30;
testw=1;
extrar=5;
module square(d,t=4,s=0,w=.6,support=false) {
    dia=10.75;
    hdia=dia+2*extrar;
    mind = 18.25;
    inset=1;
    insetdia=sqrt(2*pow(15.2,2));
    insetfn=4;
    
    mount(d,t,s,w,dia,hdia,mind,insetdia,inset,insetfn,support);
}
module mount(d,t,s,w,dia,hdia,mind,insetdia,inset=1,insetfn=$fn,support=false) {
    hd=d-t;
    
    if (d<mind) echo(str("Insufficient depth for ",parent_module(1),", must be at least ",mind));
    
    mirror([0,0,1]) 
    union() {
        if (s==0) {
            difference() {
                union() {
                    translate([0,0,-0.002]) cylinder(d=dia,h=d+.004);
                    translate([0,0,t]) cylinder(d=hdia,h=hd+0.002);
                    translate([0,0,-0.002]) rotate(180/insetfn) cylinder(d=insetdia,h=inset+0.002,$fn=insetfn);
                }
                if (support) difference() {
                    translate([0,0,-0.004]) cylinder(d=dia+.4,h=d+0.008);
                    translate([0,0,-0.004]) cylinder(d=dia-.8,h=d+0.008);
                    translate([0,0,inset-0.25]) cylinder(d=dia+0.5,h=t-inset+.5);
                }
            }
        } else {
            cylinder(d=max(dia,hdia,insetdia)+2*w,h=d);
        }
    }
}

module roundswitch(d,t=4,s=0,w=.6,support=false) {
    
    dia=13.5;
    hdia=dia+2*extrar;
    hd=d-t;
    mind = 18.25;
    insetdia=17.25;
    
    mount(d,t,s,w,dia,hdia,mind,insetdia,support=support);
}

module roundbutton(d,t=4,s=0,w=.6,support=false) {
    dia=13.75;
    hdia=dia+2*extrar;
    mind = 18.25;
    insetdia=15.75;
    
    mount(d,t,s,w,dia,hdia,mind,insetdia,support=support);
}


module roundswitchTest(support=false) {
    rotate([180,0,0]) difference() {
        roundswitch(testd,s=1,w=testw,support=support);
        roundswitch(testd,s=0,w=testw,support=support);
    }
}

module roundbuttonTest(support=false) {
    rotate([180,0,0]) difference() {
        roundbutton(testd,s=1,w=testw,support=support);
        roundbutton(testd);
    }
}

module squareTest(support=false) {
    rotate([180,0,0]) difference() {
        square(testd,s=1,w=testw,support=support);
        square(testd);
    }
}

module roundSwitchTool(length=90) {
    nutdia=17;
    nuth=3;
    toolod = 13.75+2*extrar-2.5;
    toolid = nutdia*5.4/6;//toolod-4;
    
    
    
    washerd=nutdia+1.5;
    washerh=1.5;
    
    difference() {
        cylinder(d=toolod,h=length);
        translate([0,0,length-washerh]) cylinder(d=washerd,h=washerh++0.001);
        translate([0,0,length-washerh-nuth]) cylinder(d=nutdia,h=nuth+0.001,$fn=6);
        *translate([0,0,length-nuth*3]) hull() {
            translate([0,0,2*nuth+0.001]) cylinder(d=nutdia,$fn=6,h=0.001);
            cylinder(d=toolid,h=0.001);
        }
        translate([0,0,washerh-0.001]) cylinder(d=nutdia,h=nuth+0.001,$fn=6);
        *translate([0,0,nuth*3]) hull() {
            translate([0,0,-2*nuth-0.001]) cylinder(d=nutdia,$fn=6,h=0.001);
            cylinder(d=toolid,h=0.001);
        }
        translate([0,0,nuth+washerh-0.001]) cylinder(d=toolid,h=length-2*nuth-2*washerh+0.002);
        translate([0,0,]) difference() {
            translate([0,0,-0.001]) cylinder(d=washerd,h=washerh++0.001);
            translate([0,0,-0.002]) difference() {
                cylinder(d=nutdia+.4,h=washerh-0.25+0.002,$fn=6);
                translate([0,0,-0.001]) cylinder(d=nutdia+.4-4,h=washerh,$fn=6);
            }
        }
    }
}

!roundSwitchTool($fa=1,$fs=0.1,length=90);

roundswitch(20,support=true);

translate([60,0,0]) roundswitchTest(true);
/*
roundbuttonTest();
translate([-60,0,0]) squareTest();
*/
