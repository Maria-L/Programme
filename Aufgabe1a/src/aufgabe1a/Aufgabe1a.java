/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package aufgabe1a;

/**
 *
 * @author abl128
 */
public class Aufgabe1a {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Auto auto = new Auto(1445.0, 456000.0, 330.0);

        Integer i;
        Integer n;
        i = 0;
        n = 100;

        auto.set(1.0,1.0,1.0,1.0);
        while (auto.speed < n) {

            auto.print();
            auto.step(0.01, 1.0);

            i++;
        }
    }
}
