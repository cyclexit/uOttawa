class MyCurve extends THREE.Curve {
    constructor(k, l, r=20) {
        super();
        this.k = k; // inner radius = k * outer radius, 0 < k < 1
        this.l = l; // pen position
        this.r = r; // outer radius
    }

    getPoint(t) {
        t = t * Math.PI * 6;
        console.log(t);
        var tx = this.r * ((1 - this.k) * Math.cos(t) + this.l * this.k * Math.cos((1 - this.k) * t / this.k));
        var ty = this.r * ((1 - this.k) * Math.sin(t) - this.l * this.k * Math.sin((1 - this.k) * t / this.k));
        var tz = 5; // TODO: replace this
        return new THREE.Vector3(tx, ty, tz);
    }
}