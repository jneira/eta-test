import eta.example.MyClass;
import eta.example.Numbers;
import eta.example.Counter;
import eta.example.EtaCounter;

public class Utils {

    public static void main(String args[]) throws Exception {
        System.out.println("======== RUNNING  ===============");
        MyClass.sayHello();
        System.out.println("Zero: "+ Numbers.zero());
        System.out.println("One: "+ Numbers.one());
        System.out.println("Two: "+ Numbers.addTwo(0));

        EtaCounter d = new EtaCounter();
        d.set(10);
        System.out.println(d.decrement(5));
        System.out.println(d.get());
        // This does not work, Lib has no constructors
        // Lib myLib = new Lib();
        // System.out.println(myLib.instanceMethod(1));
        System.out.println("=================================");
    }

}
