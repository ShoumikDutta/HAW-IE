
/**
 * creates a roof geometry object
 * @param{number} l length of roof
 * @param{number} w width of roof
 * @param{number} h height of roof
 */
function createRoofGeo(l, w, h) {

    var geo = new THREE.Geometry();
    geo.vertices[0] = new THREE.Vector3(-w/2, 0, -l/2);
    geo.vertices[1] = new THREE.Vector3(w/2, 0, -l/2);
    geo.vertices[2] = new THREE.Vector3(0, h, -l/2);
    geo.vertices[3] = new THREE.Vector3(-w/2, 0, l/2);
    geo.vertices[4] = new THREE.Vector3(w/2, 0, l/2);
    geo.vertices[5] = new THREE.Vector3(0, h, l/2);

    geo.faces.push(new THREE.Face3(0,2,1));

    geo.faces.push(new THREE.Face3(0,3,2));
    geo.faces.push(new THREE.Face3(2,3,5));

    geo.faces.push(new THREE.Face3(0,1,4));
    geo.faces.push(new THREE.Face3(0,4,3));

    geo.faces.push(new THREE.Face3(1,2,5));
    geo.faces.push(new THREE.Face3(1,5,4));

    geo.faces.push(new THREE.Face3(3,4,5));

    return geo;
}
