
module light(s=0,bt=3,test=[1,-1]) {
    $fn=50;
    x=(3+7/16)*25.4/2;
    y=(1+1/16)*25.4/2;
    ct=2;
    tt=bt+ct;
    d=6.35;
    d2=d+3;
    d1=cos(45)*ct*2+d2;
    ld=sqrt(pow(x,2)+pow(y,2))*2+d1*1.02;
    
    echo(x,y,d1,ld);
    translate([0,ld/2,0]) {
        if (s==2) {
            cylinder(d=ld,h=bt);
        }
        if (s==1) {
                //translate([0,0,bt/2]) cube([x*2+d1,y*2+d1,bt],true);
            
                for(xo=test) for (yo=test) hull() {
                    translate([x*xo,y*yo,bt-0.001]) cylinder(d1=d1,d2=d2,h=tt-bt+0.001);
                    translate([x*xo,y*yo,0])cylinder(d=d1,h=bt);
                }
        }
        if (s==0) {
            for(xo=test) for (yo=test) {
                translate([x*xo,y*yo,-0.001])cylinder(d=d,h=tt+0.002);
            }
        }
    }
}

difference() {
    union() {
        light(2);
        light(1);
    }
    light(0);
}
        