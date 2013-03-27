/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package aufgabe1a;

/**
 *
 * @author abl128
 */
public class Auto {

    //Variablen
    double mass;
    double powerPropMax;
    double speedMax;
    double level;
    double speed;
    double pos;
    double time;
    double accEarth;


    //Constructor
    public Auto(Double mass, Double powerPropMax, Double speedMax) {
        this.mass = mass;
        this.powerPropMax = powerPropMax;
        this.speedMax = speedMax;

        accEarth = 9.81;
    }

    //Methoden
    public void set(Double time, Double pos, Double speed, Double level) {
        this.time = time;
        this.pos = pos;
        this.speed = speed;
        this.level = level;
    }

    public void reset(Double time, Double pos, Double speed, Double level) {
        this.set(0.0, 0.0, 0.0, 0.0);
    }

    public void step(Double deltaTime, Double level) {
        //zunächst eine Bewegung mit der Startgeschwindigkeit ausführen
        pos = pos + (speed * deltaTime);

        //Gucken was noch raus muss - wichtig!
        double powerProp = Math.abs(level) * powerPropMax;
        double forcePropMax = mass * accEarth;
        double forcePropAbs = Math.min(forcePropMax, (powerProp / Math.abs(speed)));
        double forceProp = forcePropAbs * Math.signum(level);
        double dragConst = Math.abs(powerPropMax / (Math.pow(speedMax, 3)));
        double forceDrag = dragConst * Math.pow(speed, 2) * Math.signum(-1 * speed);
        double force = forceProp + forceDrag;
        double acc = force / mass;
        
        time = time + deltaTime;

        //neue Geschwindigkeit berechnen
        //#######level erneuern######
        speed = speed + (acc * deltaTime);


    }

    public void print() {
        System.out.println("");
        System.out.println("##############");
        System.out.println(time);
        System.out.println(pos);
        System.out.println(speed);
    }
}
