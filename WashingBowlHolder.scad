$fn=100;

// Prusa i3 MK3S
maxBuildX = 250;
maxBuildY = 210;
maxBuildZ = 200;

barrierHeight = 100.75;
barrierWidth = 18.75;
sideWidth = 32;
lowerSideKnobWidth = 2;

bowlPlateWidth = 200;

handleWidth = (bowlPlateWidth*1.5 > maxBuildZ ? maxBuildZ : bowlPlateWidth*1.5);
handleStrength = 10;
handleSideHeight = bowlPlateWidth*0.4;
bowlWallHeight = handleStrength*3;

edgeSmoothness = 4;
cylinderHeight = 1;

$fn=100;

module roundCube(x=1, y=1, z=1, roundness=1, cylinderHeight=1) {
    translate([roundness,cylinderHeight,roundness]) minkowski() {
        color("red") cube([x-2*roundness, y-cylinderHeight, z-2*roundness]);
        rotate([90,0,0]) cylinder(r=roundness,h=cylinderHeight);
    }
}

module wedge(size = 15, height = 10, stretch = 1) {
    linear_extrude(height = height) polygon([[0,0],[0,size*stretch],[size,0]]);
}

cube([handleStrength, handleWidth, barrierHeight]);
color("pink") translate([0, 0, barrierHeight])
union() {
    x=barrierWidth+(2*handleStrength);
    y=handleWidth;
    z=handleStrength;
    roundCube(x, y, z, edgeSmoothness, cylinderHeight);
    cube([x, y, z/2]);
}

color("fuchsia") translate([barrierWidth+handleStrength, 0, 0]) cube([handleStrength, handleWidth, barrierHeight]);

color("red") union() {
    translate([barrierWidth+2*handleStrength,0,0]) roundCube(bowlPlateWidth, handleWidth, handleStrength, edgeSmoothness, cylinderHeight);
    translate([barrierWidth+2*handleStrength,0,0]) cube([bowlPlateWidth/2, handleWidth, handleStrength]);
    translate([barrierWidth+2*handleStrength,0,handleStrength/2]) cube([bowlPlateWidth, handleWidth, handleStrength/2]);
}

//translate([barrierWidth+handleStrength+bowlPlateWidth+handleStrength/2,0,handleStrength]) rotate([0,-90,0]) wedge(bowlWallHeight, bowlPlateWidth-handleStrength/2);
translate([barrierWidth+handleStrength+bowlPlateWidth,0,handleStrength]) rotate([0,-90,0]) wedge(bowlWallHeight, bowlPlateWidth-handleStrength);

//translate([barrierWidth+2*handleStrength,handleWidth,handleStrength]) rotate([180,-90,0]) wedge(bowlWallHeight, bowlPlateWidth-handleStrength/2);
translate([barrierWidth+2*handleStrength,handleWidth,handleStrength]) rotate([180,-90,0]) wedge(bowlWallHeight, bowlPlateWidth-handleStrength);


a = handleSideHeight;
b = bowlPlateWidth-(barrierWidth+sideWidth+2*handleStrength);
c = sqrt(pow(a,2)+pow(b,2));

color("aqua") union() {
    translate([barrierWidth+sideWidth+handleStrength,0,-handleSideHeight]) roundCube(handleStrength,handleWidth,handleSideHeight, edgeSmoothness, cylinderHeight);
    translate([barrierWidth+sideWidth+handleStrength,0,-handleSideHeight/2]) cube([handleStrength,handleWidth,handleSideHeight/2]);
}
translate([barrierWidth+sideWidth+handleStrength-lowerSideKnobWidth,0,-handleSideHeight+handleStrength/2]) cube([lowerSideKnobWidth,handleWidth,5]);
color("blue") translate([barrierWidth+sideWidth+handleStrength,0,-handleSideHeight+handleStrength]) rotate([0,62.5,0]) cube([handleStrength,handleWidth,c+2*handleStrength]);

union() { 
    translate([barrierWidth+handleStrength+bowlPlateWidth,0,handleStrength]) roundCube(handleStrength, handleWidth, bowlWallHeight, edgeSmoothness, cylinderHeight);
    //translate([barrierWidth+handleStrength+bowlPlateWidth,0,handleStrength]) cube([handleStrength/2, handleWidth, bowlWallHeight]);
    translate([barrierWidth+handleStrength+bowlPlateWidth,0,handleStrength]) cube([handleStrength, handleWidth, bowlWallHeight/2]);
}
